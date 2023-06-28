import 'package:flutter/material.dart';

import 'widgets/form_header_widget.dart';
import 'widgets/signup_footer_widget.dart';
import 'widgets/signup_form_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).canvasColor,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25),
            child: const Column(
              children: [
                FormHeaderWidget(
                  image: "images/Group2.png",
                  title: "Get on Board",
                  subTitle: "Create your profile to start your Journey",
                ),
                SignUpFormWidget(),
                SignUpFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
