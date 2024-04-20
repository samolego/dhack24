import 'package:flutter/material.dart';
import 'package:trgovinavigator/constants.dart';
import 'package:trgovinavigator/logic/product_item.dart';
import 'package:trgovinavigator/logic/screen_navigator.dart';
import 'package:trgovinavigator/ui/component/ShoppingItem.dart';
import 'package:trgovinavigator/ui/component/dialogue.dart';
import 'package:trgovinavigator/ui/screen/SearchProductsScreen.dart';

class EditShoppingListScreen extends StatefulWidget {
  final List<Widget> _shoppingList;
  final VoidCallback onClearAll;
  final Function(ProductItem) onRemove;
  final Function(ProductItem) onAdd;

  const EditShoppingListScreen({
    super.key,
    shoppingList = const <Widget>[],
    required this.onClearAll,
    required this.onRemove,
    required this.onAdd,
  }) : _shoppingList = shoppingList;

  List<Widget> get shoppingList => _shoppingList;

  @override
  State<EditShoppingListScreen> createState() => _EditShoppingListScreenState();
}

class _EditShoppingListScreenState extends State<EditShoppingListScreen> {
  @override
  Widget build(BuildContext context) {
    // Create a list of shopping items with checkbars at the end
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nakupovalni seznam'),
          backgroundColor: AppColors.primary,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (builder) => YesNoDialogue(
                    title: const Text("Izbriši vse izdelke?"),
                    content: const Text(
                        "Ali ste prepričani, da želite izbrisati vse izdelke?"),
                    onYes: () {
                      setState(() {
                        widget.onClearAll();
                        widget._shoppingList.clear();
                      });
                    },
                    onNo: () {
                      // Do nothing
                    },
                  ),
                );
              },
              icon: const Icon(Icons.clear_all),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          // Circular
          shape: const CircleBorder(),
          onPressed: () {
            // Push new screen
            pushScreen(context, SearchProductListScreen(
              onProductSelect: (p) {
                bool canAdd = widget._shoppingList
                    .where((element) =>
                        (element as ShoppingItem).product.ime_izdelka ==
                        p.ime_izdelka)
                    .isEmpty;
                setState(() {
                  if (canAdd) {
                    widget.onAdd(p);
                    widget._shoppingList.add(ShoppingItem(
                      product: p,
                      onRemove: () {
                        print("Removing product: ${p.ime_izdelka}");
                        setState(() {
                          widget.onRemove(p);
                          widget._shoppingList.removeWhere((element) =>
                              (element as ShoppingItem).product.ime_izdelka ==
                              p.ime_izdelka);
                        });
                      },
                    ));
                  }
                });
                return canAdd;
              },
            ));
          },
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: widget._shoppingList,
          ),
        ),
      ),
    );
  }
}
