import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utilities/dimention.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

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
                      'images/back2.png',
                      width: Dimenssio.screenWidth,
                      fit: BoxFit.fill,
                    ),
                    Image.asset(
                        height: Dimenssio.FirstPagesImageHeight,
                      'images/Group2.png',
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
                      "CLEAN EARTH",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimenssio.width30dp,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        
                        top: Dimenssio.height5dp),
                    child:  Text(
                      "Une planète propre pour un avenir durable",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: const Color.fromRGBO(247, 191, 95, 1),
                          fontSize: Dimenssio.width30dp,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          right: Dimenssio.width30dp,
                          top: Dimenssio.height5dp
                          ),
                      alignment: Alignment.topRight,
                      child: Image.asset('images/next.png'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
