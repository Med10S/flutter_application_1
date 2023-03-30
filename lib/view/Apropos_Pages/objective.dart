import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utilities/dimention.dart';

class Objective extends StatelessWidget {
  const Objective({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        color: const Color.fromRGBO(47, 103, 23, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('images/logo.png'),
            Image.asset('images/objective.png'),
            Text(
              'Notre Objective',
              style: TextStyle(
                  color: Color.fromRGBO(247, 191, 95, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: Dimenssio.width20dp),
            ),
            Text(
              'Nous avons créé cette application pour sensibiliser les gens à l\'importance du tri des déchets et pour encourager l\'utilisation de poubelles intelligentes. Notre objectif est de contribuer à rendre notre planète plus propre et plus saine pour les générations futures',
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimenssio.width16dp,
              ),
              textAlign: TextAlign.center,
            ),
            Image.asset('images/next.png')
          ],
        ),
      ),
    ));
  }
}