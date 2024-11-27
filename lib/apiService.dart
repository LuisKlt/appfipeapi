import 'dart:convert';
import 'package:appfipeapi/ano.dart';
import 'package:appfipeapi/marca.dart';
import 'package:appfipeapi/modelo.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Marca>> getMarcas() async {
    final response = await http
        .get(Uri.parse('https://parallelum.com.br/fipe/api/v1/carros/marcas'));

    if (response.statusCode == 200) {
      List<dynamic> marcasJson = jsonDecode(response.body);
      return marcasJson.map((dynamic item) {
        return Marca.fromJson(item);
      }).toList();
    }
    return [];
  }

  Future<List<Modelo>> getModelos(String codigoMarca) async {
    final response = await http.get(Uri.parse(
        'https://parallelum.com.br/fipe/api/v1/carros/marcas/$codigoMarca/modelos'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<dynamic> modelosJson = data['modelos'];
      return modelosJson.map((dynamic item) {
        return Modelo.fromJson(item);
      }).toList();
    }
    return [];
  }

  Future<List<Ano>> getAnos(String codigoMarca, int codigoModelo) async {
    final response = await http.get(Uri.parse(
        'https://parallelum.com.br/fipe/api/v1/carros/marcas/$codigoMarca/modelos/$codigoModelo/anos'));

    if (response.statusCode == 200) {
      List<dynamic> anosJson = jsonDecode(response.body);
      return anosJson.map((dynamic item) {
        return Ano.fromJson(item);
      }).toList();
    }
    return [];
  }

  Future<String> getInfo(
      String codigoMarca, int codigoModelo, String codigoAno) async {
    final response = await http.get(Uri.parse(
        'https://parallelum.com.br/fipe/api/v1/carros/marcas/$codigoMarca/modelos/$codigoModelo/anos/$codigoAno'));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      String dadosCarro = '';
      dadosCarro += 'Marca: ${data['Marca']}\n';
      dadosCarro += 'Modelo: ${data['Modelo']}\n';
      dadosCarro += 'Ano: ${data['AnoModelo']}\n';
      dadosCarro += 'Valor: ${data['Valor']}\n';
      dadosCarro += 'Combustível: ${data['Combustivel']}\n';
      dadosCarro += 'Mês de Referência: ${data['MesReferencia']}\n';
      return dadosCarro;
    }

    return '';
  }
}
