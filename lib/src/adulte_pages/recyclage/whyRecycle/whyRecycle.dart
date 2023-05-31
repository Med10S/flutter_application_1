import 'package:flutter/material.dart';

import 'SurfriderFoundationDetailsPage.dart';
import 'amaedatails.dart';
import 'greenspaceD.dart';
import 'wwfdetail.dart';


class WhyRecyclage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Organismes environnementaux'),
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'pourquoi recycler?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Le recyclage permet non seulement de réduire l\'impact environnemental de la production de nouveaux produits en évitant l\'extraction de nouvelles ressources naturelles, mais il permet également de créer de nouveaux emplois dans le secteur du recyclage et de la valorisation des déchets. En favorisant une économie circulaire, où les déchets sont considérés comme des ressources plutôt que comme des déchets à éliminer, le recyclage peut contribuer à la création d\'emplois locaux durables tout en préservant les ressources naturelles et en réduisant les émissions de gaz à effet de serre.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Organismes engagés dans la lutte contre le réchauffement climatique et la protection de l\'environnement :',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            _buildOrganizationCard(
              context,
              'Greenpeace',
              'Organisation internationale indépendante qui agit pour la protection de l\'environnement et la lutte contre le changement climatique.',
              Colors.green.shade200,
              Icons.eco,
              () {
                // Ajoutez ici la logique de navigation vers la page détaillée de Greenpeace
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GreenpeaceDetailsPage(),
                  ),
                );
              },
            ),
            _buildOrganizationCard(
              context,
              'WWF',
              'Organisation internationale de protection de la nature qui agit pour la préservation des écosystèmes et des espèces animales en danger.',
              Colors.orange.shade200,
              Icons.nature,
              () {
                // Ajoutez ici la logique de navigation vers la page détaillée du WWF
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WWFDetailsPage(),
                  ),
                );
              },
            ),
            _buildOrganizationCard(
              context,
              'Surfrider Foundation Maroc',
              'Association qui lutte contre la pollution des océans et des littoraux.',
              Colors.blue.shade200,
              Icons.waves,
              () {
                // Ajoutez ici la logique de navigation vers la page détaillée de Surfrider Foundation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurfriderFoundationDetailsPage(),
                  ),
                );
              },
            ),
            _buildOrganizationCard(
              context,
              'Association Maroc des amis de l\'environnement',
              'Association qui œuvre pour la réduction et la valorisation des déchets à travers la mise en place de pratiques zéro déchet et zéro gaspillage.',
              Colors.pink.shade200,
              Icons.delete,
              () {
                // Ajoutez ici la logique de navigation vers la page détaillée de Zero Waste France
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AMAEDetailsPage(),
                  ),
                );
              },
            ),
            _buildOrganizationCard(
              context,
              'Association de Protection de lEnvironnement au Maroc',
              's\'engage activement dans la préservation de l\'environnement et la sensibilisation à travers des actions concrètes et des initiatives durables.',
              Colors.purple.shade200,
              Icons.lightbulb,
              () {
                // Ajoutez ici la logique de navigation vers la page détaillée du Pacte National pour la Transition Energétique
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => APEMDetailsPage(),
                  ),
                );
              },
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildOrganizationCard(
      BuildContext context, String title, String description, Color color, IconData iconData, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              iconData,
              color: Colors.white,
              size: 30,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}

// Exemple de page détaillée pour Greenpeace




//  page détaillée pour le APEM

class APEMDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 200, // Hauteur raisonnable pour la photo
            child: Image.asset(
              'assets/apem_photo.jpg',
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
                    'Association de Protection de l\'Environnement au Maroc',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'L\'Association de Protection de l\'Environnement au Maroc (APEM) est dédiée à la préservation et à la protection de l\'environnement au Maroc. Elle mène des actions pour la sensibilisation, la conservation de la biodiversité, la gestion des déchets et la promotion des énergies renouvelables. L\'APEM travaille en étroite collaboration avec les communautés locales, les autorités et les autres acteurs pour promouvoir des pratiques durables et une meilleure qualité de vie.',
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
                      // Gérer l'ouverture du site web de l'APEM
                    },
                    child: Text(
                      'www.apem.ma',
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


// Exemple de page détaillée pour Surfrider Foundation




// Exemple de page détaillée pour Zero Waste France




