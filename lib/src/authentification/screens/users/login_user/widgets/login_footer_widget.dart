import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../signup_user/signup_screen.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => const SignUpScreen(),
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
    );
  }
}