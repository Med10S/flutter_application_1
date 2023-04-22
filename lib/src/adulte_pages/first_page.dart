import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/src/adulte_pages/recyclage/recyclage.dart';
import 'package:flutter_application_1/src/welcome.dart';

import '../../utilities/dimention.dart';
import 'pollution/Pollution.dart';

// ignore: camel_case_types
class firstPage extends StatelessWidget {
  const firstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            right: Dimenssion.width80dp / 2,
            left: Dimenssion.width80dp / 3,
            top: Dimenssion.height40dp),
        color: Theme.of(context).primaryColor,
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) =>const Welcome(),
                        ));
                  },
                  child:const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                )),
            Image.asset('images/logo.png'),
            Container(
              height: Dimenssion.height250dp,
              alignment: Alignment.center,
              // margin: EdgeInsets.symmetric(vertical: Dimenssio.height20dp *5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: Dimenssion.height20dp * 2,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const Pollution(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Mcolors.couleurSecondaire,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          'Pollution',
                          style: TextStyle(fontSize: Dimenssion.width20dp),
                        ),
                      )),
                  SizedBox(
                    height: Dimenssion.height20dp * 1.5,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: Dimenssion.height20dp * 2,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => const Recyclage(),
                            ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Mcolors.couleurSecondaire,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          'Recyclage',
                          style: TextStyle(fontSize: Dimenssion.width20dp),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
