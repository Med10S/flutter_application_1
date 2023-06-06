
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecyclingItem extends StatelessWidget {
  final String itemName;
  final String decompositionTime;
  final String imageAsset;

  const RecyclingItem({
    super.key, 
    required this.itemName,
    required this.decompositionTime,
    required this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        imageAsset,
      ),
      title: Text(itemName),
      subtitle: Text('Temps de décomposition : $decompositionTime'),
    );
  }
}
