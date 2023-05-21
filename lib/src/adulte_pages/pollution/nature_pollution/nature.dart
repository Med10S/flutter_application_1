import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/src/adulte_pages/pollution/definition/definition.dart';
import 'package:flutter_application_1/src/adulte_pages/recyclage/recyclage.dart';
import 'package:flutter_application_1/utilities/string.dart';

import '../../../../widgets/custum_dialog.dart';
import '../../../../utilities/dimention.dart';

// ignore: camel_case_types
class naturePollution extends StatelessWidget {
  const naturePollution({super.key});

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    return Scaffold(
      body: SafeArea(
          child: Container(
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: Dimenssion.FirstPagesImageHeight / 2.5,
                  alignment: Alignment.topRight,
                  child: Image.asset('images/terre.png'),
                ),
                Image.asset('images/logo.png'),
              ],
            ),
            Text(
              'Nature de pollution',
              style: TextStyle(
                fontSize: Dimenssion.width24dp,
                color: const Color.fromRGBO(247, 191, 95, 1),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: Dimenssion.heightCdp),
              child: Text(
                'Selectionnez le type de pollution pour obtenir une definition et des exemples',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Dimenssion.width16dp,
                  color: Colors.white,
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).canvasColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(const Size(200, 60)),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Mcolors.couleurPrincipal2;
                    }
                    return Theme.of(context).colorScheme.onSurface;
                  },
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10.0),
                ), //  reduce the vertical padding
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/physique.png', height: 30),
                  SizedBox(
                    width: Dimenssion.width20dp,
                  ),
                  const Text('pollution physique'),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog(
                        title: 'pollution physique',
                        description:"",//, Strings.pollutionphysique,
                        buttonText: 'Close',
                        image: Image.asset('images/physique.png'),
                        isDark: isDark);
                  },
                );
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).canvasColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(const Size(200, 60)),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Colors.grey;
                    }
                    return Theme.of(context).colorScheme.onSurface;
                  },
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10.0),
                ), //  reduce the vertical padding
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/chimique.png', height: 30),
                  SizedBox(
                    width: Dimenssion.width20dp,
                  ),
                  const Text('pollution chimique2'),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog(
                        title: 'pollution chimique',
                        description:"",// Strings.pollutionchimique,
                        buttonText: 'Close',
                        image: Image.asset('images/chimique.png'),
                        isDark: isDark);
                  },
                );
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).canvasColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(const Size(200, 60)),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.disabled)) {
                      return Mcolors.couleurPrincipal2;
                    }
                    return Theme.of(context).colorScheme.onSurface;
                  },
                ),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(vertical: 10.0),
                ), // reduce the vertical padding
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('images/biologique.png', height: 30),
                  SizedBox(
                    width: Dimenssion.width20dp,
                  ),
                  const Text('pollution biologique'),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog(
                        title: 'pollution biologique',
                        description:"",// Strings.pollutionbio,
                        buttonText: 'Close',
                        image: Image.asset('images/biologique.png'),
                        isDark: isDark);
                  },
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (_) => const Recyclage()));
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
                              builder: (_) => const naturePollution()));
                      // Fonction appelée lors du clic sur le bouton
                    },
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: Dimenssion.height40dp,
                    )),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
