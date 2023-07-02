import 'package:flutter/material.dart';

class GreenpeaceDetailsPage extends StatelessWidget {
  const GreenpeaceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Détails - Greenpeace'),
          backgroundColor: Colors.green,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'images/greenpeace_photo.png',
                  height: 200, // Hauteur raisonnable pour la photo
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Greenpeace',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Greenpeace est une organisation internationale indépendante qui agit pour la protection de l\'environnement et la lutte contre le changement climatique. Elle mène des campagnes de sensibilisation, de plaidoyer et d\'action directe pour préserver la biodiversité, lutter contre la déforestation, promouvoir les énergies renouvelables et protéger les océans.',
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
                  // Gérer l'ouverture du site web de Greenpeace
                },
                child: const Text(
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
      ),
    );
  }
}
