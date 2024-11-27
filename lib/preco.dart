class Preco {
  final int TipoVeiculo;
  final String Valor;
  final String Marca;
  final String Modelo;
  final int AnoModelo;
  final String Combustivel;
  final String CodigoFipe;
  final String MesReferencia;
  final String SiglaCombustivel;

  Preco({
    required this.TipoVeiculo,
    required this.Valor,
    required this.Marca,
    required this.Modelo,
    required this.AnoModelo,
    required this.Combustivel,
    required this.CodigoFipe,
    required this.MesReferencia,
    required this.SiglaCombustivel,
  });

  factory Preco.fromJson(Map<String, dynamic> json) {
    return Preco(
      TipoVeiculo: json['TipoVeiculo'],
      Valor: json['Valor'],
      Marca: json['Marca'],
      Modelo: json['Modelo'],
      AnoModelo: json['AnoModelo'],
      Combustivel: json['Combustivel'],
      CodigoFipe: json['CodigoFipe'],
      MesReferencia: json['MesReferencia'],
      SiglaCombustivel: json['SiglaCombustivel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'TipoVeiculo': TipoVeiculo,
      'Valor': Valor,
      'Marca': Marca,
      'Modelo': Modelo,
      'AnoModelo': AnoModelo,
      'Combustivel': Combustivel,
      'CodigoFipe': CodigoFipe,
      'MesReferencia': MesReferencia,
      'SiglaCombustivel': SiglaCombustivel,
    };
  }
}
