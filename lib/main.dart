import 'package:bloc_validation/bloc/provider.dart';
import 'package:bloc_validation/src/pages/home_page.dart';
import 'package:bloc_validation/src/pages/login_page.dart';
import 'package:bloc_validation/src/pages/producto_page.dart';
import 'package:bloc_validation/src/pages/registro_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'registro': (BuildContext context) => RegistroPage(),
          'home': (BuildContext context) => HomePage(),
          'producto': (BuildContext context) => ProductoPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
