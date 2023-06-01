
import 'package:flutter/material.dart';

class SurfriderFoundationDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200, // Hauteur raisonnable pour la photo
            child: Image.asset(
              'images/surfrider_photo.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Surfrider Foundation Maroc',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Surfrider Foundation Maroc est une association qui lutte contre la pollution des océans et des littoraux au Maroc. Notre mission est de préserver les écosystèmes marins, de promouvoir la qualité des eaux côtières et de sensibiliser le public aux enjeux de la protection des océans. Nous organisons des campagnes de nettoyage des plages, des actions de sensibilisation et nous collaborons avec les autorités et les acteurs locaux pour promouvoir des pratiques respectueuses de l\'environnement. Rejoignez-nous pour protéger nos océans et préserver notre patrimoine naturel !',
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
                      // Gérer l'ouverture du site web de Surfrider Foundation Maroc
                    },
                    child: Text(
                      'www.surfridermaroc.com',
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
          ),
        ],
      ),
    );
  }
}