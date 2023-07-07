import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/Apropos_Pages/equipe.dart';
import 'package:flutter_application_1/src/Apropos_Pages/objective.dart';
import 'package:flutter_application_1/src/Apropos_Pages/stategie.dart';

// Définissez une liste de widgets pour chaque page
final List<Widget> pages = [
  const Equipe(),
  const Objective(),
  const Strategie()
];

// Dans le widget de votre écran, ajoutez un PageView et un DotsIndicator
class Apropos extends StatefulWidget {
  const Apropos({super.key});

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<Apropos> {
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
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: DotsIndicator(
              dotsCount: pages.length,
              position: _currentPageIndex,
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
