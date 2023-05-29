

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custum_dialog.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/utilities/string.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';

import '../../../colors/colors.dart';
import 'logo.dart';
//done
class PoubelleRecyclage extends StatelessWidget {
  const PoubelleRecyclage({super.key});

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
              Text('Poubelle recyclage : comment bien trier ses déchets ?',textAlign: TextAlign.center,
                  style: TextStyle(
                    
                    fontSize: Dimenssion.width24dp,
                    color: Mcolors.couleurSecondaire,
                  )),
              Container(
                margin: EdgeInsets.symmetric(
                    vertical: Dimenssion.height40dp / 4,
                    horizontal: Dimenssion.width24dp),
                child: Text(
                  Strings.poubelleRecyclage,
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
                            Colors.red),
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
                      child:const  Center(
                        
                          child: Text(
                            'Poubelle Rouge',
                          ),
                       
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: 'Les metaux',
                              description: Strings.poubelleRouge,
                              buttonText: 'Close',
                              image: Image.asset('images/metals.png'),
                              isDark: isDark,
                            );
                          },
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.green),
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
                      child: const Center(
                        
                          child: Text('Poubelle Verte'),
                        
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                                title: 'Le verre',
                                description: Strings.poubelleVerte,
                                buttonText: 'Close',
                                image: Image.asset('images/verre.png'),
                                isDark: isDark);
                          },
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 13, 110, 189)),
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
                      child:const Center(
                        
                          child: Text('Poubelle Bleue'),
                        
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: 'Le papier',
                              description: Strings.poubelleBleue,
                              buttonText: 'Close',
                              image: Image.asset('images/paper.png'),
                              isDark: isDark,
                            );
                          },
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.yellow),
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
                      child: const Center(
                        
                          child: Text('Poubelle Jaune'),
                       
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: 'Le plastique',
                              description: Strings.poubelleJaune,
                              buttonText: 'Close',
                              image: Image.asset('images/plastic1.png'),
                              isDark: isDark,
                            );
                          },
                        );
                      },
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.grey),
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
                      child: const Center(
                        
                          child: Text('Poubelle Grise'),
                       
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomDialog(
                              title: 'Autre',
                              description: Strings.poubelleGrise,
                              buttonText: 'Close',
                              image: Image.asset('images/compost.png'),
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
                                builder: (_) =>  LogoRecyclage()));
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

