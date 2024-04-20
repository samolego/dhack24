import 'package:flutter/material.dart';

class YesNoDialogue extends StatelessWidget {
  final Widget title;
  final Widget content;
  final VoidCallback onYes;
  final VoidCallback onNo;

  const YesNoDialogue({
    super.key,
    required this.title,
    required this.content,
    required this.onYes,
    required this.onNo,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        TextButton(
          child: const Text('Ne'),
          onPressed: () {
            onNo();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Da'),
          onPressed: () {
            onYes();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
