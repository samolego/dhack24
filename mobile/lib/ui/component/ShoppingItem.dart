import 'package:flutter/material.dart';
import 'package:trgovinavigator/logic/product_item.dart';

class ShoppingItem extends StatefulWidget {
  final ProductItem product;

  const ShoppingItem({
    super.key,
    required this.product,
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
