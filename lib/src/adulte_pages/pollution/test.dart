
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
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
}

class MyGridView extends StatelessWidget {
  final List<String> buttonTitles = ['Bouton 1', 'Bouton 2', 'Bouton 3', 'Bouton 4', 'Bouton 5', 'Bouton 6'];
  final List<ImageProvider> buttonImages = [
    AssetImage('images/logo.png'),
    AssetImage('images/logo.png'),
    AssetImage('images/logo.png'),
    AssetImage('images/logo.png'),
    AssetImage('images/logo.png'),
    AssetImage('images/logo.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GridView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: buttonTitles.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.5,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            return CustomButton(
              buttonText: buttonTitles[index],
              onPressed: () {
                // Logique à exécuter lorsque le bouton est pressé
              },
              imageProvider: buttonImages[index],
            );
          },
        ),
      ),
    );
  }
}
