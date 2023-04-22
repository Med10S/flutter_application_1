import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/src/Apropos_Pages/stategie.dart';

class Equipe extends StatelessWidget {
  const Equipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(30),
          alignment: Alignment.center,
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.topRight,
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => Strategie(),
                            ));
                      },
                      child: Text(
                        "skip",
                        style: TextStyle(color: Colors.white),
                      ))),
              Image.asset('images/logo.png'),
              Image.asset('images/equipe.png'),
              Text(
                'Notre Équipe',
                style: TextStyle(
                    color: Color.fromRGBO(247, 191, 95, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: Dimenssion.width20dp),
              ),
              Text(
                'Nous sommes un groupe de 13 étudiants de l\' École nationale des sciences appliquées de fes passionnés par l\'environnement et désireux de contribuer à la réduction de la pollution.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Dimenssion.width16dp,
                ),
                textAlign: TextAlign.center,
              ),
              Image.asset('images/next.png', height: Dimenssion.height20dp * 2)
            ],
          ),
        ),
      ),
    );
  }
}
