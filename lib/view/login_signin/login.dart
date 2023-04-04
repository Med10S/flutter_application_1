import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';

import '../../utilities/enums.dart';
import '../../widgets/custum_text.dart';
import '../../widgets/main_button.dart';
import '../user_interface/main_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _autoformType = AuthFormType.login;
  @override
  Widget build(BuildContext context) {
    print("current height" + MediaQuery.of(context).size.width.toString());
    return SafeArea(
        child: Scaffold(
      body: Container(
        color: const Color.fromRGBO(47, 103, 23, 1),
        padding: EdgeInsets.only(
            right: Dimenssio.width32dp,
            left: Dimenssio.width32dp,
            top: Dimenssio.height32dp),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  _autoformType == AuthFormType.login
                      ? "Se connecter"
                      : "Créer un compte",
                  style: TextStyle(
                      color: Color.fromRGBO(247, 191, 95, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: Dimenssio.width30dp),
                ),
              ),
              SizedBox(
                height: Dimenssio.height20dp,
              ),
              TextFormField(
                controller: _emailController,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your email !' : null,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(238, 238, 238, 0.64),
                  labelText: "Email address",
                  hintText: "Enter your email!",
                ),
              ),
              SizedBox(
                height: Dimenssio.height20dp * 1.5,
              ),
              TextFormField(
                controller: _passwordController,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter your password !' : null,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromRGBO(238, 238, 238, 0.64),
                  labelText: "Paswsord",
                  hintText: "Enter your password!",
                  labelStyle: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                height: Dimenssio.height32dp / 2,
              ),
              if (_autoformType == AuthFormType.login)
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    child: Text(
                      "Forgot your password ?",
                      style: TextStyle(
                          color: Color.fromRGBO(247, 191, 95, 1),
                          fontSize: Dimenssio.width16dp / 1.2),
                    ),
                    onTap: () {},
                  ),
                ),
              SizedBox(
                height: Dimenssio.height32dp,
              ),
              MainButton(
                text: _autoformType == AuthFormType.login
                    ? "Se connecter"
                    : "Créer un compte",
                onTap: () {Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => User_Main_Page(),
                              ));},
              ),
              SizedBox(
                height: Dimenssio.height20dp,
              ),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  child: Text(
                    _autoformType == AuthFormType.login
                        ? "Vous n'avez pas un compte ? Créer un  "
                        : "vouz avez déja un compte?",
                    style: TextStyle(
                        color: Color.fromRGBO(247, 191, 95, 1),
                        fontSize: Dimenssio.width16dp / 1.2),
                  ),
                  onTap: () {
                    setState(() {
                      if (_autoformType == AuthFormType.login) {
                        _autoformType = AuthFormType.register;
                      } else {
                        _autoformType = AuthFormType.login;
                      }
                    });
                  },
                ),
              ),
              SizedBox(
                height: Dimenssio.height20dp,
              ),
              CustomText(
                text: "-OR-",
                alignment: Alignment.center,
              ),
              SizedBox(
                height: Dimenssio.height20dp / 2,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: Dimenssio.height32dp * 1.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color.fromRGBO(238, 238, 238, 0.80)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("images/google.png"),
                        Text(
                          'continué avec Google',
                          style: TextStyle(fontSize: Dimenssio.width16dp),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Dimenssio.width20dp / 2,
                    height: Dimenssio.height32dp,
                  ),
                  Container(
                    height: Dimenssio.height32dp * 1.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: const Color.fromRGBO(238, 238, 238, 0.80)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("images/facebook.png"),
                        Text(
                          'continué avec facebook',
                          style: TextStyle(fontSize: Dimenssio.width16dp),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
