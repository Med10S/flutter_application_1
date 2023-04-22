import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final IconData iconData;

  CustomButton({
    required this.buttonText,
    required this.onPressed,
    required this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (iconData != null) // Vérifie si l'icône a été fournie
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  iconData,
                  color: Colors.white,
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
        
      ),
    );
  }
}

class MyGridView extends StatelessWidget {
  final List<String> buttonTitles = ['Bouton 1', 'Bouton 2', 'Bouton 3', 'Bouton 4', 'Bouton 5', 'Bouton 6'];
  final List<IconData> buttonIcons = [Icons.add, Icons.delete, Icons.edit, Icons.favorite, Icons.share, Icons.search];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            iconData: buttonIcons[index],
          );
        },
      ),
    );
  }
}
