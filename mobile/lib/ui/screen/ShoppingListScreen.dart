import 'package:flutter/material.dart';
import 'package:trgovinavigator/logic/screen_navigator.dart';
import 'package:trgovinavigator/ui/component/ShoppingItem.dart';
import 'package:trgovinavigator/ui/screen/SearchProductsScreen.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final List<ShoppingItem> _shoppingList = <ShoppingItem>[
    const ShoppingItem(itemId: 1, itemName: "Milk"),
    const ShoppingItem(itemId: 2, itemName: "Bread"),
    const ShoppingItem(itemId: 3, itemName: "Eggs"),
  ];

  @override
  Widget build(BuildContext context) {
    // Create a list of shopping items with checkbars at the end
    return Stack(
      children: [
        ListView(
          children: _shoppingList,
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            // Circular
            shape: const CircleBorder(),
            onPressed: () {
              // Push new screen
              pushScreen(context, const SearchProductListScreen());
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
