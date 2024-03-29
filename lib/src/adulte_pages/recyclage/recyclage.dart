// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/botton.dart';
import 'package:flutter_application_1/utilities/dimention.dart';

import '../first_page.dart';

class Recyclage extends StatelessWidget {
  const Recyclage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: Dimenssion.screenHeight,
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
                  alignment:Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(
                                  builder: (_) => const Education(),
                                ));
                    },
                    child: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),)
                    ),
                Column(
                  children: [
                    Image.asset('images/logo.png'),
                    SizedBox(
                      height: Dimenssion.height20dp * 1.5,
                    ),
                    Text('Recyclage',
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
//done
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      CustomButton(text: "Définiton",root: "/Rdefinition",),
                      CustomButton(text: "La méthode de « 3R »",root: "/3R",),
                      CustomButton(text: "Logo recyclage",root: "/LogoRecyclage",),
                      CustomButton(text: "Poubelle recyclage",root: "/Poubelle",),
                      CustomButton(text: "Durée de recyclage",root: "/DureeRecyclage",),
                      CustomButton(text: "Pourquoi recycler",root: "/whyRecyclage",),

                        ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //container
  }
}
