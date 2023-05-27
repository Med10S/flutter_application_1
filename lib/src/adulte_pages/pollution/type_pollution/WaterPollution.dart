import 'dart:ui';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/type_pollution/AirPollution.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/type_pollution/SoilPollution.dart';

import '../../../../utilities/dimention.dart';
//done
class WaterPollution extends StatelessWidget {
  const WaterPollution({super.key});

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
                      child: const Center(
                        child: Text(
                          "L'eau peut être contaminée par des déchets, des produits chimiques ou des micro-organismes, ce qu'on appelle la pollution de l'eau. Les principales causes de cette pollution sont l'agriculture, en raison de l'utilisation de pesticides et d'engrais, et les rejets domestiques, qui contiennent des médicaments et des produits chimiques que les stations d'épuration ne peuvent pas traiter.  ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
                      child: const Center(
                        child: Text(
                          "phosphates, présents dans certains produits ménagers, peuvent provoquer l'eutrophisation des cours d'eau, c'est-à-dire une prolifération d'algues qui asphyxie le cours d'eau. Enfin, les rejets d'hydrocarbures des bateaux peuvent également polluer l'eau.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
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
                            builder: (context) => const PollutionAir(),
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
                            builder: (context) => const SoilPollution(),
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
