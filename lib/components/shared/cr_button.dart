import 'package:flutter/material.dart';

class CrButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final ButtonStyle? style;
  final double buttonSpacing = 8.0;
  final double buttonHeight = 40.0;

  const CrButton(String s,
      {super.key, required this.text, this.onPressed, this.style});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: style ??
          ElevatedButton.styleFrom(
            minimumSize: Size(buttonHeight, buttonHeight),
            padding: const EdgeInsets.all(10.0),
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
            decoration: TextDecoration.none,
            fontSize: 18.0),
      ),
    );
  }
}
