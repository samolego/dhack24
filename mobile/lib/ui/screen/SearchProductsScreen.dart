import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trgovinavigator/logic/product_item.dart';

final _products = Supabase.instance.client.from('izdelki').select();

class SearchProductListScreen extends StatefulWidget {
  final void Function(ProductItem) onProductSelect;

  const SearchProductListScreen({super.key, required this.onProductSelect});

  @override
  State<SearchProductListScreen> createState() =>
      _SearchProductListScreenState();
}

class _SearchProductListScreenState extends State<SearchProductListScreen> {
  List<dynamic> _selectedProducts = [];
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredProducts = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (_isSearching) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Preišči izdelke ...',
                  border: InputBorder.none,
                ),
              )
            : const Text("Izdelki"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            ),
          if (_isSearching)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                });
              },
            ),
        ],
      ),
      body: FutureBuilder(
        future: _products,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final products = snapshot.data!;
          final filteredProducts = _searchController.text.isEmpty
              ? products
              : products.where((product) {
                  final productName = product['ime_izdelka'].toLowerCase();
                  return productName
                      .contains(_searchController.text.toLowerCase());
                }).toList();

          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: ((context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product['ime_izdelka']),
                onTap: () {},
              );
            }),
          );
        },
      ),
    );
  }
}
