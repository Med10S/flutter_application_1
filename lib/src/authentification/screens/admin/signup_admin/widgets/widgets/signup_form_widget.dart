import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/src/authentification/controllers/sign_up_controller.dart';
import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:flutter_application_1/utilities/dimention.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _forKey = GlobalKey<FormState>();
    TextEditingController _textController1 = TextEditingController();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30 - 10),
      child: Form(
        key: _forKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30 - 20),
            TextFormField(
              validator: (value) {
                // Validation de la valeur du champ de texte
                if (value == '') {
                  return 'Le champ est vide'; // Message d'erreur en cas de champ vide
                }
                // Retourne null si la validation est réussie
                return null;
              },
              controller: _textController1,
              decoration: const InputDecoration(
                  label: Text("clé"),
                  prefixIcon: Icon(Icons.key, color: Mcolors.couleurPrincipal),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              validator: (value) {
                // Validation de la valeur du champ de texte
                if (value == '') {
                  return 'Le champ est vide'; // Message d'erreur en cas de champ vide
                }
                // Retourne null si la validation est réussie
                return null;
              },
              controller: controller.fullName,
              decoration: const InputDecoration(
                  label: Text("Full Name"),
                  prefixIcon: Icon(Icons.person_2_outlined,
                      color: Mcolors.couleurPrincipal),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              validator: (value) {
                // Validation de la valeur du champ de texte
                if (value == '') {
                  return 'Le champ est vide'; // Message d'erreur en cas de champ vide
                }
                // Retourne null si la validation est réussie
                return null;
              },
              controller: controller.email,
              decoration: const InputDecoration(
                  label: Text("Email"),
                  prefixIcon: Icon(Icons.email_outlined,
                      color: Mcolors.couleurPrincipal),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              validator: (value) {
                // Validation de la valeur du champ de texte
                if (value == '') {
                  return 'Le champ est vide'; // Message d'erreur en cas de champ vide
                } else if (value!.length < 6) {
                  return 'il doit contenir au moin 6 caracter';
                }
                // Retourne null si la validation est réussie
                return null;
              },
              controller: controller.password,
              decoration: const InputDecoration(
                  label: Text("Password"),
                  prefixIcon:
                      Icon(Icons.fingerprint, color: Mcolors.couleurPrincipal),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30 - 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_forKey.currentState!.validate() &&
                      _textController1.text == 'azerty@1234@') {
                    Future<bool> authPass = SignUpController.instance
                        .registerUser(controller.email.text.trim(),
                            controller.password.text.trim());
//le probleme c'est que meme si register user
//failed create user possible de ce realiser
//j'ai transformer la fonction registerUser en Future<bool>
//pour me retourner si le register c'est fait ou non
//puisque authpass de type future donc je dois faire await
                    if (await authPass) {
                      final admin = UserModel(
                          email: controller.email.text.trim(),
                          password: controller.password.text.trim(),
                          fullName: controller.fullName.text.trim(),
                          points: 0,
                          role: 'admin');
                      SignUpController.instance.createUser(admin);
                    } else {
                      _forKey.currentState!.validate() == false;
                    }
                  } else if (_textController1.text != 'azerty@1234@') {
                    Get.snackbar("Erreur", "cle invalide",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.redAccent.withOpacity(0.1),
                        colorText: Colors.red);
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(
                          context)
                      .primaryColor), // Définir la couleur de fond du bouton
                ),
                child: Text("Signup".toUpperCase()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
