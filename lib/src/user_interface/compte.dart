// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/welcome.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/utilities/string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../colors/colors.dart';
import '../../utilities/status_bar_controller.dart';
import '../../widgets/botton.dart';
import '../authentification/controllers/profil_controller.dart';
import '../authentification/models/user_model.dart';
import '../authentification/screens/users/upadate_data/updatedatascren.dart';
import '../repository/authentification_repository/authentification_repository.dart';
import 'chart2.dart';
import 'code_scanner.dart';
import 'e-commerce/main/main_page_store.dart';
import 'main_page.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final statusController = Get.put(Statusbarcontroller());
  final controller = Get.put(AuthentificationRepository());
  final profcontoller = Get.put(ProfileController());
  UserModel? _userModel;
  Brightness platformBrightness = Brightness.light;

  String userInput = ''; // Variable to store user input
  @override
  void initState() {
    super.initState();
    userInformation();
    statusController.getPlatformBrightness().then((brightness) {
      setState(() {
        platformBrightness = brightness;
        statusController.setStatusBarColor(
            platformBrightness,
            const Color.fromARGB(255, 236, 236, 236),
            const Color.fromRGBO(14, 77, 89, 1));
      });
    });
  }

  Future<void> userInformation() async {
    final userModel = await ProfileController().getUserData();
    setState(() {
      _userModel = userModel;
    });
  }

  Future<String> GetdataFRomHere() async {
    Future<dynamic> clientinfo = ProfileController().getUserData();
    UserModel user2 = await clientinfo;
    String id = user2.id!;
    //print("user id is :$id");
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          notchMargin: 5,
          shape: const CircularNotchedRectangle(),
          shadowColor: Colors.black,
          color: Theme.of(context).primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => const UserMainPage(),
                              ));
                        },
                        child: Image.asset("images/home.png")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                        onTap: () {
                          Future<String> usedId = GetdataFRomHere();
                          usedId.then((value) async {
                            String userIdFinal = value;
                            //debugPrint('user id : $userIdFinal');
// valeur résolue de l'ID utilisateur
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) =>
                                      ChartDays(userIdFinal: userIdFinal),
                                ));
                          });
                        },
                        child: Image.asset("images/chart.png")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (_) => const EcommerceMainPage()));
                        },
                        child: Icon(
                          Icons.store_rounded,
                          size: 40,
                          color: const Color.fromARGB(255, 255, 180, 50),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                        onTap: () {
                          AuthentificationRepository.instance.logout();
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) =>
                                    PrivacyPolicyPage(), //LoginScreen(),
                              ));
                        },
                        child: Image.asset("images/EXIT.png")),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: _userModel != null ? buildUserInfo() : buildLoading(),
      ),
    );
  }

  Widget buildUserInfo() {
    final _forKey = GlobalKey<FormState>();
    final password = TextEditingController();
    final oldpassword = TextEditingController();

    return SingleChildScrollView(
      child: Form(
        key: _forKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: Dimenssion.height20dp / 2),
              height: Dimenssion.height55dp * 2,
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Profile Detail",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimenssion.width16dp * 1.5,
                    ),
                  ),
                  SizedBox(height: Dimenssion.height20dp),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimenssion.height20dp / 1.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Hello"),
                            Text(
                              _userModel!.fullName,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) =>
                                      UpdateDataAll(userModel: _userModel!),
                                ));
                          },
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).focusColor,
                            child: const Icon(Icons.edit),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            _userModel!.role == 'admin'
                ? const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: CustomButton(
                      text: "Tout les statistique",
                      root: "/AllDataLevel",
                      icon: FontAwesomeIcons.database,
                    ),
                  )
                : const Padding(padding: EdgeInsets.all(4.0), child: null),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: CustomButton(
                text: "Acceuil",
                root: "/mainuserpage",
                icon: FontAwesomeIcons.house,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(4.0),
              child: CustomButton(
                text: "A propos de nous",
                root: "/Apropos",
                icon: FontAwesomeIcons.info,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 4.0, left: 4.0, right: 4),
              child: CustomButton(
                  text: "Education",
                  root: "/Education",
                  icon: FontAwesomeIcons.graduationCap),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: Dimenssion.height55dp,
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('modifier votre clé '),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: oldpassword,
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
                                  labelText: "Old Password ",
                                  hintText: "Old Password",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              SizedBox(
                                height: Dimenssion.height20dp / 2,
                              ),
                              TextFormField(
                                controller: password,
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
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('OK'),
                              onPressed: () {
                                if (!(password.text.trim().length < 6)) {
                                  print(
                                      "old:${oldpassword.text} new${password.text}");
                                  controller.updatepassowrd(
                                      password.text.trim(),
                                      _userModel!.email,
                                      oldpassword.text.trim());
                                  profcontoller.updatedatapassword(
                                      password.text.trim(), _userModel!.id!);
                                  Navigator.of(context).pop();
                                } else {
                                  Fluttertoast.showToast(
                                    msg:
                                        "un mot de pass doit avoir une taille > 6 ",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                  );
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Mcolors.Cbackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimenssion.width30dp / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(FontAwesomeIcons.key, color: Colors.black),
                        Text(
                          "modifier votre mot de pass",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimenssion.width16dp),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.blueAccent,
              endIndent: Dimenssion.width20dp * 5,
              indent: Dimenssion.width20dp * 5,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: Dimenssion.height55dp,
                child: ElevatedButton(
                  onPressed: () async {
                    String email = 'garb.eco13@gmail.com';
                    String url = 'mailto:<$email>';
                    Uri uri = Uri.parse(url);
                    if (await canLaunchUrl(uri)) {
                      await launchUrl(uri);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Erreur'),
                          content: const Text(
                              'Impossible d\'ouvrir l\'application de messagerie gmail.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Mcolors.Cbackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimenssion.width30dp / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(FontAwesomeIcons.envelopeOpenText,
                            color: Colors.black),
                        Text(
                          "Nous contacter",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimenssion.width16dp),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                height: Dimenssion.height55dp,
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Stack(children: [
                            BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            AlertDialog(
                              icon: const Icon(FontAwesomeIcons.shield),
                              scrollable: true,
                              backgroundColor: Colors.transparent,
                              title: const Text('politique De Confidentialite',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white)),
                              content: Text(Strings.politiqueDeConfidentialite,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white)),
                              actions: [
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Theme.of(context).primaryColor),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                    ),
                                    foregroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.disabled)) {
                                          return Colors.grey;
                                        }
                                        return Theme.of(context)
                                            .colorScheme
                                            .onSurface;
                                      },
                                    ),
                                  ),
                                  child: const Text('Fermer'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                          ]);
                        });
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Mcolors.Cbackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimenssion.width30dp / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(FontAwesomeIcons.shield,
                            color: Colors.black),
                        Text(
                          "Politique de confidentialité",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimenssion.width16dp),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: Dimenssion.height55dp,
                child: ElevatedButton(
                  onPressed: () {
                    AuthentificationRepository.instance.logout();
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (_) => PrivacyPolicyPage(), //LoginScreen(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Mcolors.Cbackground,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimenssion.width30dp / 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.logout_rounded, color: Colors.red),
                        Text(
                          "Se déconecter",
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: Dimenssion.width16dp),
                        ),
                        const Icon(Icons.arrow_forward_ios,
                            color: Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
