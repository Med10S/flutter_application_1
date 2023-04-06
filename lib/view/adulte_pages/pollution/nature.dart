import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/view/adulte_pages/pollution/definition.dart';

import '../../../utilities/dimention.dart';
import 'Pollution.dart';//init

class naturePollution extends StatelessWidget {
  const naturePollution({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        color: const Color.fromRGBO(47, 103, 23, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                    height: Dimenssio.FirstPagesImageHeight / 2.5,
                    alignment: Alignment.topRight,
                    child: Image.asset('images/terre.png')),
                Image.asset('images/logo.png')
              ],
            ),
            Text('Nature de pollution',
                style: TextStyle(
                  fontSize: Dimenssio.width24dp,
                  color: const Color.fromRGBO(247, 191, 95, 1),
                )),
            Container(
              margin: EdgeInsets.symmetric(vertical: Dimenssio.height20dp),
              child: Text(
                'Il existe plusieurs manières de classer la pollution. Selon le type de polluant, on peut classer la pollution en trois catégories :',
                style: TextStyle(
                    color: Colors.white, fontSize: Dimenssio.width16dp),
                textAlign: TextAlign.center,
              ),
            ),
            InkWell(
              onTap: (){},
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 52, 172, 42),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'pollution physique',
                      style: TextStyle(
                          color: Colors.white, fontSize: Dimenssio.width16dp),
                    ),
                    Image.asset('images/physique.png')
                  ],
                ),
              ),
            ),
            Container(
               margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 52, 172, 42),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'pollution chimique2',
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimenssio.width16dp),
                  ),
                  Image.asset('images/chimique.png')
                ],
              ),
            ),
            Container(
               margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 52, 172, 42),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'pollution biologique',
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimenssio.width16dp),
                  ),
                  Image.asset('images/biologique.png')
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => definition()));
                      // Fonction appelée lors du clic sur le bouton
                    },
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: Dimenssio.height40dp,
                    )),
                InkWell(
                    onTap: () {/*
                       Navigator.push(context,
                          CupertinoPageRoute(builder: (_) => CalendarWithGraphs(data: [],)));*/
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


