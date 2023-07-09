import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utilities/models/cartProduct.dart';

class PaymentController extends GetxController {
  final _db = FirebaseFirestore.instance;

  static PaymentController get instance => Get.find();
  bool checkSolde(int solde, List<CartProduct>? products) {
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
    bool verification = false;
    final day = DateFormat('yyyy-MM-dd').format(maintenant);
    for (CartProduct product in products!) {
      await _db
          .collection("Users")
          .doc(userModel.id)
          .collection('commandes')
          .doc(day)
          .update({milliseconds.toString(): product.toJson()}).whenComplete(() {
        Get.snackbar("Success", "Your Product has been Added",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green);
        verification = true;
      }).catchError((error, StackTrace) {
        Get.snackbar("Error", "Something went wrong.try again",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            colorText: Colors.red);
        verification = false;
        //print(error.toString());
      });
    }
    return verification;
  }
}
