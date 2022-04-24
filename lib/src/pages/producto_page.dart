import 'package:bloc_validation/src/models/produto_model.dart';
import 'package:bloc_validation/src/providers/produtos_provider.dart';
import 'package:bloc_validation/utils/utils.dart' as utils;
import 'package:flutter/material.dart';

class ProductoPage extends StatefulWidget {
  ProductoPage({Key key}) : super(key: key);

  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
  final formKey = GlobalKey<FormState>();
  ProdutoModel produto = new ProdutoModel();
  final produtoProvider = new ProdutosProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        actions: [
          IconButton(
              icon: Icon(Icons.photo_size_select_actual), onPressed: () {}),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
              key: formKey,
              child: Column(
                children: [
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
      onPressed: () => _submit(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      icon: Icon(Icons.save),
      label: Text('Save'),
    );
  }

  void _submit() {
    if (!formKey.currentState.validate()) return;
    //Executar todos onSaved
    formKey.currentState.save();
    print('TUDO OK');
    print(produto.titulo);
    print(produto.valor);
    print(produto.disponivel);

    produtoProvider.criarProduto(produto);
  }
}
