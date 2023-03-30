import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/view/Apropos_Pages/pageDePassage.dart';
import 'package:flutter_application_1/view/fist_pages/page2.dart';
import 'package:flutter_application_1/view/fist_pages/pageDePassage.dart';
import 'package:flutter_application_1/view/welcome.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromRGBO(47, 103, 23, 1),
          child: Column(
            children: [
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'images/back.png',
                      width: Dimenssio.screenWidth,
                      fit: BoxFit.fitWidth,
                    ),
                    Image.asset(
                      'images/Group3.png',
                      height: Dimenssio.FirstPagesImageHeight,
                      fit: BoxFit.scaleDown,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        left: Dimenssio.width55dp,
                        right: Dimenssio.width55dp,
                        top: Dimenssio.height5dp),
                    alignment: Alignment.center,
                    child:  Text(
                      "ZERO PLASTIC",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimenssio.width30dp,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        
                        top: Dimenssio.height5dp),
                    child: Text(
                      "Pour un avenir sans plastique, agissons dès aujourd'hui.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color.fromRGBO(247, 191, 95, 1),
                          fontSize: Dimenssio.width30dp,
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
                        child:  Text(
                          'Terminer',
                          style: TextStyle(fontSize: Dimenssio.width20dp),
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