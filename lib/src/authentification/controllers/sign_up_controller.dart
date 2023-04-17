import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:flutter_application_1/src/repository/authentification_repository/authentification_repository.dart';
import 'package:get/get.dart';

import '../../repository/user_repository/user_repository.dart';
import '../../user_interface/main_page.dart';
import '../screens/admin/admin_main_page.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();

  final userRepo = Get.put(UserRepository());

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  Future<bool> registerUser(String email,String password){
   return AuthentificationRepository.instance.createUserWithEmailAndPassword(email, password);
  }
  
  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    //registerUser(user.email, user.password);
    Get.to(()=> User_Main_Page());
  }
}