import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/authentification/screens/users/login_user/Login_screen.dart';

import 'package:flutter_application_1/utilities/dimention.dart';

class SignUpFooterWidget extends StatelessWidget {
  const SignUpFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
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
      ),
    );
  }
}