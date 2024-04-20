import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _products = Supabase.instance.client.from('izdelki').select();

class SearchProductListScreen extends StatelessWidget {
  const SearchProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: FutureBuilder(
        future: _products,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: ((context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product['ime_izdelka']),
              );
            }),
          );
        },
      ),
    );
  }
}
