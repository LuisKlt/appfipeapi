class Modelo {
  final int codigo;
  final String nome;

  Modelo({required this.codigo, required this.nome});

  factory Modelo.fromJson(Map<String, dynamic> json) {
    return Modelo(
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
