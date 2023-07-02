import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/src/authentification/controllers/loging_controller.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    final _forKey = GlobalKey<FormState>();
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30 - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline_outlined,
                    color: Mcolors.couleurPrincipal,
                  ),
                  labelText: "Email",
                  hintText: "Email",
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              controller: controller.password,
              obscureText: _obscureText,
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
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.fingerprint,
                    color: Mcolors.couleurPrincipal),
                labelText: "Password",
                hintText: "Password",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                ),
              ),
            ),
            const SizedBox(height: 30 - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                      msg: "pas encore!!",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  },
                  child: const Text("Forget Password")),
            ),
            SizedBox(
              width: double.infinity,
              height: Dimenssion.height45dp,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(
                          context)
                      .primaryColor), // Définir la couleur de fond du bouton
                ),
                onPressed: () {
                  LoginController.instance.loginUser(
                      controller.email.text.trim(),
                      controller.password.text.trim());
                },
                child: Text("Login".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
