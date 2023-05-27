// ignore: camel_case_types
// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custum_dialog.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/utilities/string.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

import '../../../colors/colors.dart';
import 'definiton_R/definition.dart';
import 'logo.dart';

class R_3 extends StatefulWidget {
  const R_3({super.key});

  @override
  State<R_3> createState() => _R_3State();
}

class _R_3State extends State<R_3> {
  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: Dimenssion.screenHeight,
                  alignment: Alignment.centerLeft,
                  color: Theme.of(context).primaryColor,
                  child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      height: Dimenssion.FirstPagesImageHeight / 2.5,
                      alignment: Alignment.topRight,
                      child: Image.asset('images/terre.png')),
                  Image.asset('images/logo.png')
                ],
              ),
              Text('La méthode de « 3R »',
                  style: TextStyle(
                    fontSize: Dimenssion.width24dp,
                    color: Mcolors.couleurSecondaire,
                  )),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: Dimenssion.height40dp / 4,
                    horizontal: Dimenssion.width24dp),
                child: Text(
                  Strings.r_3_1,
                  style: TextStyle(
                      fontSize: Dimenssion.width16dp, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: Dimenssion.height40dp / 4,
                    horizontal: Dimenssion.width55dp),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).canvasColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey;
                            }
                            return Theme.of(context).colorScheme.onSurface;
                          },
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/decrease.png', height: 30),
                          SizedBox(
                            width: Dimenssion.width20dp,
                          ),
                          const Text(
                            'Réduire',
                          ),
                        ],
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: 'Réduire',
                              description: Strings.reduire,
                              buttonText: 'Close',
                              image: Image.asset('images/decrease.png'),
                              isDark: isDark,
                            );
                          },
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).canvasColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey;
                            }
                            return Theme.of(context).colorScheme.onSurface;
                          },
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('images/reuse.png', height: 30),
                          SizedBox(
                            width: Dimenssion.width20dp,
                          ),
                          const Text('Réutiliser'),
                        ],
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                                title: 'Réutiliser',
                                description: Strings.reutiliser,
                                buttonText: 'Close',
                                image: Image.asset('images/reuse.png'),
                                isDark: isDark);
                          },
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).canvasColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey;
                            }
                            return Theme.of(context).colorScheme.onSurface;
                          },
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'images/recycle.png',
                            height: 30,
                          ),
                          SizedBox(
                            width: Dimenssion.width20dp,
                          ),
                          const Text('Recycler'),
                        ],
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: 'Recycler',
                              description: Strings.recycle,
                              buttonText: 'Close',
                              image: Image.asset('images/recycle.png'),
                              isDark: isDark,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (_) => const DefRecyclage()));
                        // Fonction appelée lors du clic sur le bouton
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: Dimenssion.height40dp,
                      )),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (_) =>LogoRecyclage()));
                        // Fonction appelée lors du clic sur le bouton
                      },
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: Dimenssion.height40dp,
                      )),
                ],
              )
            ],
                  ),
                ),
          )),
    );
  }

  void _showCustomDialog(BuildContext context, String titre, String contenue) {
    showPlatformDialog(
      context: context,
      builder: (context) => BasicDialogAlert(
        title: Text(titre),
        content: Text(contenue),
        actions: <Widget>[
          BasicDialogAction(
            title: const Text("Terminer"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
