import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/authentification/controllers/profil_controller.dart';
import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();
  final _db = FirebaseFirestore.instance;
  createUser(UserModel user) async{
   await  _db.collection("Users").add(user.toJson()).whenComplete(() => Get.snackbar(
        "Success", "Your account has been created",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green)
        ).catchError((error,StackTrace){
          Get.snackbar(
        "Error", "Something went wrong.try again",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red);
        print(error.toString());
        })
        ;
  }

  Future <UserModel> getUserDetails(String email) async{
    final snapshot = await _db.collection("Users").where("Email",isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }
  
   authorizeAcces(BuildContext context){
   if( ProfileController().getUserData().role=="admin"){
    Get.snackbar("user info", "yes admin welcome");
   }else{
    Get.snackbar("user info", "acces non authoriser vous ete ulisateur");
   }
  }

 

}
