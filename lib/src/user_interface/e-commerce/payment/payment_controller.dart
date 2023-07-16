import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utilities/models/cartProduct.dart';
import '../../../../utilities/models/transaction.dart';
import '../../../admin_interface/e-admin/ProductController.dart';

class PaymentController extends GetxController {
  final _db = FirebaseFirestore.instance;

  //final totalPrice = RxDouble(0.0);
  //static PaymentController get instance => Get.find();
  RxDouble totalPrice = 0.0.obs;

  void updateTotalPrice(List<CartProduct>? products) {
    print(totalPrice.value);
    double total = 0;
    if (products != null) {
      for (CartProduct product in products) {
        total += product.productPrice * product.quantity;
      }
    }
    totalPrice.value = total;
  }

  bool checkSolde(double solde, List<CartProduct>? products) {
    double total = 0;
    for (CartProduct product in products!) {
      total += product.productPrice * product.quantity;
    }
    debugPrint('le prix total est $total');
    if (total - solde <= 0) {
      return true;
    }
    return false;
  }

  Future<bool> enregisterCommande(
      UserModel userModel, List<CartProduct>? products) async {
    DateTime maintenant = DateTime.now();
    int milliseconds = maintenant.millisecondsSinceEpoch;
    final day = DateFormat('yyyy-MM-dd').format(maintenant);
    bool verification = true;

    final docRef = _db
        .collection("Users")
        .doc(userModel.id)
        .collection('commandes')
        .doc(day);

    try {
      final docSnapshot = await docRef.get();
      debugPrint('doc existe ? ${docSnapshot.exists}');

      final Map<String, dynamic> data = {};

      for (CartProduct product in products!) {
        data['$milliseconds;${product.productId}'] = product.toJson();
      }

      if (docSnapshot.exists) {
        // The day exists, perform an update
        await docRef.update(data);
      } else {
        // The day does not exist, perform a new registration
        await docRef.set(data);
      }
    } catch (error) {
      debugPrint('Error: $error');
      verification = false;
    }

    return verification;
  }

  Future<List<CartProduct>> getCommandsByStatus(
      String userId, String status) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .doc(userId)
        .collection('commandes')
        .get();

    final List<CartProduct> commands = [];

    for (final DocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
      final Map<String, dynamic> data = doc.data()!;

      data.forEach((key, value) {
        final String productId = key.split(';')[1];
        final Map<String, dynamic> productData = value as Map<String, dynamic>;
        final CartProduct product = CartProduct(
          productImage: productData['productImage'],
          productId: productId,
          productName: productData['productName'],
          productPrice: productData['productPrice'].toDouble(),
          quantity: productData['quantity'],
          stock: productData['stock'],
          status: productData['status'],
        );

        if (product.status == status) {
          commands.add(product);
        }
      });
    }

    return commands;
  }

  Future<bool> deductionSolde(
      List<CartProduct>? products, UserModel userModel) async {
    final productController = Get.put(ProductController());
    bool resulta = false;
    double total = 0;
    for (CartProduct product in products!) {
      total += product.productPrice * product.quantity;
    }
    final docRef =
        FirebaseFirestore.instance.collection('Users').doc(userModel.id);
    await docRef.get().then((doc) async {
      if (doc.exists) {
        // Get the current value of the 'points' field
        final currentPoints = doc.data()!['points']
            as double; // Cast the value to an int if necessary

        final newData = {
          'points': currentPoints - total
        }; // Replace with the new value for the 'points' field
        await docRef.update(newData).then((value) async {
          await productController.clearCartProducts();
          resulta = true;
          // Update successful
        }).catchError((error) {
          Get.snackbar("mise a jours info", "erreur !! ",
              borderRadius: 20,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: const Color.fromARGB(255, 255, 72, 72),
              colorText: Colors.black);
          resulta = false;
          return;
          // Handle errors here
        });
      } else {
        // Document does not; exist
      }
    }).catchError((error) {
      // Handle errors here
    });
    return resulta;
  }

  Future<bool> saveTransaction(String localisation, UserModel userModel,
      List<CartProduct>? products, bool soldeVerfication) async {
    DateTime maintenant = DateTime.now();
    int milliseconds = maintenant.millisecondsSinceEpoch;

    final day = DateFormat('yyyy-MM-dd').format(maintenant);
    bool verification = false;
    final transaction = TransactionModel(
        totalItems: products!.length,
        localisation: localisation,
        soldeVerfication: soldeVerfication,
        userID: userModel.id!,
        time: day,
        destination: 'Garbeco');
    final docRef = _db.collection("Transactions").doc(day);
    final docSnapshot = await docRef.get();
    if (products.isEmpty) {
      return false;
    }
    if (docSnapshot.exists) {
      // Le jour existe déjà, effectuer une mise à jour

      await docRef.update(
          {milliseconds.toString(): transaction.toJson()}).whenComplete(() {
        Get.snackbar("Success", "votre commande est enregistrer",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);
        verification = true;
      }).catchError((error, StackTrace) {
        Get.snackbar("Error", "Something went wrong. Please try again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
        verification = false;
      });
    } else {
      // Le jour n'existe pas, effectuer un nouvel enregistrement

      await docRef.set(
          {milliseconds.toString(): transaction.toJson()}).whenComplete(() {
        Get.snackbar("Success", "votre commande est enregistrer",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);
        verification = true;
      }).catchError((error, StackTrace) {
        Get.snackbar("Error", "Something went wrong. Please try again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
        verification = false;
      });
    }
    return verification;
  }
}
