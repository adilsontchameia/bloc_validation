bool isNumeric(String s) {
  if (s.isEmpty) return false;
  //Vai saber se pode passar pra numero
  var number = num.tryParse(s);
  //se n nao der certo vai retornar falso
  return (number = null) ? false : true;
}
