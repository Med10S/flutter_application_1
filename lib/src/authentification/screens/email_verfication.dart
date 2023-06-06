import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/src/repository/authentification_repository/authentification_repository.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:get/get.dart';

import '../../welcome.dart';
import '../controllers/mail_Verfication_Controller.dart';

class MailVerification extends StatelessWidget {
  const MailVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MailVerificationController());
    final controller2 = Get.put(AuthentificationRepository());
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
              TextButton(
              style:ButtonStyle(backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey;
                            }
                            return Theme.of(context).colorScheme.onSurface;
                          },
                        ),),
              child: Text('Renvoyer le lien email'),
              onPressed: () {
                controller.sendVerficationEmail();
              },
            ),
            TextButton(
              style:ButtonStyle(backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey;
                            }
                            return Theme.of(context).colorScheme.onSurface;
                          },
                        ),),
              child: Text('Modifier l\'adress mail'),
              onPressed: () {
                controller2.logout();
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => PrivacyPolicyPage(), //LoginScreen(),
                    ));
              },
            ),
            ],
          ),
        ),
      ),
    ));
  }
}
