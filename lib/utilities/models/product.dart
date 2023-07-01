import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String image;
  final String name;
  final String description;
  final double price;

  Product(
      {required this.image,
      required this.name,
      required this.description,
      required this.price});

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
      'description': description,
      'price': price,
    };
  }

  factory Product.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return Product(
      snapshot['image'],
      snapshot['name'],
      snapshot['description'],
      snapshot['price'].toDouble(),
    );
  }
}
