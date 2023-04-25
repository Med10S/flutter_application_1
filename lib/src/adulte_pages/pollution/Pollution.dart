// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';

import '../../../utilities/botton.dart';
import '../first_page.dart';

class Pollution extends StatelessWidget {
  const Pollution({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            right: Dimenssion.width20dp / 2,
            left: Dimenssion.width20dp / 2,
            top: Dimenssion.height20dp * 1.5,
          ),
          //alignment: Alignment.center,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (_) => const firstPage(),
                          ));
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  )),
              Column(
                children: [
                  Image.asset('images/logo.png'),
                  SizedBox(
                    height: Dimenssion.height20dp * 1.5,
                  ),
                  Text('Pollution',
                      style: TextStyle(
                        fontSize: Dimenssion.width24dp,
                        color: const Color.fromRGBO(247, 191, 95, 1),
                      )),
                ],
              ),
              SizedBox(
                height: Dimenssion.height20dp * 4,
              ),

              SizedBox(
                height: Dimenssion.height250dp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CustomButton(text: "Définiton",root: "/Pdeffintion",),
                    CustomButton(text: "Nature de pollution" ,root: "/NaturePollution",),
                    CustomButton(text: "Source de pollution" ,root: "/Psourse",),
                    CustomButton(text: "type de pollution" ,root: "/Ptype",),
                   ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    //container
  }
}
