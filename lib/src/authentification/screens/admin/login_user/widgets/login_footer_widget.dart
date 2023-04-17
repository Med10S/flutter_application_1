import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../signup_admin/signup_admin_screen.dart';


class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("OR"),
        const SizedBox(height: 30 - 20),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            icon: const Image(image: AssetImage("images/google.png"), width: 20.0),
            onPressed: () {},
            label: const Text("Sign In With Google"),
          ),
        ),
        const SizedBox(height: 30 - 20),
        TextButton(
          onPressed: () {Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => SignUpScreen_admin(),
                              ));},
          child: Text.rich(
            TextSpan(
                text: "Don't Have An Account ",
                style: Theme.of(context).textTheme.bodySmall,
                children: const [
                  TextSpan(text: "Sign up", style: TextStyle(color: Colors.blue))
                ]),
          ),
        ),
      ],
    );
  }
}