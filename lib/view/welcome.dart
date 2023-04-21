import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/view/adulte_pages/first_page.dart';
import 'package:flutter_application_1/view/fist_pages/page1.dart';

import 'Apropos_Pages/equipe.dart';
import 'Apropos_Pages/pageDePassage.dart';
import 'login_signin/login.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _swipedUp = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /**utilisation de dismissible pour pouvois scroller vers le haut
     *UniqueKey() est une classe de la bibliothèque Flutter qui permet de générer une
     * clé unique utilisée pour identifier de manière unique un widget dans l'ensemble de
     *l'arborescence des widgets de l'application Flutter. 
      */
    return GestureDetector(
      key: UniqueKey(),
      onVerticalDragUpdate: (details) {
        // Get the vertical drag distance and direction
        double distance = details.delta.dy;

        SwipeDirection direction =
            distance < 0 ? SwipeDirection.up : SwipeDirection.down;
        const double SWIPE_THRESHOLD = 10.0;

        // If the distance is greater than a certain threshold and the direction is up, trigger the swipe action
        if (distance.abs() > SWIPE_THRESHOLD &&
            direction == SwipeDirection.up) {
          _animationController.forward(from: 0.0);
          setState(() {
            _swipedUp = true;
            // Trigger the appropriate action, such as navigating to a different screen
            // For example:
          });
        }
      },
      child: _swipedUp ? _buildSwipedUpWidget() : _buildInitialWidget(),
    );
  }

  Widget _buildInitialWidget() {
    return Container(
      child: Scaffold(
        //safeArea pour commance au dessus de la bar de notification
        body: SafeArea(
            child: Container(
          alignment: Alignment.center,
          color: Theme.of(context).primaryColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                    right: Dimenssion.width80dp / 4,
                    left: Dimenssion.width80dp / 4,
                    bottom: Dimenssion.height20dp * 4,
                    top: Dimenssion.height20dp * 2),
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: Dimenssion.height20dp),
                      alignment: Alignment.center,
                      child: Image.asset('images/logo.png'),
                    ),
                    SizedBox(
                      height: Dimenssion.height20dp * 3,
                    ),
                    Container(
                        width: Dimenssion.width250dp / 1.2,
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => AuthPage(),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(247, 191, 95, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.asset(
                                'images/identifer.png',
                                height: Dimenssion.height40dp,
                              ),
                              Text(
                                'Votre espace',
                                style:
                                    TextStyle(fontSize: Dimenssion.width20dp),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(height: Dimenssion.height20dp),
                    Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => firstPage(),
                                ));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(247, 191, 95, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                            'Environnement',
                            style: TextStyle(fontSize: Dimenssion.width20dp),
                          ),
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: Dimenssion.height55dp),
                  child: Stack(
                    children: [
                      Image.asset(
                        'images/bottom.png',
                        width: double.maxFinite,
                        height: double.maxFinite,
                        fit: BoxFit.fill,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(right: Dimenssion.width80dp),
                            alignment: Alignment.topRight,
                            child: InkWell(
                              child: Image.asset(
                                'images/NEXTTOP.png',
                                height: Dimenssion.height20dp * 3,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          Container(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'A PROPOS DE NOUS',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Dimenssion.width80dp / 2,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
      // Your initial widget here
    );
  }

  Widget _buildSwipedUpWidget() {
    return FadeTransition(
      opacity: _animation,
      child: MyScreen2(), // Your swiped-up widget here
    );
  }
}

enum SwipeDirection {
  up,
  down,
  left,
  right,
}
