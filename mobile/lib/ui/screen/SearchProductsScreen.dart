import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:trgovinavigator/constants.dart';
import 'package:trgovinavigator/logic/product_item.dart';

final _products = Supabase.instance.client.from('izdelki').select();

class SearchProductListScreen extends StatefulWidget {
  final bool Function(ProductItem) onProductSelect;

  const SearchProductListScreen({
    super.key,
    required this.onProductSelect,
  });

  @override
  State<SearchProductListScreen> createState() =>
      _SearchProductListScreenState();
}

class _SearchProductListScreenState extends State<SearchProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
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
        backgroundColor: AppColors.primary,
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
            Navigator.pop(context);
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
            )
          else
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
              final product = filteredProducts[index];
              final bool inStock = product["in_stock"];
              return ListTile(
                tileColor: inStock ? null : Colors.grey[200],
                title: Text(
                  product['ime_izdelka'],
                  style: TextStyle(
                    color: !inStock ? Colors.red : Colors.black,
                  ),
                ),
                trailing: inStock ? null : const Text("Ni na zalogi"),
                onTap: inStock
                    ? () {
                        bool added = false;
                        if (inStock) {
                          added = widget.onProductSelect(
                            ProductItem(
                              id_izdelka: product["id_izdelka"],
                              id_police: product["id_police"],
                              ime_izdelka: product["ime_izdelka"],
                              in_stock: inStock,
                            ),
                          );
                        }
                  if (added) {
                    final ScaffoldMessengerState scaffoldMessenger =
                    ScaffoldMessenger.of(context);

                    final SnackBar snackBar = SnackBar(
                        duration: const Duration(seconds: 1),
                        content: Text("Dodano: ${product['ime_izdelka']}"));

                    // Find the nearest ScaffoldMessengerState object in the widget tree
                    final ScaffoldMessengerState? nearestScaffoldMessenger =
                    context
                        .findAncestorStateOfType<ScaffoldMessengerState>();

                          // If the nearest ScaffoldMessengerState object is not null, use it to show the snackbar
                          if (nearestScaffoldMessenger != null) {
                            nearestScaffoldMessenger.hideCurrentSnackBar();
                            nearestScaffoldMessenger.showSnackBar(snackBar);
                          } else {
                            // If the nearest ScaffoldMessengerState object is null, use the global ScaffoldMessenger to show the snackbar
                            scaffoldMessenger.hideCurrentSnackBar();
                            scaffoldMessenger.showSnackBar(snackBar);
                          }
                        }
                      }
                    : null,
              );
            }),
          );
        },
      ),
    );
  }
}
