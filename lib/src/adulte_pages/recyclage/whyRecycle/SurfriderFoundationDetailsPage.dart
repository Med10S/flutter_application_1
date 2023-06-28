import 'package:flutter/material.dart';

class SurfriderFoundationDetailsPage extends StatelessWidget {
  const SurfriderFoundationDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200, // Hauteur raisonnable pour la photo
            child: Image.asset(
              'images/surfrider_photo.png',
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
                    'Surfrider Foundation Maroc',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Surfrider Foundation Maroc est une association qui lutte contre la pollution des océans et des littoraux au Maroc. Notre mission est de préserver les écosystèmes marins, de promouvoir la qualité des eaux côtières et de sensibiliser le public aux enjeux de la protection des océans. Nous organisons des campagnes de nettoyage des plages, des actions de sensibilisation et nous collaborons avec les autorités et les acteurs locaux pour promouvoir des pratiques respectueuses de l\'environnement. Rejoignez-nous pour protéger nos océans et préserver notre patrimoine naturel !',
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
                      // Gérer l'ouverture du site web de Surfrider Foundation Maroc
                    },
                    child: const Text(
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
