import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/utilities/dimention.dart';

import '../first_page.dart';
import 'definition.dart';

class Pollution extends StatelessWidget {
  const Pollution({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            right: Dimenssio.width20dp / 2,
            left: Dimenssio.width20dp / 2,
            top: Dimenssio.height20dp * 1.5,
          ),
          //alignment: Alignment.center,
          color: const Color.fromRGBO(47, 103, 23, 1),
          child: Column(
            children: [
              Container(
                alignment:Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, CupertinoPageRoute(
                                builder: (_) => firstPage(),
                              ));
                  },
                  child: Icon(Icons.arrow_back_ios_new,color: Colors.white,),)
                  ),
              Column(
                children: [
                  Image.asset('images/logo.png'),
                  SizedBox(
                    height: Dimenssio.height20dp * 1.5,
                  ),
                  Text('Pollution',
                      style: TextStyle(
                        fontSize: Dimenssio.width24dp,
                        color: const Color.fromRGBO(247, 191, 95, 1),
                      )),
                ],
              ),
              SizedBox(
                height: Dimenssio.height20dp * 4,
              ),
              Container(
                height: Dimenssio.height250dp,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: Dimenssio.height55dp,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => definition(),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimenssio.width30dp / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Definition",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimenssio.width16dp),
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromRGBO(238, 238, 238, 0.64),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: Dimenssio.height55dp,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimenssio.width30dp / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Nature de pollution",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimenssio.width16dp),
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromRGBO(238, 238, 238, 0.64),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: Dimenssio.height55dp,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimenssio.width30dp / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Source de pollution",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimenssio.width16dp),
                              ),
                              Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromRGBO(238, 238, 238, 0.64),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    SizedBox(
                      height: Dimenssio.height55dp,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimenssio.width30dp / 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "type de pollution",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: Dimenssio.width16dp),
                              ),
                              const Icon(Icons.arrow_forward_ios,
                                  color: Colors.black),
                            ],
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Color.fromRGBO(238, 238, 238, 0.64),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
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
