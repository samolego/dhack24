import 'package:flutter/material.dart';
import 'package:trgovinavigator/ui/component/ShoppingItem.dart';

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
          bottom: 0,
          right: 0,
          child: FloatingActionButton(
            onPressed: () {
              // Add a new item to the shopping list
              setState(() {
                _shoppingList
                    .add(const ShoppingItem(itemName: "itemName", itemId: 9));
              });
            },
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
