import 'dart:async';

class Validators {
  //1 String entrada
  //2 String saida
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    //Vai dizer ao stream transformer, que informacao decorrem ou se precisa notificar.
    //Se ha um erro vai bloquear
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Mais de seis caracteres');
    }
  });

  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    //Vai dizer ao stream transformer, que informacao decorrem ou se precisa notificar.
    //Se ha um erro vai bloquear
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email Incorrecto.');
    }
  });
}
