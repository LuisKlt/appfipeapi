import 'package:appfipeapi/ano.dart';
import 'package:appfipeapi/apiService.dart';
import 'package:appfipeapi/carroInfo.dart';
import 'package:appfipeapi/main.dart';
import 'package:flutter/material.dart';

class AnoSearch extends StatefulWidget {
  final String marca;
  final int modelo;
  const AnoSearch({super.key, required this.marca, required this.modelo});

  @override
  AnoSearchState createState() => AnoSearchState();
}

class AnoSearchState extends State<AnoSearch> {
  final ApiService apiService = ApiService();
  List<Ano> allBrands = [];
  List<Ano> filteredBrands = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadAnos();
    searchController.addListener(_filterBrands);
  }

  Future<void> _loadAnos() async {
    allBrands = await apiService.getAnos(widget.marca, widget.modelo);
    setState(() {
      filteredBrands = allBrands;
    });
  }

  void _filterBrands() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredBrands = allBrands.where((brand) {
        final brandName = brand.nome.toLowerCase();
        return brandName.contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar ano',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredBrands.length,
              itemBuilder: (context, index) {
                final brand = filteredBrands[index];
                return ListTile(
                  title: Text(brand.nome),
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => CarroInfo(
                              marca: widget.marca,
                              modelo: widget.modelo,
                              ano: brand.codigo)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
