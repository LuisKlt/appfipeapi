import 'package:appfipeapi/apiService.dart';
import 'package:appfipeapi/main.dart';
import 'package:flutter/material.dart';

class CarroInfo extends StatefulWidget {
  final String marca;
  final int modelo;
  final String ano;
  const CarroInfo(
      {super.key,
      required this.marca,
      required this.modelo,
      required this.ano});

  @override
  CarroInfoState createState() => CarroInfoState();
}

class CarroInfoState extends State<CarroInfo> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const FipeApp()),
            );
          },
        ),
        title: const Text('Fipe App'),
        backgroundColor: const Color.fromARGB(255, 0, 91, 136),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<String>(
        future: apiService.getInfo(widget.marca, widget.modelo, widget.ano),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhuma informação disponível'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(snapshot.data!, style: const TextStyle(fontSize: 16)),
            );
          }
        },
      ),
    );
  }
}
