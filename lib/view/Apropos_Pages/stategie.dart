import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utilities/dimention.dart';
import '../welcome.dart';

class Strategie extends StatelessWidget {
  const Strategie({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('images/logo.png'),
            Image.asset('images/strategie.png'),
            Text(
              'Notre Stratégie',
              style: TextStyle(
                  color: Color.fromRGBO(247, 191, 95, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: Dimenssion.width20dp),
            ),
            Text(
              'L’application permet aux utilisateurs de se connecter et de visualiser une carte qui affiche les emplacements de nos poubelles intelligentes. Les utilisateurs pourront également consulter leur compte de points d\'achats accumulés grâce au tri de leurs déchets dans nos poubelles intelligentes.',
              style: TextStyle(
                color: Colors.white,
                fontSize: Dimenssion.width16dp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
                width: Dimenssion.width200dp,
                height: Dimenssion.height45dp,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => Welcome(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(247, 191, 95, 1),
                      maximumSize: Size(200, 46),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: const Text(
                    'Sortir',
                    style: TextStyle(fontSize: 20),
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
