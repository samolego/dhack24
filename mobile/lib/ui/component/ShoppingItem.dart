import 'package:flutter/material.dart';

class ShoppingItem extends StatefulWidget {
  final int itemId;
  final String itemName;

  const ShoppingItem({
    super.key,
    required this.itemName,
    required this.itemId,
  });

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.itemName),
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
