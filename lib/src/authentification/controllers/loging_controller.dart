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
    String? error = await AuthentificationRepository.instance.loginWithEmailAndPassword(email, password);
     if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),));
    }
  }
}