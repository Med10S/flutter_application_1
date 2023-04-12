import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/utilities/dimention.dart';

import '../../../../user_interface/main_page.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30 - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined,color: Mcolors.couleurPrincipal,),
                  labelText: "Email",
                  hintText: "Email",
                  border:const OutlineInputBorder()),
            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              decoration:  InputDecoration(
                prefixIcon: Icon(Icons.fingerprint,color: Mcolors.couleurPrincipal),
                labelText: "Password",
                hintText: "Password",
                border:const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null,
                  icon: Icon(Icons.remove_red_eye_sharp,),
                ),
              ),
            ),
            const SizedBox(height: 30 - 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {}, child: const Text("Forget Password")),
            ),
            SizedBox(
              width: double.infinity,
              height: Dimenssio.height45dp,
              child: ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).primaryColor), // Définir la couleur de fond du bouton
 ),
                onPressed: () {},
                child: Text("Login".toUpperCase()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}