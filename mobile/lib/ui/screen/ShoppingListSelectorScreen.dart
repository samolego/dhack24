import 'package:flutter/material.dart';
import 'package:trgovinavigator/constants.dart';
import 'package:trgovinavigator/logic/product_item.dart';
import 'package:trgovinavigator/logic/screen_navigator.dart';
import 'package:trgovinavigator/ui/component/ShoppingItem.dart';
import 'package:trgovinavigator/ui/component/dialogue.dart';
import 'package:trgovinavigator/ui/component/fab_add_button.dart';
import 'package:trgovinavigator/ui/screen/EditShoppingListScreen.dart';

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
      floatingActionButton: FabAddButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (b) => AddListDialogue(
              onAdd: (name) {
                setState(() {
                  _shoppingLists[name] = [];
                  shoppingLists[name] = [];
                });
              },
            ),
          );
        },
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
                onLongPress: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => YesNoDialogue(
                      title: Text("Izbriši seznam ${item.key}?"),
                      content: const Text(
                          "Ali ste prepričani, da želite izbrisati ta seznam?"),
                      onYes: () {
                        setState(() {
                          _shoppingLists.remove(item.key);
                          shoppingLists.remove(item.key);
                        });
                      },
                      onNo: () {
                        // Do nothing
                      },
                    ),
                  );
                },
                onTap: () {
                  pushScreen(
                      context,
                      EditShoppingListScreen(
                        name: item.key,
                        onAdd: (product) {
                          setState(() {
                            item.value.add(product);
                            _shoppingLists[item.key] = item.value;
                          });
                        },
                        onRemove: (product) {
                          setState(() {
                            item.value.remove(product);
                            _shoppingLists[item.key] = item.value;
                            shoppingLists[item.key] = item.value;
                          });
                        },
                        onClearAll: () {
                          setState(() {
                            item.value.clear();
                            _shoppingLists[item.key] = item.value;
                            shoppingLists[item.key] = item.value;
                          });
                        },
                        shoppingList: productList
                            .map((e) => ShoppingItem(
                            product: e,
                            onRemove: () {
                              setState(() {
                                item.value.remove(e);
                                _shoppingLists[item.key] = item.value;
                                shoppingLists[item.key] = item.value;
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
                          // Show first 3 items
                          "${productList.map((e) => e.ime_izdelka).take(3).join("\n")}${productList.length > 3 ? "\n..." : ''}",
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
