import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/authentification/screens/admin/signup_admin/widgets/widgets/form_header_widget.dart';
import 'package:flutter_application_1/src/authentification/screens/admin/signup_admin/widgets/widgets/signup_footer_widget.dart';
import 'package:flutter_application_1/src/authentification/screens/admin/signup_admin/widgets/widgets/signup_form_widget.dart';

class SignUpScreenAdmin extends StatelessWidget {
  const SignUpScreenAdmin({Key? key}) : super(key: key);

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
