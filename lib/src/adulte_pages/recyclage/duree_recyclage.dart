import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class DureeRecyclage extends StatelessWidget {
  const DureeRecyclage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(backgroundColor: Theme.of(context).primaryColor,
      body: Center(child:Text("DureeRecyclage")),));
  }
}

