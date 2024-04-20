import 'package:flutter/material.dart';

void pushScreen(context, widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}
