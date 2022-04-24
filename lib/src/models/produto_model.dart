// To parse this JSON data, do
//
//     final produtoModel = produtoModelFromJson(jsonString);

import 'dart:convert';

//Recebe um Json em forma de String
ProdutoModel produtoModelFromJson(String str) =>
    ProdutoModel.fromJson(json.decode(str));
//Pega o modelo e gera por um Json
String produtoModelToJson(ProdutoModel data) => json.encode(data.toJson());

class ProdutoModel {
  ProdutoModel({
    this.id,
    this.titulo = '',
    this.valor = 0.0,
    this.disponivel = true,
    this.fotoUrl,
  });

  String id;
  String titulo;
  double valor;
  bool disponivel;
  String fotoUrl;

  //Esta regressando uma nova instancia
  factory ProdutoModel.fromJson(Map<String, dynamic> json) => ProdutoModel(
        id: json["id"],
        titulo: json["titulo"],
        valor: json["valor"],
        disponivel: json["disponivel"],
        fotoUrl: json["fotoUrl"],
      );
  //Pegando o modelo e colcoando em Json.
  Map<String, dynamic> toJson() => {
        // "id": id,
        "titulo": titulo,
        "valor": valor,
        "disponivel": disponivel,
        "fotoUrl": fotoUrl,
      };
}
