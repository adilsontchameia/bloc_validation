import 'package:bloc_validation/bloc/provider.dart';
import 'package:bloc_validation/src/providers/usuario_provider.dart';
import 'package:flutter/material.dart';

class RegistroPage extends StatelessWidget {
  RegistroPage({Key key}) : super(key: key);
  final usuarioProvider = new UsuarioProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _criarFundo(context),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          SafeArea(
              child: Container(
            height: 180.0,
          )),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0)
            ], color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
            child: Column(
              children: [
                Text('Criar Conta', style: TextStyle(fontSize: 20.0)),
                SizedBox(height: 60.0),
                _criarEmail(bloc),
                SizedBox(height: 30.0),
                _criarPassword(bloc),
                SizedBox(height: 30.0),
                _criarBotao(bloc)
              ],
            ),
          ),
          FlatButton(
              onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
              child: Text('Ja tem uma conta ?')),
          SizedBox(height: 100.0),
        ],
      ),
    );
  }

  Widget _criarEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              icon: Icon(
                Icons.alternate_email,
                color: Colors.deepPurple,
              ),
              hintText: 'meuexemplo@gmail.com',
              labelText: 'Endereco de Email',
              counterText: snapshot.data,
              errorText: snapshot.error,
            ),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _criarPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_outline,
                  color: Colors.deepPurple,
                ),
                labelText: 'Palavra-Passe',
                counterText: snapshot.data,
                errorText: snapshot.error,
              ),
              onChanged: bloc.changePassword,
            ));
      },
    );
  }

  Widget _criarBotao(LoginBloc bloc) {
    // ignore: deprecated_member_use
    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Entrar'),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          onPressed: snapshot.hasData ? () => _register(bloc, context) : null,
        );
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) {
    usuarioProvider.novoUsuario(bloc.email, bloc.passowrd);
    // Navigator.pushReplacementNamed(context, 'home');
  }

  Widget _criarFundo(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final fundoMudado = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(63, 63, 156, 1.0),
        Color.fromRGBO(90, 70, 178, 1.0),
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.09),
      ),
    );
    return Stack(
      children: [
        fundoMudado,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, right: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Positioned(bottom: -50.0, left: -20.0, child: circulo),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              Icon(
                Icons.person_pin,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'Adilson Tchameia',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
