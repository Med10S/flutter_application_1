import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utilities/models/cartProduct.dart';
import '../../../admin_interface/e-admin/ProductController.dart';

class PaymentController extends GetxController {
  final _db = FirebaseFirestore.instance;

  static PaymentController get instance => Get.find();
  RxDouble totalPrice = 0.0.obs;

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

  void updateTotalPrice(List<CartProduct>? products) {
    print(totalPrice.value);
    double total = 0;
    for (CartProduct product in products!) {
      total += product.productPrice * product.quantity;
    }
    totalPrice.value = total;
  }

  Future<bool> enregisterCommande(
      UserModel userModel, List<CartProduct>? products) async {
    DateTime maintenant = DateTime.now();
    int milliseconds = maintenant.millisecondsSinceEpoch;
    bool verification = true;
    final day = DateFormat('yyyy-MM-dd').format(maintenant);

    final docRef = _db
        .collection("Users")
        .doc(userModel.id)
        .collection('commandes')
        .doc(day);

    for (CartProduct product in products!) {
      final docSnapshot = await docRef.get();
      debugPrint('doc existe ? ${docSnapshot.exists}');
      debugPrint(product.productName);

      if (docSnapshot.exists) {
        // Le jour existe déjà, effectuer une mise à jour

        await docRef.update({
          '$milliseconds;${product.productId}': product.toJson()
        }).whenComplete(() {
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

        await docRef.set({
          '$milliseconds;${product.productId}': product.toJson()
        }).whenComplete(() {
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
    }
    return verification;
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
        // Document does not exist
      }
    }).catchError((error) {
      // Handle errors here
    });
    return resulta;
  }
}
