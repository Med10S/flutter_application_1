import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/src/user_interface/chart.dart';
import 'package:flutter_application_1/src/user_interface/chart2.dart';

import '../welcome.dart';
import 'code_scanner.dart';
import 'compte.dart';

class User_Main_Page extends StatefulWidget {
  User_Main_Page({super.key});

  @override
  State<User_Main_Page> createState() => _User_Main_PageState();
}

class _User_Main_PageState extends State<User_Main_Page> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    User_Main_Page(),
    const compte(),
    const Welcome(),
    QRScan()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> time = [
    "09/03/2023",
    "10/03/2023",
    "15/03/2023",
    "15/03/2023",
    "15/03/2023"
  ];

  List<double> quantite = [3, 10, 6, 10, 20];

//openssl
  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/logo.png'),
          Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).cardColor,
            ),
            height: Dimenssio.FirstPagesImageHeight / 2,
            width: Dimenssio.screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "50,25",
                  style: TextStyle(
                      fontSize: Dimenssio.width20dp * 4,
                      color: const Color.fromRGBO(230, 198, 84, 1)),
                ),
                Text(
                  "Points",
                  style: TextStyle(
                      fontSize: Dimenssio.width20dp * 2,
                      color: const Color.fromRGBO(230, 198, 84, 1)),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.all(
                  Radius.circular(20)),
            ),
            child: SizedBox(
              height: Dimenssio.height250dp/1,
              child: ListTileTheme(
                tileColor: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: time.length,
                  // Appliquer un BorderRadius de 20 à tous les éléments de la liste
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(top: Dimenssio.width16dp),
                      child: Material(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(20),
                        child: ListTileTheme(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: itemBuilder(context, index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => QRScan(),
              ));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Image.asset('images/QR.png'),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        shape: const CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => User_Main_Page(),
                            ));
                      },
                      child: Image.asset("images/home.png")),
                  const Text(
                    "home",
                    style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => chartDays(),
                            ));
                      },
                      child: Image.asset("images/chart.png")),
                  const Text(
                    "Statistique",
                    style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => compte(),
                            ));
                    },
                    child: Image.asset("images/info_client.png")),
                  const Text(
                    "Compte",
                    style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => Welcome(),
                            ));
                      },
                      child: Image.asset("images/EXIT.png")),
                  const Text(
                    "Sortir",
                    style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  itemBuilder(BuildContext context, int index) {
    
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time[index],
            style: TextStyle(
                fontSize: Dimenssio.width24dp / 1.2,
                color: Theme.of(context).brightness == Brightness.dark ?  Colors.white : Color.fromRGBO(14, 77, 89, 1),),
          ),
          Text(
            quantite[index].toString() + " Point(s)",
            style: TextStyle(
                fontSize: Dimenssio.width24dp / 1.3,
                color: Theme.of(context).brightness == Brightness.dark ?  Colors.white : Color.fromRGBO(14, 77, 89, 1),),
          ),
        ],
      ),
      trailing: Image.asset('images/recycleviewicon.png'),
      onTap: () {
        // Action à exécuter lorsqu'on appuie sur l'élément de la liste
      },
    );
  }
}
