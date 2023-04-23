import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/AirPollution.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/Pollution.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/test.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'SoilPollution.dart';
import 'WaterPollution.dart';

class TypesPollution extends StatelessWidget {
  const TypesPollution({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          color: Theme.of(context).primaryColor,
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Pollution(),
                        ));
                        // ignore: prefer_const_constructors
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: Dimenssion.height40dp,
                      )),
                  const SizedBox(width: 40),
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
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const PollutionAir(),
                  ));
                },
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
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WaterPollution()));
                },
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
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SoilPollution(),
                  ));
                },
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
                          child: Image.asset('images/soil-pollution.png'),
                        ),
                      ),
                      SizedBox(height: Dimenssion.height20dp),
                      Text(
                        'Pollution du sol',
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
      ),
    );
  }
}
