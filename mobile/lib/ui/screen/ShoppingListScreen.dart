import 'package:flutter/material.dart';
import 'package:trgovinavigator/constants.dart';
import 'package:trgovinavigator/logic/screen_navigator.dart';
import 'package:trgovinavigator/ui/component/ShoppingItem.dart';
import 'package:trgovinavigator/ui/component/dialogue.dart';
import 'package:trgovinavigator/ui/screen/SearchProductsScreen.dart';

class ShoppingListScreen extends StatefulWidget {
  final List<Widget> _shoppingList;

  const ShoppingListScreen({
    super.key,
    shoppingList = const <Widget>[],
  }) : _shoppingList = shoppingList;

  List<Widget> get shoppingList => _shoppingList;

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
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
                        (element as ShoppingItem).product.id_izdelka ==
                        p.id_izdelka)
                    .isEmpty;
                setState(() {
                  if (canAdd) {
                    widget._shoppingList.add(ShoppingItem(
                      product: p,
                      onRemove: () {
                        setState(() {
                          widget._shoppingList.removeWhere((element) =>
                              (element as ShoppingItem).product.id_izdelka ==
                              p.id_izdelka);
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
