import 'dart:ui';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/type_pollution/types.dart';

import '../../../../utilities/dimention.dart';
import 'WaterPollution.dart'; //init

class PollutionAir extends StatelessWidget {
  const PollutionAir({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: ListView(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        height: Dimenssion.FirstPagesImageHeight / 2.5,
                        alignment: Alignment.centerRight,
                        child: Image.asset('images/mother-earth.png')),
                    Image.asset('images/logo.png')
                  ],
                ),
                Text(
                  'types de pollution',
                  style: TextStyle(
                    fontSize: Dimenssion.height20dp,
                    color: const Color.fromARGB(255, 242, 187, 93),
                  ),
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: Dimenssion.height20dp),
                  child: Text(
                    'il exsiste trois types de pollution, cliquer pour en savoir plus!',
                    style: TextStyle(
                        color: Colors.white, fontSize: Dimenssion.width20dp),
                    textAlign: TextAlign.center,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(bottom: Dimenssion.height20dp),
                    padding: EdgeInsets.all(Dimenssion.width20dp / 2),
                    width: Dimenssion.width200dp / 2,
                    height: Dimenssion.width200dp,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 243, 191, 102),
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Dimenssion.width200dp / 2,
                          height: Dimenssion.width200dp / 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset('images/air-pollution.png'),
                          ),
                        ),
                        SizedBox(height: Dimenssion.height20dp),
                        Text(
                          'Pollution de l\'air',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimenssion.width20dp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.only(bottom: Dimenssion.height20dp),
                    padding: EdgeInsets.all(Dimenssion.width20dp / 2),
                    width: Dimenssion.width200dp / 2,
                    height: Dimenssion.width200dp,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 243, 191, 102),
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: Dimenssion.width200dp / 2,
                          height: Dimenssion.width200dp / 2,
                          child: Align(
                            alignment: Alignment.center,
                            child: Image.asset('images/water-pollution.png'),
                          ),
                        ),
                        SizedBox(height: Dimenssion.height20dp),
                        Text(
                          'Pollution de l\'eau',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimenssion.width20dp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Blurry overlay
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0),
              ),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Dimenssion.height250dp,
                  height: Dimenssion.height250dp,
                  child: FlipCard(
                    front: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "La pollution atmosphérique se produit lorsque l'air que nous respirons est endommagé par des produits chimiques nocifs qui se trouvent dans l'air. Les pics de pollution atmosphérique sont plus fréquents en été. ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: Dimenssion.height20dp),
                            const Text(
                              "click to flip back",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                      ),
                    ),
                    back: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Les principales sources de pollution atmosphérique comprennent les particules fines, le dioxyde de soufre, l'ozone, les oxydes d'azote, les composés organiques volatils, etc.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: Dimenssion.height20dp),
                            const Text(
                              "click to flip front",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const TypesPollution(),
                          ));
                        },
                        icon: const Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Back',
                          style: TextStyle(color: Colors.white),
                        )),
                    OutlinedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const WaterPollution(),
                          ));
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                        ),
                        label: const Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
