//Responsavel pela interacao com a base de dados
import 'dart:convert';
import 'dart:io';
import 'package:bloc_validation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:bloc_validation/src/models/produto_model.dart';
import 'package:mime_type/mime_type.dart';

class ProdutosProvider {
  final String _url =
      'https://flutter-varios-2fc60-default-rtdb.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

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

  Future<bool> editarProduto(ProdutoModel produto) async {
    //Onde se fara POST
    final url = '$_url/produtos/${produto.id}.json?auth=${_prefs.token}';
    final resp =
        await http.put(Uri.parse(url), body: produtoModelToJson(produto));
    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<ProdutoModel>> carregarProdutos() async {
    final url = '$_url/produtos.json?auth=${_prefs.token}';
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

  Future<bool> apagarProduto(String id) async {
    final url = '$_url/produtos/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(Uri.parse(url));

    print(resp.body);

    return true;
  }

  Future<String> uploadImagem(File imagem) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/adilsonchameia/image/upload?upload_preset=kzc4cd4a');
    final mimeType = mime(imagem.path).split('/'); //image/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', imagem.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);

    //Executar a peticao
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo ocorreu mal');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}
