import 'package:bloc_validation/bloc/login_bloc.dart';
export 'package:bloc_validation/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final loginBloc = LoginBloc();

  //Construtor
  Provider({Key key, Widget child}) : super(key: key, child: child);

  //Ao atualizar deve atualizar
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<Provider>()).loginBloc;
  }
}
