// ignore_for_file: avoid_print, body_might_complete_normally_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/authentification/controllers/profil_controller.dart';
import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../authentification/models/dechet_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  createUser(UserModel user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(() => Get.snackbar(
            "Success", "Your account has been created",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withOpacity(0.1),
            colorText: Colors.green))
        .catchError((error, StackTrace) {
      Get.snackbar("Error", "Something went wrong.try again",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
    });
  }

  Future<void> updateUserpassworddata(String password, String userId) async {
    await _db.collection("Users").doc(userId).update({'Password': password});
  }

  Future<void> updateUserEmaildata(String newEmail, String userId) async {
    await _db.collection("Users").doc(userId).update({'Email': newEmail});
  }

  Future<void> updateUserdata(UserModel user, String userId) async {
    //print("user id is :$userId");
    await _db.collection("Users").doc(userId).update(user.toJson());
  }

  Future<void> createStatsCollection(
      String userId, double value, int dataIndex) async {
    DateTime maintenant = DateTime.now();
    final userRef = _db.collection('Users').doc(userId);
    final statsRef =
        userRef.collection('Stats').doc(maintenant.year.toString());
    final day = DateFormat('yyyy-MM-dd').format(maintenant);

    // get the current data in the stats document
    final data = await statsRef.get().then((snapshot) => snapshot.data());

    // define the keys for each data index
    final keys = ['plastique', 'verre', 'carton', 'metale', 'organique'];

    // update the value for the data key based on the index
    final updatedData = {
      keys[dataIndex - 1]: (data != null && data.containsKey(day))
          ? data[day][keys[dataIndex - 1]] + value
          : value,
    };

    // if the stats document doesn't exist, create it with all keys initialized to 0
    if (data == null) {
      final initialData = {for (var key in keys) key: 0};
      await statsRef.set({day: initialData});
    }

    // update the stats document with the new data
    await statsRef.update({
      '$day.${keys[dataIndex - 1]}': updatedData[keys[dataIndex - 1]],
    });
  }

  Future<DechetModel> getStatsForDay(String userId, String day) async {
    final userRef = _db.collection('Users').doc(userId);
    final year = day.split('-')[0]; //day = yyyy-MM-dd

    final statsRef = userRef.collection('Stats').doc(year.toString());

    // vérifier si le document stats existe pour l'année donnée
    final statsDoc = await statsRef.get();
    if (!statsDoc.exists) {
      return const DechetModel(
        carton: 0,
        metale: 0,
        organique: 0,
        plastique: 0,
        verre: 0,
      );
    }

    // récupérer les données pour le jour donné
    final data = statsDoc.data()![day.toString()];
    if (data == null) {
      return const DechetModel(
        carton: 0,
        metale: 0,
        organique: 0,
        plastique: 0,
        verre: 0,
      );
    }

    // construire un objet DechetModel avec les données récupérées
    return DechetModel(
      carton: data['carton'],
      metale: data['metale'],
      organique: data['organique'],
      plastique: data['plastique'],
      verre: data['verre'],
    );
  }

  Future<UserModel> getUserDetails(String email) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }

  authorizeAcces(BuildContext context) {
    if (ProfileController().getUserData().role == "admin") {
      Get.snackbar("user info", "yes admin welcome");
    } else {
      Get.snackbar("user info", "acces non authoriser vous ete ulisateur");
    }
  }

  Future<void> initializeStatsCollection(String userId) async {
    /**pour initialiser les quantite de chaque jours si elle n'existe pas a chaque connection a zero  */
    DateTime maintenant = DateTime.now();
    final userRef = _db.collection('Users').doc(userId);
    final statsRef =
        userRef.collection('Stats').doc(maintenant.year.toString());
    final day = DateFormat('yyyy-MM-dd').format(maintenant);

    // get the current data in the stats document
    final data = await statsRef.get().then((snapshot) => snapshot.data());

    // define the keys for each data index
    final keys = ['plastique', 'verre', 'carton', 'metale', 'organique'];

    // if the stats document doesn't exist, create it with all keys initialized to 0
    if (data == null) {
      final initialData = {for (var key in keys) key: 0.0};
      await statsRef.set({day: initialData});
    } else if (!data.containsKey(day)) {
      // if the day doesn't exist, initialize all keys to 0
      final initialData = {for (var key in keys) key: 0.0};
      await statsRef.update({day: initialData});
    }
  }

  Future<String> getUserId() async {
    Future<dynamic> clientinfo = ProfileController().getUserData();
    UserModel user2 = await clientinfo;
    String id = user2.id!;
    //print("user id is :$id");
    return id;
  }
}
