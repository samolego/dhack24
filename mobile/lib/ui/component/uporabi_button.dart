import 'package:flutter/material.dart';
import 'package:trgovinavigator/constants.dart';

class UporabiButton extends StatelessWidget {
  final VoidCallback onUse;
  final String text;

  const UporabiButton({
    super.key,
    required this.onUse,
    this.text = "",
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppColors.primary,
      ),
      onPressed: () {
        onUse();
      },
      child: Text(
        "Uporabi $text",
        style: TextStyle(
          color: AppColors.primaryDark,
        ),
      ),
    );
  }
}
