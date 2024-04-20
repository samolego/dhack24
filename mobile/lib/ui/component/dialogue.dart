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

class AddListDialogue extends StatefulWidget {
  final Function(String) onAdd;

  const AddListDialogue({
    super.key,
    required this.onAdd,
  });

  @override
  State<AddListDialogue> createState() => _AddListDialogueState();
}

class _AddListDialogueState extends State<AddListDialogue> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Dodajanje novega seznama"),
      content: TextField(
        decoration: const InputDecoration(
          labelText: "Ime seznama",
        ),
        onChanged: (value) {
          setState(() {
            // Push new shopping list
            name = value;
          });
        },
        onSubmitted: (value) {
          setState(() {
            // Push new shopping list
            name = value;
          });
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Prekliči"),
        ),
        TextButton(
          onPressed: () {
            widget.onAdd(name);
            Navigator.pop(context);
          },
          child: const Text("Dodaj"),
        ),
      ],
    );
  }
}
