import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';

import '../../../widgets/models_ui/Recycling_model.dart';


class DureeRecyclage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Durées de décomposition des déchets'),
        backgroundColor: Theme.of(context).primaryColor
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            const Text(
              'Combien de temps prennent nos différents déchets pour se recycler ?',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,              ),
            ),
            SizedBox(height: Dimenssion.height20dp),
            const Text(
              'Ces durées indiquent le temps de décomposition de ces objets dans la nature en conditions optimales. Il est important de noter que même si certains matériaux se décomposent plus rapidement que d\'autres, cela ne signifie pas que leur impact sur l\'environnement est moins important. Les déchets peuvent causer des dommages importants à l\'environnement et à la faune avant de se décomposer complètement. Il est donc essentiel de recycler, réduire et réutiliser autant que possible pour minimiser notre impact sur la planète.',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: Dimenssion.height20dp),
            const RecyclingItem(
              itemName: 'Pelures de pomme',
              decompositionTime: '1 mois',
              imageAsset: "images/apple.png",
              
                          ),
            const RecyclingItem(
              itemName: 'Chewing-gum',
              decompositionTime: '5 ans',
              imageAsset: "images/chewing-gum.png",
              
              
            ),
            const RecyclingItem(
              itemName: 'Filtre de cigarette',
              decompositionTime: '10 à 12 ans',
              imageAsset: "images/cigarette.png",
              
                         ),
            const RecyclingItem(
              itemName: 'Canette en aluminium',
              decompositionTime: '200 ans',
              imageAsset: "images/can.png",
            ),
            const RecyclingItem(
              itemName: 'Bouteille en plastique',
              decompositionTime: '400 ans',
              imageAsset: "images/water-bottle.png",
            ),
            const RecyclingItem(
              itemName: 'Bouteille en verre',
              decompositionTime: '4000 ans',
              imageAsset: "images/wine-bottles.png",
            ),
            const RecyclingItem(
              itemName: 'Pile',
              decompositionTime: '8000 ans',
              imageAsset: "images/battery.png",
            ),
          ],
        ),
      ),
    );
  }
}

