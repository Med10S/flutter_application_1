import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final Alignment alignment;

  const CustomText(
      {super.key, this.text = "",
      this.fontSize = 16,
      this.color = Colors.white,
      this.alignment = Alignment.topLeft});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(text, style: TextStyle(color: color, fontSize: fontSize)),
    );
  }
}
