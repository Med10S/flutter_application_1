import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/src/repository/authentification_repository/expections/signup_email_password_failure.dart';
import 'package:get/get.dart';

import '../../user_interface/main_page.dart';
import '../../welcome.dart';

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

  void createUserWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value !=null ?Get.offAll(() =>  User_Main_Page()) : Get.offAll(() => const Welcome());   
    }on FirebaseAuthException catch (e) {
      final ex =SignUpWithEmailAndPasswordFailure.code(e.code);
      print('FIREBASE AUTH EXEPTION - ${ex.message}');
      throw ex;
    }catch (_){
      const ex = SignUpWithEmailAndPasswordFailure();
      print('EXEPTION - ${ex.message}');
      throw ex;
    }
  }
  void loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    }on FirebaseAuthException catch (e) {
      
    }catch (_){}
  }
  Future<void> logout() async => await _auth.signOut();
}
