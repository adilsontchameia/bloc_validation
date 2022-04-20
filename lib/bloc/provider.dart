import 'package:bloc_validation/bloc/login_bloc.dart';
export 'package:bloc_validation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  //Padrao singleton
  static Provider _instancia;
  //Vai determinar se preciso usar uma nova instancia, ou usar acima, corrente.
  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }
  final loginBloc = LoginBloc();

  //Construtor
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  //Ao atualizar deve atualizar
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).loginBloc;
  }
}
