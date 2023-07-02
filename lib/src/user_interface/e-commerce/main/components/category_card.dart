import 'package:flutter/material.dart';

import '../../../../../utilities/models/category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 80,
                width: 90,
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    category.category,
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Container(
                height: 80,
                width: 90,
                decoration: BoxDecoration(
                    gradient: RadialGradient(
                        colors: [category.begin, category.end],
                        center: const Alignment(0, 0),
                        radius: 0.8,
                        focal: const Alignment(0, 0),
                        focalRadius: 0.1)),
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Image.asset(category.image),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
