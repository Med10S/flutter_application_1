import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/authentification/controllers/profil_controller.dart';
import 'package:flutter_application_1/src/repository/authentification_repository/authentification_repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../../../colors/colors.dart';
import '../../../models/user_model.dart';

class UpdateDataAll extends StatefulWidget {
  final UserModel userModel;
  const UpdateDataAll({Key? key, required this.userModel}) : super(key: key);

  @override
  State<UpdateDataAll> createState() => _UpdateDataAllState();
}

class _UpdateDataAllState extends State<UpdateDataAll> {
  bool _obscureText = true;
  final forKey2 = GlobalKey<FormState>();

  late TextEditingController _textEditingController;
  late ValueNotifier<String> _selectedTextNotifier;

  List<String> texts = [
    "cp1",
    "cp2",
    "INFO1",
    "INFO2",
    "INDUS1",
    "INDUS2",
    "GMSA1",
    "GMSA2",
    "GESI1",
    "GESI2",
    "GTR1",
    "GTR2",
    "SEII1",
    "SEII2"
  ];
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _selectedTextNotifier = ValueNotifier<String>(widget.userModel.niveau!);

    _textEditingController.text = widget
        .userModel.niveau!; // Initialiser le contrôleur avec la première valeur

    _selectedTextNotifier.addListener(() {
      _textEditingController.text = _selectedTextNotifier.value;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _selectedTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    final authController = Get.put(AuthentificationRepository());
    final email = TextEditingController(text: widget.userModel.email);
    final passwordVerf = TextEditingController();
    final fullName = TextEditingController(text: widget.userModel.fullName);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Modifier Profile'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: forKey2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == '') {
                        return 'le champ est vide';
                      }
                      return null;
                    },
                    controller: fullName,
                    decoration: const InputDecoration(
                        label: Text("Full Name"),
                        prefixIcon: Icon(Icons.person_outlined,
                            color: Mcolors.couleurPrincipal),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 30 - 20),
                  TextFormField(
                    validator: (value) {
                      if (value == '') {
                        return 'le champ est vide';
                      }
                      return null;
                    },
                    controller: email,
                    decoration: const InputDecoration(
                        label: Text("Email"),
                        prefixIcon: Icon(Icons.email_outlined,
                            color: Mcolors.couleurPrincipal),
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 30 - 20),
                  DropdownButtonFormField<String>(
                      value: _selectedTextNotifier.value,
                      decoration: const InputDecoration(
                        prefixIcon:
                            Icon(Icons.school, color: Mcolors.couleurPrincipal),
                        border: OutlineInputBorder(),
                      ),
                      hint: const Text('Sélectionnez un texte'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedTextNotifier.value = newValue!;
                        });
                      },
                      items:
                          texts.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()),
                  const SizedBox(height: 30 - 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                'verification',
                                textAlign: TextAlign.center,
                              ),
                              content: TextFormField(
                                controller: passwordVerf,
                                validator: (value) {
                                  // Validation de la valeur du champ de texte
                                  if (value == '') {
                                    return 'Le champ est vide'; // Message d'erreur en cas de champ vide
                                  } else if (value!.length < 6) {
                                    return 'il doit contenir au moin 6 caracter';
                                  }
                                  // Retourne null si la validation est réussie
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.fingerprint,
                                      color: Mcolors.couleurPrincipal),
                                  labelText: "Password",
                                  hintText: "Password",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Terminer'),
                                  onPressed: () async {
                                    if (forKey2.currentState!.validate() &&
                                        passwordVerf.text.trim() ==
                                            widget.userModel.password) {
                                      final user = UserModel(
                                        email: widget.userModel.email,
                                        password: widget.userModel.password,
                                        fullName: fullName.text.trim(),
                                        niveau: _selectedTextNotifier.value
                                            .toString(),
                                        points: widget.userModel.points,
                                        role: widget.userModel.role,
                                      );
                                      await controller.updatedata(
                                          user, widget.userModel.id!);
                                      bool update =
                                          await authController.updateEmail(
                                              email.text.trim(),
                                              widget.userModel.email,
                                              passwordVerf.text.trim());
                                      if (update) {
                                        await controller.updatedataEmail(
                                            email.text.trim(),
                                            widget.userModel.id!);
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: "mot de pass incorrect !!",
                                        toastLength: Toast.LENGTH_LONG,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                    }

                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Theme
                                .of(context)
                            .primaryColor), // Définir la couleur de fond du bouton
                      ),
                      child: Text("modifier".toUpperCase()),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
