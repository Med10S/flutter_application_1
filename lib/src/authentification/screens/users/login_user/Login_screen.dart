import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/authentification/screens/users/login_user/widgets/login_header_widget.dart';

import 'widgets/login_footer_widget.dart';
import 'widgets/login_form_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get the size in LoginHeaderWidget()
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                LoginHeaderWidget(),
                LoginForm(),
                LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}