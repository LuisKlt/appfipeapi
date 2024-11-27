class Ano {
  final String codigo;
  final String nome;

  Ano({required this.codigo, required this.nome});

  factory Ano.fromJson(Map<String, dynamic> json) {
    return Ano(
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
