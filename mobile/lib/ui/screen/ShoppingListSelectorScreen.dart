import 'package:flutter/material.dart';
import 'package:trgovinavigator/constants.dart';
import 'package:trgovinavigator/logic/product_item.dart';
import 'package:trgovinavigator/logic/screen_navigator.dart';
import 'package:trgovinavigator/ui/component/ShoppingItem.dart';
import 'package:trgovinavigator/ui/screen/ShoppingListScreen.dart';

class ShoppingListSelectorScreen extends StatefulWidget {
  const ShoppingListSelectorScreen({super.key});

  @override
  State<ShoppingListSelectorScreen> createState() =>
      _ShoppingListSelectorScreenState();
}

class _ShoppingListSelectorScreenState
    extends State<ShoppingListSelectorScreen> {
  final Map<String, List<ProductItem>> _shoppingLists =
      shoppingLists.map((key, value) => MapEntry(key, value));

  @override
  Widget build(BuildContext context) {
    // Builds a view of the shopping list selector screen
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pregled seznamov'),
        backgroundColor: AppColors.primary,
      ),
      body: GridView.count(
        crossAxisCount: 2, // Set the number of columns to 2
        children: List.generate(_shoppingLists.length, (index) {
          var item = _shoppingLists.entries.elementAt(index);
          var productList = item.value.toList(growable: true);
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Card(
              borderOnForeground: true,
              surfaceTintColor: Colors.white,
              elevation: 4,
              child: InkWell(
                onTap: () {
                  pushScreen(
                      context,
                      ShoppingListScreen(
                        shoppingList: productList
                            .map((e) => ShoppingItem(
                                product: e,
                                onRemove: () {
                                  setState(() {
                                    item.value.remove(e);
                                    _shoppingLists[item.key] = item.value;
                                  });
                                }))
                            .toList(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.key,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eget risus porta, tincidunt turpis at, interdum tortor. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
