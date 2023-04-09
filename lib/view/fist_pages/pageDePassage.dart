import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/fist_pages/page1.dart';
import 'package:flutter_application_1/view/fist_pages/page2.dart';
import 'package:flutter_application_1/view/fist_pages/page3.dart';

// Définissez une liste de widgets pour chaque page
final List<Widget> pages = [Page1(), Page2(), Page3()];

// Dans le widget de votre écran, ajoutez un PageView et un DotsIndicator
class MyScreen extends StatefulWidget {
  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
            decoration:
                BoxDecoration(color: Theme.of(context).primaryColor),
            child: DotsIndicator(
              dotsCount: pages.length,
              position: _currentPageIndex.toDouble(),
              decorator: const DotsDecorator(
                color: Colors.grey, // Couleur des points inactifs
                activeColor:
                    Color.fromRGBO(247, 191, 95, 1), // Couleur du point actif
              ),
            ),
          ),
        ],
      ),
    );
  }
}
