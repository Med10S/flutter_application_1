import 'package:flutter/material.dart';

class GreenpeaceDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'images/greenpeace_photo.jpg',
                height: 200, // Hauteur raisonnable pour la photo
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Greenpeace',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Greenpeace est une organisation internationale indépendante qui agit pour la protection de l\'environnement et la lutte contre le changement climatique. Elle mène des campagnes de sensibilisation, de plaidoyer et d\'action directe pour préserver la biodiversité, lutter contre la déforestation, promouvoir les énergies renouvelables et protéger les océans.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Site web:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                // Gérer l'ouverture du site web de Greenpeace
              },
              child: Text(
                'www.greenpeace.org',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
