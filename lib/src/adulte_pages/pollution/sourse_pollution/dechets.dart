import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/utilities/string.dart';

import '../../../../utilities/dimention.dart';
class Dechets extends StatelessWidget {
  const Dechets({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
            child: SingleChildScrollView(
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
                  Text('Definition',
                      style: TextStyle(
                        fontSize: Dimenssion.width24dp,
                        color: Mcolors.couleurSecondaire,
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: Dimenssion.height40dp,
                        horizontal: Dimenssion.width24dp),
                    child: Text(
                      Strings.dechetsDefinition,
                      style: TextStyle(
                          fontSize: Dimenssion.width16dp, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text('Exemples',
                      style: TextStyle(
                        fontSize: Dimenssion.width24dp,
                        color: Mcolors.couleurSecondaire,
                      )),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10,10,10,10), //ajouter un padding de 16.0 pixels
                    child: const Image(
                      image: AssetImage('images/Pol_dechets1.jpg'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10,10,10,10), //ajouter un padding de 16.0 pixels
                    child: const Image(
                      image: AssetImage('images/Pol_dechets2.jpg'),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10,10,10,10), //ajouter un padding de 16.0 pixels
                    child: const Image(
                      image: AssetImage('images/Pol_dechets3.jpg'),
                    ),
                  ),





                ],
              ),
            ),
          )),
    );
  }
}



//import 'package:flutter/material.dart';

/*class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final ImageProvider imageProvider;

  CustomButton({
    required this.buttonText,
    required this.onPressed,
    required this.imageProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (imageProvider != null) // Vérifie si l'image a été fournie
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image(
                image: imageProvider,
                width: 100.0,
                height: 85.0,
              ),
            ),
          Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),

    );
  }
}*/





