import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/src/repository/authentification_repository/authentification_repository.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:get/get.dart';

import '../controllers/mail_Verfication_Controller.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());
    return SafeArea(
      
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              top: Dimenssion.height20dp*4,
              right: Dimenssion.width30dp ,
              left: Dimenssion.width30dp ,
              bottom: Dimenssion.height5dp),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.email_outlined,
                size: 100,
              ),
              SizedBox(
                height: Dimenssion.height5dp * 4,
              ),
              Text(
                "Verifer votre adress mail",textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(
                height: Dimenssion.height5dp * 2,
              ),
              const Text(
                "Un e-mail de vérification a été envoyé à votre adresse e-mail. Veuillez consulter votre boîte de réception ,",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: Dimenssion.height5dp * 4,
              ),const Text(
                "Apres la verfication clic sur le boutton pour Continuer",
                textAlign: TextAlign.center,
              ),SizedBox(
                height: Dimenssion.height5dp * 4,
              ),
              SizedBox(
                width: Dimenssion.width200dp,
                height: Dimenssion.height40dp ,
                child: OutlinedButton(child: const Text("Continuer",),onPressed: (){controller.manuallyCheckEmailVerficationStatus();},),
              ),
              TextButton(onPressed: (){controller.sendVerficationEmail();}, child: Text("Renvoyer le lien mail"))
            ],
          ),
        ),
      ),
    ));
  }
}
