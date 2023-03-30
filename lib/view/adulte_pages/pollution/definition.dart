import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/view/adulte_pages/pollution/nature.dart';

import '../../../utilities/dimention.dart';
import 'Pollution.dart';

class definition extends StatelessWidget {
  const definition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        color: const Color.fromRGBO(47, 103, 23, 1),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: Dimenssio.FirstPagesImageHeight/2.5,
                    alignment: Alignment.topRight,
                    child: Image.asset('images/terre.png')),
                Image.asset('images/logo.png')
              ],
            ),
            Text('Definition',
                style: TextStyle(
                  fontSize: Dimenssio.width24dp,
                  color: const Color.fromRGBO(247, 191, 95, 1),
                )),
            Container(
              margin: EdgeInsets.symmetric(vertical: Dimenssio.height40dp, horizontal: Dimenssio.width24dp),
              child: Text(
                'On appelle pollution une dégradation ou une altération de l\'environnement, en général liée à l\'activité humaine par diffusion directe ou indirecte de substances chimiques, physiques ou biologiques qui sont potentiellement toxiques pour les organismes vivants ou qui perturbent de manière plus ou moins importante le fonctionnement naturel des écosystèmes. Outre ses effets sur la santé humaine et animale, elle peut avoir pour conséquences la migration ou l\'extinction de certaines espèces qui sont incapables de s\'adapter à l\'évolution de leur milieu naturel.',
                style: TextStyle(
                    fontSize: Dimenssio.width16dp, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => Pollution()));
                      // Fonction appelée lors du clic sur le bouton
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: Dimenssio.height40dp,
                    )),
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => naturePollution()));
                      // Fonction appelée lors du clic sur le bouton
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: Dimenssio.height40dp,
                    )),
              ],
            )
          ],
        ),
      )),
    );
  }
}