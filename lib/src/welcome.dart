import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/src/adulte_pages/first_page.dart';
import 'package:flutter_application_1/utilities/string.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Apropos_Pages/pageDePassage.dart';
import 'authentification/screens/admin_or_user.dart';

import 'package:shared_preferences/shared_preferences.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  bool _policyAccepted = false;

  @override
  void initState() {
    super.initState();
    _checkPolicyAcceptance();
  }

  Future<void> _checkPolicyAcceptance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool accepted = prefs.getBool('policy_accepted') ?? false;
    setState(() {
      _policyAccepted = accepted;
    });
  }

  Future<void> _acceptPolicy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('policy_accepted', true);
    setState(() {
      _policyAccepted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _policyAccepted
            ? null
            : AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: const Text('Politique de confidentialité'),
                centerTitle: true,
              ),
        body: _policyAccepted ? const Welcome() : _buildPolicyContent(),
      ),
    );
  }

  Widget _buildPolicyContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              Strings.politiqueDeConfidentialite,
              style: const TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: Dimenssion.height20dp / 2),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: Theme.of(context).indicatorColor),
              onPressed: () async {
                String email = 'garb.eco13@gmail.com';
                String url = 'mailto:<$email>?';
                Uri uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Erreur'),
                      content: const Text(
                          'Impossible d\'ouvrir l\'application de messagerie gmail.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.email, color: Colors.black),
                  Text(
                    'Contactez-nous par e-mail',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: Dimenssion.height20dp / 2),
            ElevatedButton(
              onPressed: _acceptPolicy,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  backgroundColor: Theme.of(context).primaryColor),
              child: Text('Accepter'.toUpperCase()),
            ),
          ],
        ),
      ),
    );
  }
}

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
      duration: const Duration(milliseconds: 500),
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
    return WillPopScope(
      onWillPop: () async {
        // Empêcher le retour en arrière en renvoyant "false"
        return false;
      },
      child: GestureDetector(
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
      ),
    );
  }

  Widget _buildInitialWidget() {
    return Scaffold(
      //safeArea pour commance au dessus de la bar de notification
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimenssion.height20dp * 4),
              child: Image.asset('images/logo.png'),
            ),
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
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) =>
                                    const Choicepageadminuser(), //LoginScreen(),
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
                              style: TextStyle(fontSize: Dimenssion.width20dp),
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
                                builder: (_) => const Education(),
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
                          padding: EdgeInsets.only(right: Dimenssion.width80dp),
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
    );
  }

  Widget _buildSwipedUpWidget() {
    return FadeTransition(
      opacity: _animation,
      child: const Apropos(), // Your swiped-up widget here
    );
  }
}

enum SwipeDirection {
  up,
  down,
  left,
  right,
}
