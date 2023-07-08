import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  final String id;
  final String image;
  final String name;
  final String description;
  final double price;
  final String categorie;
  final int quatite;

  Product(
      {required this.image,
      required this.name,
      required this.description,
      required this.id,
      required this.categorie,
      required this.quatite,
      required this.price});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'name': name,
      'description': description,
      'price': price,
      'categorie': categorie,
      'quatite': quatite
    };
  }

  factory Product.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    return Product(
      image: data['image'],
      name: data['name'],
      description: data['description'],
      price: data['price'].toDouble(),
      id: data['id'],
      categorie: data['categorie'],
      quatite: data['quatite'],
    );
  }
}
