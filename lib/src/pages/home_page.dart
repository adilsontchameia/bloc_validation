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
          // ignore: missing_return
          (BuildContext context, AsyncSnapshot<List<ProdutoModel>> snapshot) {
        if (snapshot.hasData) {
          final produtos = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, i) => _criarItem(context, produtos[i]),
            itemCount: produtos.length,
          );
        } else {
          Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _criarItem(BuildContext context, ProdutoModel produtoModel) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direcao) {
        produtosProvider.apagarProduto(produtoModel.id);
      },
      child: ListTile(
        title: Text('${produtoModel.titulo} - ${produtoModel.valor}'),
        subtitle: Text(produtoModel.id),
        onTap: () =>
            Navigator.pushNamed(context, 'producto', arguments: produtoModel),
      ),
    );
  }

  _criarBotao(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, 'producto'),
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
    );
  }
}
