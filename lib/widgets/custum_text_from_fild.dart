
import 'package:flutter/material.dart';

import 'custum_text.dart';

class CustumTextFromFild extends StatelessWidget {
  final String text;
  final String hint;
  final void Function(String?)? onSave;
  final FormFieldValidator<String>? validator;

  const CustumTextFromFild({super.key,  required this.text, required this.hint, required this.onSave, required this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: text,
          fontSize: 14,
          color: Colors.grey.shade900,
        ),
        TextFormField(
          onSaved:onSave ,
          validator: validator,
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.black),
              fillColor: Colors.white),
        )
      ],
    );
  }
}
