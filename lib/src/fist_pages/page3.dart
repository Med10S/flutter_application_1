import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/src/Apropos_Pages/pageDePassage.dart';
import 'package:flutter_application_1/src/fist_pages/page2.dart';
import 'package:flutter_application_1/src/fist_pages/pageDePassage.dart';
import 'package:flutter_application_1/src/welcome.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

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
                    'images/back.png',
                    width: Dimenssion.screenWidth,
                    fit: BoxFit.fitWidth,
                  ),
                  Image.asset(
                    'images/Group3.png',
                    height: Dimenssion.FirstPagesImageHeight,
                    fit: BoxFit.scaleDown,
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
                      "ZERO PLASTIC",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimenssion.width30dp,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: Dimenssion.height5dp),
                    child: Text(
                      "Pour un avenir sans plastique, agissons dès aujourd'hui.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color.fromRGBO(247, 191, 95, 1),
                          fontSize: Dimenssion.width30dp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => Welcome(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(247, 191, 95, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          'Terminer',
                          style: TextStyle(fontSize: Dimenssion.width20dp),
                        ),
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
