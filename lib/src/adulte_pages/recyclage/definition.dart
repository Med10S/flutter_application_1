// ignore: camel_case_types
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/adulte_pages/recyclage/3R.dart';
import 'package:flutter_application_1/src/adulte_pages/recyclage/recyclage.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/utilities/string.dart';
import '../../../colors/colors.dart';

class defRecyclage extends StatelessWidget {
  const defRecyclage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
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
                  color: Mcolors.couleurSecondaire,
                )),
            Container(
              margin: EdgeInsets.symmetric(vertical: Dimenssio.height40dp, horizontal: Dimenssio.width24dp),
              child: Text(
                Strings.recyclageDefinition,
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
                          CupertinoPageRoute(builder: (_) => const Recyclage()));
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
                              builder: (_) => R_3()));
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

