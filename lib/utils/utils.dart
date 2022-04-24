bool isNumeric(String s) {
  if (s.isEmpty) return false;
  //Vai saber se pode passar pra numero
  final n = num.tryParse(s);
  //se n nao der certo vai retornar falso
  return (n == null) ? false : true;
}
