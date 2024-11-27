import 'package:appfipeapi/carro.dart';
import 'package:appfipeapi/carroDAO.dart';
import 'package:flutter/material.dart';

class CarroTela extends StatefulWidget {
  const CarroTela({super.key});

  @override
  State<CarroTela> createState() => _CarroTelaState();
}

class _CarroTelaState extends State<CarroTela> {
  final CarroDAO _carroDAO = CarroDAO();

  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _corController = TextEditingController();
  final TextEditingController _anoController = TextEditingController();
  final TextEditingController _motorController = TextEditingController();
  final TextEditingController _kilometragemController = TextEditingController();
  final TextEditingController _opcionaisController = TextEditingController();
  final TextEditingController _precoController = TextEditingController();

  List<Carro> listaCarros = [];
  Carro? _carroAtual;

  void _salvarOuEditar() async {
    if (_carroAtual == null) {
      await _carroDAO.insertCarro(Carro(
        marca: _marcaController.text,
        modelo: _modeloController.text,
        cor: _corController.text,
        ano: _anoController.text,
        motor: _motorController.text,
        kilometragem: _kilometragemController.text,
        opcionais: _opcionaisController.text,
        preco: _precoController.text,
      ));
    } else {
      _carroAtual!.marca = _marcaController.text;
      _carroAtual!.modelo = _modeloController.text;
      _carroAtual!.cor = _corController.text;
      _carroAtual!.ano = _anoController.text;
      _carroAtual!.motor = _motorController.text;
      _carroAtual!.kilometragem = _kilometragemController.text;
      _carroAtual!.opcionais = _opcionaisController.text;
      _carroAtual!.preco = _precoController.text;
      await _carroDAO.updateCarro(_carroAtual!);
    }
    _marcaController.clear();
    _modeloController.clear();
    _corController.clear();
    _anoController.clear();
    _motorController.clear();
    _kilometragemController.clear();
    _opcionaisController.clear();
    _precoController.clear();

    setState(() {
      _carroAtual = null;
    });
    _loadCarros();
  }

  @override
  void initState() {
    super.initState();
    _loadCarros();
  }

  void _editarCarro(Carro carro) {
    setState(() {
      _carroAtual = carro;
      _marcaController.text = carro.marca;
      _modeloController.text = carro.modelo;
      _corController.text = carro.cor;
      _anoController.text = carro.ano;
      _motorController.text = carro.motor;
      _kilometragemController.text = carro.kilometragem;
      _opcionaisController.text = carro.opcionais;
      _precoController.text = carro.preco;
    });
  }

  void _deleteCarro(int index) async {
    await _carroDAO.deleteCarro(index);
    _loadCarros();
  }

  void _loadCarros() async {
    List<Carro> listaTemp = await _carroDAO.selectCarros();
    setState(() {
      listaCarros = listaTemp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              "Cadastrar Carros",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: TextField(
                controller: _marcaController,
                decoration: const InputDecoration(labelText: 'Marca'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _modeloController,
                decoration: const InputDecoration(labelText: 'Modelo'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _corController,
                decoration: const InputDecoration(labelText: 'Cor'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _anoController,
                decoration: const InputDecoration(labelText: 'Ano'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _motorController,
                decoration: const InputDecoration(labelText: 'Motor'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _kilometragemController,
                decoration: const InputDecoration(labelText: 'Kilometragem'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _opcionaisController,
                decoration: const InputDecoration(labelText: 'Opcionais'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                controller: _precoController,
                decoration: const InputDecoration(labelText: 'Preço'),
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(255, 0, 91, 136)),
                  foregroundColor: WidgetStatePropertyAll(Colors.white),
                ),
                onPressed: _salvarOuEditar,
                child: Text(_carroAtual == null ? 'Salvar' : 'Atualizar'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: listaCarros.map((carro) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        'Marca: ${carro.marca}\nModelo: ${carro.modelo}\nCor: ${carro.cor}\nAno: ${carro.ano}\nMotor: ${carro.motor}\nKilometragem: ${carro.kilometragem}Km\nOpcionais: ${carro.opcionais}\nPreco: R\$ ${carro.preco}',
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          _deleteCarro(carro.id!);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      onTap: () {
                        _editarCarro(carro);
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
