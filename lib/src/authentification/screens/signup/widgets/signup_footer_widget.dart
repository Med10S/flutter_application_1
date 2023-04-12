import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../login/Login_screen.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("OR"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Image(
              image: AssetImage("images/google.png"),
              width: 20.0,
            ),
            label: Text("SignIn With Google".toUpperCase()),
          ),
        ),
        TextButton(
          onPressed: () {Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => LoginScreen(),
                              ));},
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: "Already Have An Account ",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            TextSpan(text: "Login".toUpperCase())
          ])),
        )
      ],
    );
  }
}