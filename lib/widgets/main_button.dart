import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const MainButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(247, 191, 95, 1)),
          child: Text(
            text,
            style:
                const TextStyle(color: Color.fromRGBO(47, 103, 23, 1), fontSize: 20),
          )),
    );
  }
}
