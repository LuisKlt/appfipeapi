class Carro {
  int? id;
  String marca;
  String modelo;
  String cor;
  String ano;
  String motor;
  String kilometragem;
  String opcionais;
  String preco;

  Carro({
    this.id,
    required this.marca,
    required this.modelo,
    required this.cor,
    required this.ano,
    required this.motor,
    required this.kilometragem,
    required this.opcionais,
    required this.preco,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'marca': marca,
      'modelo': modelo,
      'cor': cor,
      'ano': ano,
      'motor': motor,
      'kilometragem': kilometragem,
      'opcionais': opcionais,
      'preco': preco,
    };
  }

  factory Carro.fromMap(Map<String, dynamic> map) {
    return Carro(
      id: map['id'],
      marca: map['marca'],
      modelo: map['modelo'],
      cor: map['cor'],
      ano: map['ano'],
      motor: map['motor'],
      kilometragem: map['kilometragem'],
      opcionais: map['opcionais'],
      preco: map['preco'],
    );
  }
}
