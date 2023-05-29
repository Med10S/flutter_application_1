import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../signup_admin/signup_admin_screen.dart';


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
    );
  }
}