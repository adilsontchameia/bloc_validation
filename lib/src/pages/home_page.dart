import 'package:bloc_validation/bloc/provider.dart';
import 'package:bloc_validation/src/models/produto_model.dart';
import 'package:bloc_validation/src/providers/produtos_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  final produtosProvider = new ProdutosProvider();
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: _criarLista(),
      floatingActionButton: _criarBotao(context),
    );
  }

  _criarLista() {
    return FutureBuilder(
      future: produtosProvider.carregarProdutos(),
      builder:
          (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
        if (snapshot.hasData) {
          return Container();
        } else {
          Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

_criarBotao(BuildContext context) {
  return FloatingActionButton(
    onPressed: () => Navigator.pushNamed(context, 'producto'),
    child: Icon(Icons.add),
    backgroundColor: Colors.deepPurple,
  );
}
