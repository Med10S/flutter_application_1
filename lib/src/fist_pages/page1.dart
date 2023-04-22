import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/src/fist_pages/page2.dart';

import '../../utilities/dimention.dart';

class Page1 extends StatefulWidget {
  Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  //String tail = "" + Dimenssio.FirstPagesImageHeight.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'images/back.png',
                      width: Dimenssion.screenWidth,
                      fit: BoxFit.fitWidth,
                    ),
                    Container(
                      height: Dimenssion.FirstPagesImageHeight,
                      child: Image.asset(
                        'images/groupe1.png',
                      ),
                    ),
                  ],
                ),
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
                      "RECYCLE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimenssion.width30dp,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimenssion.width46dp,
                        right: Dimenssion.width46dp,
                        top: Dimenssion.height5dp),
                    child: Text(
                      "Recycle,Earn Point and Get Rewards",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color.fromRGBO(247, 191, 95, 1),
                          fontSize: Dimenssion.width30dp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: Dimenssion.height5dp * 5),
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
