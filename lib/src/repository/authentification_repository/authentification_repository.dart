import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/repository/authentification_repository/expections/signup_email_password_failure.dart';
import 'package:flutter_application_1/utilities/string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../authentification/screens/admin/admin_main_page.dart';
import '../../user_interface/main_page.dart';
import '../../welcome.dart';
import 'expections/loging_email_password_failure.dart';

class AuthentificationRepository extends GetxController {
  static AuthentificationRepository get instance => Get.find();


  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setinitialScren);
  }

  _setinitialScren(User? user) { 
     user == null
        ? Get.offAll(() => const Welcome())
        : Get.offAll(() => User_Main_Page());
  }

  Future<bool> createUserWithEmailAndPassword(String email, String password) async {
    try {
    await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => User_Main_Page())
          : Get.offAll(() => const Welcome()
          );
          return true;   
    } on FirebaseAuthException catch (e) {
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar(icon:Icon(Icons.warning,color: Colors.red,),'FIREBASE AUTH EXEPTION',ex.message,snackPosition: SnackPosition.BOTTOM,colorText: Colors.red,backgroundColor: Colors.redAccent.withOpacity(0.1));
      print('FIREBASE AUTH EXEPTION - ${ex.message}');
      //throw ex;
      return false;

    } catch (_) {
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXEPTION - ${ex.message}');
      return false;
      //throw ex;
      
    }
  }
  

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = LogInWithEmailAndPasswordFailure.code(e.code);

      Fluttertoast.showToast(
        msg: ex.message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (_) {
      const ex = LogInWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<void> logout() async => await _auth.signOut();

}