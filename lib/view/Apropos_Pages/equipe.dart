import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/dimention.dart';

class Equipe extends StatelessWidget {
  const Equipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30),
          alignment: Alignment.center,
          color: const Color.fromRGBO(47, 103, 23, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('images/logo.png'),
              Image.asset('images/equipe.png'),
              Text(
                'Notre Équipe',
                style: TextStyle(
                    color: Color.fromRGBO(247, 191, 95, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: Dimenssio.width20dp),
              ),
              Text(
                'Nous sommes un groupe de 13 étudiants de l\' École nationale des sciences appliquées de fes passionnés par l\'environnement et désireux de contribuer à la réduction de la pollution.',
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
      ),
    );
  }
}
