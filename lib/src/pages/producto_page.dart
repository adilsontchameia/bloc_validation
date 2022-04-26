import 'dart:io';
import 'package:bloc_validation/src/models/produto_model.dart';
import 'package:bloc_validation/src/providers/produtos_provider.dart';
import 'package:bloc_validation/utils/utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
  ProductoPage({Key key}) : super(key: key);

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  ProdutoModel produto = new ProdutoModel();
  final produtoProvider = new ProdutosProvider();
  bool _guardado = false;
  File image;

  @override
  Widget build(BuildContext context) {
    final ProdutoModel produtoData = ModalRoute.of(context).settings.arguments;
    if (produtoData != null) {
      produto = produtoData;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _imageGalery,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _imageCamera,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  _mostrarFoto(),
                  _criarNome(),
                  _criarPreco(),
                  _criarDisponivel(),
                  _criarBotao(),
                ],
              )),
        ),
      ),
    );
  }

  Widget _criarNome() {
    return TextFormField(
      initialValue: produto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product',
      ),
      onSaved: (value) => produto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return ' Informe o nome do produto';
        } else {
          return null;
        }
      },
    );
  }

  Widget _criarPreco() {
    return TextFormField(
      initialValue: produto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price',
      ),
      //value as double
      onSaved: (value) => produto.valor = double.parse(value),
      // ignore: missing_return
      validator: (value) {
        if (utils.isNumeric(value)) {
        } else {
          return 'Introduza um numero valido';
        }
      },
    );
  }

  Widget _criarDisponivel() {
    return SwitchListTile(
      activeColor: Colors.deepPurple,
      value: produto.disponivel,
      onChanged: (value) => setState(() {
        produto.disponivel = value;
      }),
      title: Text('Disponivel'),
    );
  }

  Widget _criarBotao() {
    return RaisedButton.icon(
      onPressed: () => (_guardado) ? null : _submit(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      icon: Icon(Icons.save),
      label: Text('Save'),
    );
  }

  void _submit() async {
    //
    if (!formKey.currentState.validate()) return;
    //Executar todos onSaved
    formKey.currentState.save();

    setState(() {
      _guardado = true;
    });

    if (image != null) {
      produto.fotoUrl = await produtoProvider.uploadImagem(image);
    }
    if (produto.id == null) {
      produtoProvider.criarProduto(produto);
      _mostrarSnackBar('Registro Guardado Com Sucesso.');
    } else {
      produtoProvider.editarProduto(produto);
      _mostrarSnackBar('Registro Editado Com Sucesso.');
    }

    Navigator.pop(context);
  }

  void _mostrarSnackBar(String sms) {
    final snackBar = SnackBar(
      // backgroundColor: Colors.deepPurple,
      content: Text(sms),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget _mostrarFoto() {
    if (produto.fotoUrl != null) {
      return FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          fit: BoxFit.contain,
          height: 300,
          image: NetworkImage(produto.fotoUrl));
    } else {
      return Image(
        //Se a foto tem informacao, e a informacao tem algo, vai mostrar a imagem
        //Senao, vai mostrar a imagem padrao
        image: AssetImage(image?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _imageGalery() {
    _buscarImagem(ImageSource.gallery);
  }

  _imageCamera() {
    _buscarImagem(ImageSource.camera);
  }

  _buscarImagem(ImageSource fonte) async {
    final image = await ImagePicker().pickImage(source: fonte);

    if (image != null) {
      produto.fotoUrl = null;
    }

    final imageTemp = File(image.path);

    setState(() => this.image = imageTemp);
  }
}
