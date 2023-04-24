import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/agriculture.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/definition.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/nature.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/transport.dart';

import '../../../utilities/dimention.dart';
import 'Pollution.dart';
import 'dechets.dart';
import 'domestique.dart';
import 'industriel.dart'; //init

class sources extends StatelessWidget {
  const sources({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
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
                Text('Sources de pollution',
                    style: TextStyle(
                      fontSize: Dimenssio.width24dp,
                      color: const Color.fromRGBO(247, 191, 95, 1),
                    )),
                Container(
                  margin: EdgeInsets.symmetric(vertical: Dimenssio.height20dp),
                  child: Text(
                    'Il existe plusieurs sources de pollution, voici les principales :',
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimenssio.width16dp),
                    textAlign: TextAlign.center,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) =>

                              industriel(),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Mcolors.couleurPrincipal2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Les émissions industrielles ',
                          style: TextStyle(
                              color: Colors.white, fontSize: Dimenssio.width16dp),
                        ),
                        Image.asset('images/industrie.png')
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) =>
                              transport(),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Mcolors.couleurPrincipal2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Les transports',
                          style: TextStyle(
                              color: Colors.white, fontSize: Dimenssio.width16dp),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(45, 0, 0,0), //ajouter un padding de 16.0 pixels
                          child: Image(
                            image: AssetImage('images/transport.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) =>
                              agriculture(),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Mcolors.couleurPrincipal2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "L'agriculture",
                          style: TextStyle(
                              color: Colors.white, fontSize: Dimenssio.width16dp),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(100, 0, 0,0), //ajouter un padding de 16.0 pixels
                          child: Image(
                            image: AssetImage('images/agriculture.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) =>
                              dechets(),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Mcolors.couleurPrincipal2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Les déchets",
                          style: TextStyle(
                              color: Colors.white, fontSize: Dimenssio.width16dp),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(100, 0, 0,0), //ajouter un padding de 16.0 pixels
                          child: Image(
                            image: AssetImage('images/dechets.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) =>
                              domestique(),
                        ));
                  },

                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Mcolors.couleurPrincipal2,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Les activités domestiques",
                          style: TextStyle(
                              color: Colors.white, fontSize: Dimenssio.width16dp),
                        ),
                        Container(
                          //padding: EdgeInsets.fromLTRB(40, 0, 0,0), //ajouter un padding de 16.0 pixels
                          child: Image(
                            image: AssetImage('images/domestiques.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              CupertinoPageRoute(builder: (_) => naturePollution()));
                          // Fonction appelée lors du clic sur le bouton
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: Dimenssio.height40dp,
                        )),
                    InkWell(
                        onTap: () {

                          /*
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
