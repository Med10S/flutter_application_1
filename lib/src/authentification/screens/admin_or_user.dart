import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'admin/login_user/Login_screen.dart';
import 'users/login_user/Login_screen.dart';

class Choicepageadminuser extends StatelessWidget {
  const Choicepageadminuser({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Row(
            children: [
              Image.asset(
                'images/logo.png', // Chemin de l'image
                // Largeur de l'image
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const LoginScreen(),
                      ));
                },
                icon: const Icon(Icons.person),
                label: const Text('ESPACE UTLISATEUR'),
              ),
              const SizedBox(height: 16.0), // Espacement entre les boutons
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => const LoginScreen_admin(),
                      ));
                },
                icon: const Icon(Icons.admin_panel_settings),
                label: const Text('ESAPCE ADMINISTRATEUR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
