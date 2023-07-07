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

  Future<void> clearCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('cartProducts');
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

    // Récupérer la liste de cartProducts depuis SharedPreferences
    String? cartProductsData = prefs.getString('cartProducts');
    List<Map<String, dynamic>> cartProducts = [];

    if (cartProductsData != null) {
      // Si des données existent déjà, les récupérer et les ajouter à la liste
      List<dynamic> decodedData = json.decode(cartProductsData);
      cartProducts = decodedData.cast<Map<String, dynamic>>();
    }

    // Vérifier si le produit existe déjà dans le panier
    bool productExists =
        cartProducts.any((item) => item['productId'] == product.id);

    if (!productExists) {
      // Ajouter le nouveau cartProduct à la liste
      cartProducts.add(cartProductData);

      // Sauvegarder la liste mise à jour dans SharedPreferences
      prefs.setString('cartProducts', json.encode(cartProducts));
    }
  }

  Future<List<CartProduct>> getCartProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Récupérer la liste de cartProducts depuis SharedPreferences
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

// Supprime un produit de la liste SharedPreferences
  Future<void> removeProductFromSharedPreferences(String productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Récupérer la liste actuelle de produits depuis SharedPreferences
    List<CartProduct> cartProducts = await getCartProducts();

    // Supprimer le produit de la liste
    cartProducts.removeWhere((p) => p.productId == productId);

    // Convertir la liste de cartProducts en une liste de Map
    List<Map<String, dynamic>> encodedData = cartProducts.map((p) {
      return {
        'productImage': p.productImage,
        'productId': p.productId,
        'productName': p.productName,
        'productPrice': p.productPrice,
        'quantity': p.quantity,
      };
    }).toList();

    // Enregistrer la nouvelle liste dans SharedPreferences
    await prefs.setString('cartProducts', json.encode(encodedData));
  }
}
