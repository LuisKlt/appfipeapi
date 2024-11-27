import 'package:appfipeapi/marcaSearch.dart';
import 'package:appfipeapi/carroTela.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FipeApp());
}

class FipeApp extends StatefulWidget {
  const FipeApp({super.key});
  @override
  State<FipeApp> createState() => _FipeAppState();
}

class _FipeAppState extends State<FipeApp> {
  int telaSelecionada = 0;

  void opcaoSelecionada(int opcao) {
    setState(() {
      telaSelecionada = opcao;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> listaTelas = <Widget>[
      const MarcaSearch(),
      const CarroTela(),
    ];

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Fipe App",
        home: Scaffold(
          appBar: AppBar(
            title: const Text("Fipe App"),
            backgroundColor: const Color.fromARGB(255, 0, 91, 136),
            foregroundColor: Colors.white,
          ),
          body: Center(child: listaTelas[telaSelecionada]),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: const Color.fromARGB(255, 94, 94, 94),
            fixedColor: const Color.fromARGB(255, 0, 91, 136),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.calculate_rounded),
                label: 'Tabela Fipe',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.car_rental_rounded),
                label: 'Carros',
              ),
            ],
            currentIndex: telaSelecionada,
            onTap: opcaoSelecionada,
          ),
        ));
  }
}
