import 'package:flutter/material.dart';

class AMAEDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200, // Hauteur raisonnable pour la photo
            child: Image.asset(
              'images/amae_photo.png',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Association Maroc des Amis de l\'Environnement',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'L\'Association Maroc des Amis de l\'Environnement (AMAE) est une organisation engagée dans la protection et la préservation de l\'environnement au Maroc. Notre mission est de promouvoir des pratiques respectueuses de l\'environnement, de sensibiliser la population aux enjeux environnementaux et de développer des projets durables pour préserver la biodiversité. Nous organisons des campagnes de reboisement, des programmes de nettoyage des espaces naturels et nous encourageons l\'adoption de comportements responsables. Rejoignez-nous pour construire un avenir meilleur pour l\'environnement et les générations futures !',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Site web:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () {
                      // Gérer l'ouverture du site web de l'AMAE
                    },
                    child: const Text(
                      'amaenvironnement.ma',
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
