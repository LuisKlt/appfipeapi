import 'package:appfipeapi/anoSearch.dart';
import 'package:appfipeapi/apiService.dart';
import 'package:appfipeapi/main.dart';
import 'package:appfipeapi/modelo.dart';
import 'package:flutter/material.dart';

class ModeloSearch extends StatefulWidget {
  final String marca;
  const ModeloSearch({super.key, required this.marca});

  @override
  ModeloSearchState createState() => ModeloSearchState();
}

class ModeloSearchState extends State<ModeloSearch> {
  final ApiService apiService = ApiService();
  List<Modelo> allBrands = [];
  List<Modelo> filteredBrands = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadModelos();
    searchController.addListener(_filterBrands);
  }

  Future<void> _loadModelos() async {
    allBrands = await apiService.getModelos(widget.marca);
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
                labelText: 'Buscar modelo',
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
                      MaterialPageRoute(builder: (context) => AnoSearch(marca: widget.marca, modelo: brand.codigo)),
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
