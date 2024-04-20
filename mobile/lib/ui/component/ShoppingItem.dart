import 'package:flutter/material.dart';
import 'package:trgovinavigator/logic/product_item.dart';
import 'package:trgovinavigator/ui/component/dialogue.dart';

class ShoppingItem extends StatefulWidget {
  final ProductItem product;
  final VoidCallback onRemove;

  const ShoppingItem({
    super.key,
    required this.product,
    required this.onRemove,
  });

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.product.ime_izdelka),
      onLongPress: () {
        showDialog(
          context: context,
          builder: (ctx) => YesNoDialogue(
            title: Text("Odstrani ${widget.product.ime_izdelka}?"),
            content: const Text(
                "Ali ste prepričani, da želite odstraniti ta izdelek?"),
            onYes: () => widget.onRemove(),
            onNo: () {
              // Do nothing
            },
          ),
        );
      },
      trailing: Checkbox(
        value: _isChecked,
        onChanged: (bool? value) {
          setState(() {
            _isChecked = value!;
          });
        },
      ),
    );
  }
}
