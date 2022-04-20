import 'dart:async';
import 'package:bloc_validation/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
//Streams
//Vao controlar a pass e o email
//E vai controlar quando estao corretos e errados

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //Recuperar os dados do Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  //Validar quando os dois stream estao certos ou certos
  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (a, p) => true);
  //Inserir valores ao Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  //Obter ultimo valor inserido aos streams
  String get email => _emailController.value;
  String get passowrd => _passwordController.value;
  //Fechar a conexao
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
