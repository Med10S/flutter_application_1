import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/repository/authentification_repository/authentification_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import 'profil_controller.dart';

class MailVerificationController extends GetxController {
      final controller = Get.put(ProfileController());

  late Timer _timer;
  @override
  void onInit() {
    super.onInit();
    sendVerficationEmail();
    setTimerForAutoRedirect();
  }

  void manuallyCheckEmailVerficationStatus() {
    FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user!.emailVerified){
        AuthentificationRepository.instance.setinitialScren(user);
      }
  }

  /*Future<void> upadtedataemail(String id ) async {
  final user = FirebaseAuth.instance.currentUser;
      if(user!.emailVerified){
       await  controller.updatedataEmail(user.email!, id);
        //AuthentificationRepository.instance.setinitialScren(user);

      }
  }*/
  void setTimerForAutoRedirect() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if(user!.emailVerified){
        timer.cancel();
        AuthentificationRepository.instance.setinitialScren(user);

      }
    });
  }

  Future<void> sendVerficationEmail() async {
    final user = FirebaseAuth.instance.currentUser;

    if(user!.emailVerified){
try {
      await AuthentificationRepository.instance.sendEmailVerfication();
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
    }
    
  }
}
