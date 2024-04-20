import 'package:flutter/material.dart';

class FabAddButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FabAddButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      // Circular
      shape: const CircleBorder(),
      onPressed: () {
        onPressed();
      },
      child: const Icon(Icons.add),
    );
  }
}
