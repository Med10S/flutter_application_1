import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/models/product.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import '../../../utilities/models/cartProduct.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  createProduct(Product product) async {
    await _db
        .collection("Products")
        .doc(product.id)
        .set(product.toJson())
        .whenComplete(() => Get.snackbar(
            "Success", "Your Product has been Added",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green))
        .catchError((error, StackTrace) {
      Get.snackbar("Error", "Something went wrong.try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      //print(error.toString());
    });
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final path = 'images/$fileName';

      final storageRef = FirebaseStorage.instance.ref().child(path);

      final uploadTask = storageRef.putFile(imageFile);

      final snapshot = await uploadTask.whenComplete(() => Get.snackbar(
            "Success",
            "Your Product has been Added",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green,
          ));

      final urlDownload = await snapshot.ref.getDownloadURL();
      print('Download Link: $urlDownload');

      return urlDownload;
    } catch (error) {
      print("Error uploading image: $error");
      Get.snackbar(
        "Error",
        "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      return "";
    }
  }

  Future<List<Product>> extractAllProducts() async {
    List<Product> products = [];

    final snapshot = await _db.collection("Products").get();
    for (var doc in snapshot.docs) {
      Product product = Product.fromSnapshot(doc);
      products.add(product);
    }

    print("Extraction des produits terminée.");

    return products;
  }

  Future<void> saveCartProduct(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convertir le cartProduct en un Map
    Map<String, dynamic> cartProductData = {
      'productImage': product.image,
      'productId': product.id,
      'productName': product.name,
      'productPrice': product.price,
      'quantity': 1,
    };

    // Sauvegarder le cartProductData dans SharedPreferences
    await prefs.setString(product.id, json.encode(cartProductData));
  }

  Future<List<CartProduct>> getCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Récupérer la liste de cartProductsData depuis SharedPreferences
    String? cartProductsData = prefs.getString('cartProducts');

    if (cartProductsData != null) {
      // Convertir la liste de Map en une liste de cartProducts
      List<dynamic> decodedData = json.decode(cartProductsData);
      List<CartProduct> cartProducts = decodedData.map((data) {
        return CartProduct(
          productImage: data['productImage'],
          productId: data['productId'],
          productName: data['productName'],
          productPrice: data['productPrice'],
          quantity: data['quantity'],
        );
      }).toList();

      return cartProducts;
    } else {
      // Aucune donnée trouvée, retourner une liste vide
      return [];
    }
  }
}
