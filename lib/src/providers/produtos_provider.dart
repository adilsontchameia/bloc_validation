//Responsavel pela interacao com a base de dados
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:bloc_validation/src/models/produto_model.dart';

class ProdutosProvider {
  final String _url =
      'https://flutter-varios-2fc60-default-rtdb.firebaseio.com';
  //Criar produtos para colocar no firebase
  Future<bool> criarProduto(ProdutoModel produto) async {
    //Onde se fara POST
    final url = '$_url/produtos.json';
    final resp =
        await http.post(Uri.parse(url), body: produtoModelToJson(produto));
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<ProdutoModel>> carregarProdutos() async {
    final url = '$_url/produtos.json';
    final resp = await http.get(Uri.parse(url));

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ProdutoModel> produtos = new List();
    if (decodedData == null) return [];
    decodedData.forEach((id, produto) {
      final prodTemp = ProdutoModel.fromJson(produto);
      prodTemp.id = id;

      produtos.add(prodTemp);
    });
    print(produtos);
    return produtos;
  }
}
