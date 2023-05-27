import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/fist_pages/page1.dart';
import 'package:flutter_application_1/src/fist_pages/page2.dart';
import 'package:flutter_application_1/src/fist_pages/page3.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../welcome.dart';

// Définissez une liste de widgets pour chaque page
final List<Widget> pages = [Page1(), const Page2(), const Page3()];

// Dans le widget de votre écran, ajoutez un PageView et un DotsIndicator
class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  int _currentPageIndex = 0;
  bool isFirstRun = true;
  @override
  void initState() {
    super.initState();
    checkFirstRun();
  }
  Future<bool>? checkFirstRun() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstRun = prefs.getBool('isFirstRun') ?? true;
return isFirstRun;
   
  }
  void redirectToHomePage() {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Welcome()));

   
  }
    @override

 Widget build(BuildContext context) {
  return Scaffold(
    body: FutureBuilder<bool>(
      future: checkFirstRun(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.data == true) {
          return Column(
            children: [
              Expanded(
                child: PageView(
                  children: pages,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: DotsIndicator(
                  dotsCount: pages.length,
                  position: _currentPageIndex.toDouble(),
                  decorator: const DotsDecorator(
                    color: Colors.grey, // Couleur des points inactifs
                    activeColor: Color.fromRGBO(247, 191, 95, 1), // Couleur du point actif
                  ),
                ),
              ),
            ],
          );
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Welcome()),
            );
          });
          return Container(); // Placeholder widget
        }
      },
    ),
  );
}


}
