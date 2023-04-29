// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/utilities/string.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/nature.dart';

import '../../../colors/colors.dart';
import '../first_page.dart';
import 'definition.dart';
import 'types.dart';

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
                  children: [
                    SizedBox(
                      height: Dimenssion.height55dp,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const definition(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Mcolors.Cbackground,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimenssion.width30dp / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Definition",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimenssion.width16dp),
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimenssion.height55dp,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const naturePollution(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Mcolors.Cbackground,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimenssion.width30dp / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Strings.nature_Pollution,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimenssion.width16dp),
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimenssion.height55dp,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Mcolors.Cbackground,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimenssion.width30dp / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Source de pollution",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimenssion.width16dp),
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimenssion.height55dp,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => TypesPollution(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Mcolors.Cbackground,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimenssion.width30dp / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "type de pollution",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimenssion.width16dp),
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                    ),
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
