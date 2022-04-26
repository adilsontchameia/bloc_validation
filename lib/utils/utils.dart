import 'package:flutter/material.dart';

bool isNumeric(String s) {
  if (s.isEmpty) return false;
  //Vai saber se pode passar pra numero
  final n = num.tryParse(s);
  //se n nao der certo vai retornar falso
  return (n == null) ? false : true;
}

void mostrarAlerta(BuildContext context, String sms) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'AVISO',
          style: TextStyle(color: Colors.red),
        ),
        content: Text(sms),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('OK'))
        ],
      );
    },
  );
}
