import 'package:flutter/material.dart';

void pushScreen(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void popScreen(context) {
  Navigator.pop(context);
}
