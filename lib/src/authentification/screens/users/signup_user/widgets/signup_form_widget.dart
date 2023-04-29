import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/src/authentification/controllers/sign_up_controller.dart';
import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../login_user/Login_screen.dart';
import '../../../../../user_interface/main_page.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _forKey = GlobalKey<FormState>();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30 - 10),
      child: Form(
        key: _forKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30 - 20),
            TextFormField(
              validator:(value) {
                if(value==''){
                  return 'le champ est vide';
                }
              },
              controller: controller.fullName,
              decoration: const InputDecoration(
                  label: Text("Full Name"),
                  prefixIcon: Icon(Icons.person_outlined,
                      color: Mcolors.couleurPrincipal),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                  label: Text("Email"),
                  prefixIcon: Icon(Icons.email_outlined,
                      color: Mcolors.couleurPrincipal),
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              controller: controller.password,
              decoration:const  InputDecoration(
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
                  if (_forKey.currentState!.validate()) {
                   Future<bool> auth_pass= SignUpController.instance.registerUser(
                        controller.email.text.trim(),
                        controller.password.text.trim());
                        if(await auth_pass){
                      final user = UserModel(
                        email: controller.email.text.trim(),
                        password: controller.password.text.trim(),
                        fullName: controller.fullName.text.trim(),
                        role: 'user',
                        points: 0);
                        SignUpController.instance.createUser(user);
                        }else{ _forKey.currentState!.validate()==false;}
                   
                  }

                  /*Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => User_Main_Page(),
                              ));*/
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
