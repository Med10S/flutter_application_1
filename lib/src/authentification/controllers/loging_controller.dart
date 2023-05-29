import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../repository/authentification_repository/authentification_repository.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  
  Future<void> loginUser(String email,String password) async{
    final auth = AuthentificationRepository.instance;
    String? error = await auth.loginWithEmailAndPassword(email, password);
    auth.setinitialScren(auth.firebaseUser.value);

     if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),));
    }
  }
}