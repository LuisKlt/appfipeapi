class Marca {
  final String codigo;
  final String nome;

  Marca({required this.codigo, required this.nome});

  factory Marca.fromJson(Map<String, dynamic> json) {
    return Marca(
      codigo: json['codigo'],
      nome: json['nome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'nome': nome,
    };
  }
}
