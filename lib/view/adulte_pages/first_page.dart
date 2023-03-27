import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/view/welcome.dart';

import '../../utilities/dimention.dart';
import 'pollution/Pollution.dart';

class firstPage extends StatelessWidget {
  const firstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.only(
            right: Dimenssio.width80dp / 2,
            left: Dimenssio.width80dp / 3,
            top: Dimenssio.height40dp
            ),
        color: const Color.fromRGBO(47, 103, 23, 1),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Container(
                alignment:Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, CupertinoPageRoute(
                                builder: (_) => Welcome(),
                              ));
                  },
                  child: Icon(Icons.arrow_back_ios_new,color: Colors.white,),)
                  ),
            Image.asset('images/logo.png'),
            
            Container(
              height: Dimenssio.height250dp,
              alignment: Alignment.center,
             // margin: EdgeInsets.symmetric(vertical: Dimenssio.height20dp *5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: double.infinity,
                      height: Dimenssio.height20dp * 2,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => Pollution(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(247, 191, 95, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          'Pollution',
                          style: TextStyle(fontSize: Dimenssio.width20dp),
                        ),
                      )),
                  SizedBox(
                    height: Dimenssio.height20dp * 1.5,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: Dimenssio.height20dp * 2,
                      child: ElevatedButton(
                        onPressed: () {
                          /*Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => Welcome(),
                            ));*/
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(247, 191, 95, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text(
                          'Recyclage',
                          style: TextStyle(fontSize: Dimenssio.width20dp),
                        ),
                      )),
                     
                ],
              ),
            ),
          ],
          
        ),
      ),
      
    )
    );
  }
}
