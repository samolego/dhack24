import 'package:flutter/material.dart';
import 'package:trgovinavigator/constants.dart';
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
          child: Column(
            children: [
              Container(
                // Add color to the container
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [
                        Text(
                          "Nakupovalni seznam",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        IconButton(
                          onPressed: () => setState(() {
                            shoppingList.clear();
                          }),
                          icon: const Icon(Icons.clear_all),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: shoppingList,
                ),
              ),
            ],
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
                  bool canAdd = shoppingList
                      .where((element) =>
                          (element as ShoppingItem).product.id_izdelka ==
                          p.id_izdelka)
                      .isEmpty;
                  setState(() {
                    if (canAdd) {
                      shoppingList.add(ShoppingItem(product: p));
                    }
                  });
                  return canAdd;
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
