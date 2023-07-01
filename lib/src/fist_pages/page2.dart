import 'package:flutter/material.dart';

import '../../utilities/dimention.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'images/back2.png',
                    width: Dimenssion.screenWidth,
                    fit: BoxFit.fitWidth,
                  ),
                  Image.asset(
                    fit: BoxFit.scaleDown,
                    height: Dimenssion.FirstPagesImageHeight,
                    'images/Group2.png',
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimenssion.width55dp,
                        right: Dimenssion.width55dp,
                        top: Dimenssion.height5dp),
                    alignment: Alignment.center,
                    child: Text(
                      "CLEAN EARTH",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimenssion.width30dp,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: Dimenssion.height5dp),
                    child: Text(
                      "Une planète propre pour un avenir durable",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color.fromRGBO(247, 191, 95, 1),
                          fontSize: Dimenssion.width30dp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: Dimenssion.height5dp),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/next.png',
                        height: Dimenssion.height20dp * 2,
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
