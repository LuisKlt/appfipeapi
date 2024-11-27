import 'package:appfipeapi/apiService.dart';
import 'package:appfipeapi/modeloSearch.dart';
import 'package:appfipeapi/marca.dart';
import 'package:flutter/material.dart';

class MarcaSearch extends StatefulWidget {
  const MarcaSearch({super.key});

  @override
  MarcaSearchState createState() => MarcaSearchState();
}

class MarcaSearchState extends State<MarcaSearch> {
  final ApiService apiService = ApiService();
  List<Marca> allBrands = [];
  List<Marca> filteredBrands = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCarBrands();
    searchController.addListener(_filterBrands);
  }

  Future<void> _loadCarBrands() async {
    allBrands = await apiService.getMarcas();
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Buscar marca',
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
                          builder: (context) =>
                              ModeloSearch(marca: brand.codigo)),
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
