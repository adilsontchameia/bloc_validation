import 'dart:convert';

import 'package:http/http.dart' as http;

class UsuarioProvider {
  final String _firebaseToken = 'AIzaSyAEQuihrfTUYwyvnb22AD6MlzCfljJ2hj8';

  Future novoUsuario(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true,
    };

    final resp = await http.post(
      Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${_firebaseToken}'),
      body: json.encode(authData),
    );

    Map<String, dynamic> decodeResp = json.decode(resp.body);

    print(decodeResp);

    if (decodeResp.containsKey('idToken')) {
      //TODO Salvar o token no stoarege
      return {'ok': true, 'token': decodeResp['idToken']};
    } else {
      return {'ok': false, 'sms': decodeResp['error']['message']};
    }
  }
}
