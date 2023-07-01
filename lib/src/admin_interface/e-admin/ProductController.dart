import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/models/product.dart';
import 'package:get/get.dart';
import 'dart:io';

class ProductController {
  final _db = FirebaseFirestore.instance;
  createProduct(Product product) async {
    await _db
        .collection("Products")
        .add(product.toJson())
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
    //for (var doc in snapshot.docs) {
    final product = snapshot.docs.map((e) => Product.fromSnapshot(e)).single;
    products.add(product);
    // }

    print("Extraction des produits terminée.");

    return products;
  }
}
