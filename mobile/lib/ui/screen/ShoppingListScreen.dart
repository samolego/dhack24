import 'package:flutter/material.dart';
import 'package:trgovinavigator/logic/product_item.dart';
import 'package:trgovinavigator/logic/screen_navigator.dart';
import 'package:trgovinavigator/ui/component/ShoppingItem.dart';
import 'package:trgovinavigator/ui/screen/SearchProductsScreen.dart';

final List<Widget> shoppingList = <Widget>[
  const ShoppingItem(
      product: ProductItem(id_izdelka: 1, id_police: 2, ime_izdelka: "Kruh")),
];

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  @override
  Widget build(BuildContext context) {
    // Create a list of shopping items with checkbars at the end
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          top: 0,
          right: 0,
          left: 0,
          child: SingleChildScrollView(
            child: Column(
              children: shoppingList,
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            // Circular
            shape: const CircleBorder(),
            onPressed: () {
              // Push new screen
              pushScreen(context, SearchProductListScreen(
                onProductSelect: (p) {
                  setState(() {
                    shoppingList.add(ShoppingItem(product: p));
                  });
                },
              ));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
