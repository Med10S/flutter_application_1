import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/src/authentification/controllers/sign_up_controller.dart';
import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../login_user/Login_screen.dart';
import '../../../../../user_interface/main_page.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
    bool _obscureText = true;
    String selectedText="cp1";
     late TextEditingController _textEditingController;
  late ValueNotifier<String> _selectedTextNotifier;


  List<String> texts = [
    "cp1",
    "cp2",
    "INFO1",
    "INFO2",
    "INDUS1",
    "INDUS2",
    "GMSA1",
    "GMSA2",  
    "GESI1",
    "GESI2",
    "GTR1",
    "GTR2",
    "SEII1",
    "SEII2"
  ];
@override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _selectedTextNotifier = ValueNotifier<String>(texts[0]);

    _textEditingController.text = texts[0]; // Initialiser le contrôleur avec la première valeur

    _selectedTextNotifier.addListener(() {
      _textEditingController.text = _selectedTextNotifier.value;
    });
  }
  @override
  void dispose() {
    _textEditingController.dispose();
    _selectedTextNotifier.dispose();
    super.dispose();
  }
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
               validator:(value) {
                if(value==''){
                  return 'le champ est vide';
                }
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
              controller: controller.password,
              obscureText:_obscureText,
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
              decoration:  InputDecoration(
                prefixIcon: Icon(Icons.fingerprint,color: Mcolors.couleurPrincipal),
                labelText: "Password",
                hintText: "Password",
                border:const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        ),
              ),
            ),
            const SizedBox(height: 30 - 20),

            DropdownButtonFormField<String>(
              
          value: _selectedTextNotifier.value,
          decoration:  const InputDecoration(
                prefixIcon: Icon(Icons.school,color: Mcolors.couleurPrincipal),
                
                border: OutlineInputBorder(),
               
              ),
          hint: const Text('Sélectionnez un texte'),
          onChanged: (String? newValue) {
            setState(() {
              _selectedTextNotifier.value = newValue!;
              
            });
          },
          items: texts.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList()),
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
                        niveau: _textEditingController.text.trim(),
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
