import 'package:flutter/material.dart';

class Poubelle extends StatelessWidget {
  const Poubelle({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(backgroundColor: Theme.of(context).primaryColor,
      body: const Center(child:Text("Poubelle")),));
  }
}