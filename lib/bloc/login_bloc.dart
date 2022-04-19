import 'dart:async';
import 'package:bloc_validation/bloc/validators.dart';
//Streams
//Vao controlar a pass e o email
//E vai controlar quando estao corretos e errados

class LoginBloc with Validators {
  final _emailController = StreamController<String>.broadcast();
  final _passwordController = StreamController<String>.broadcast();

  //Recuperar os dados do Stream
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  //Inserir valores ao Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  //Fechar a conexao
  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}
