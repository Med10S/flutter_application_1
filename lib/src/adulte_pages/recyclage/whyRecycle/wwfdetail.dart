import 'package:flutter/material.dart';

// Exemple de page détaillée pour le WWF
class WWFDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Détails - WWF'),
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 200, // Hauteur raisonnable pour la photo
              child: Image.asset(
                'images/wwf_photo.png',
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
                      'WWF Maroc',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'WWF Maroc est l\'antenne locale de l\'organisation internationale de protection de la nature, le World Wide Fund for Nature (WWF). Nous nous engageons pour la conservation de la biodiversité et la protection de l\'environnement au Maroc. Notre objectif est de préserver les écosystèmes naturels, de promouvoir des pratiques durables et de sensibiliser le public aux enjeux environnementaux. Nous travaillons en partenariat avec les communautés locales, les autorités et les autres acteurs pour assurer un avenir durable pour les générations futures.',
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
                        // Gérer l'ouverture du site web du WWF Maroc
                      },
                      child: const Text(
                        'www.worldwildlife.org',
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
      ),
    );
  }
}
