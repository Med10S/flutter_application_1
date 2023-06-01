import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/welcome.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/utilities/string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../colors/colors.dart';
import '../../widgets/botton.dart';
import '../authentification/controllers/profil_controller.dart';
import '../authentification/models/user_model.dart';
import '../repository/authentification_repository/authentification_repository.dart';
import 'chart2.dart';
import 'code_scanner.dart';
import 'main_page.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  UserModel? _userModel;
  final _db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    userInformation();
  }

  Future<void> userInformation() async {
    final userModel = await ProfileController().getUserData();
    setState(() {
      _userModel = userModel;
    });
  }

  Future<String> getdata_from_here() async {
    Future<dynamic> clientinfo = ProfileController().getUserData();
    UserModel user2 = await clientinfo;
    String mail = user2.email;
    String userId = await getUserId(mail);
    return userId;
  }

  Future<String> getUserId(String mail) async {
    final snapshot =
        await _db.collection("Users").where("Email", isEqualTo: mail).get();
    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs[0].id;
    } else {
      return "erreur1";
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomAppBar(
          notchMargin: 5,
          shape: const CircularNotchedRectangle(),
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
                                builder: (_) => const User_Main_Page(),
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
                          Future<String> usedId = getdata_from_here();
                          usedId.then((value) async {
                            String userIdFinal = value;
                            debugPrint('user id : $userIdFinal');
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
                                builder: (_) => const QRScan(
                                  extraction: false,
                                ),
                              ));
                        },
                        child: Image.asset('images/QR.png')),
                    
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
return 
     Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: Dimenssion.height20dp / 2),
          height: Dimenssion.height55dp * 2,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
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
              const SizedBox(height: 20.0),
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
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        Fluttertoast.showToast(
                          msg: "pas encore!!",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      },
                      child: CircleAvatar(
                        child: const Icon(Icons.edit),
                        backgroundColor: Theme.of(context).focusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
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
                padding:
                    EdgeInsets.symmetric(horizontal: Dimenssion.width30dp / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(FontAwesomeIcons.envelopeOpenText,
                        color: Colors.black),
                    Text(
                      "Nous contacter",
                      style: TextStyle(
                          color: Colors.black, fontSize: Dimenssion.width16dp),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.black),
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
      return Stack(
        children:[
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
AlertDialog(
  icon: Icon(FontAwesomeIcons.shield),
  scrollable:true,
  backgroundColor:Colors.transparent,
          title: Text('politique De Confidentialite',textAlign: TextAlign.center,style:TextStyle(color:Colors.white)),
          content:  Text(Strings.politiqueDeConfidentialite,textAlign: TextAlign.center,style:TextStyle(color:Colors.white)),
          actions: [
            TextButton(
              style:ButtonStyle(backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).primaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        foregroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return Colors.grey;
                            }
                            return Theme.of(context).colorScheme.onSurface;
                          },
                        ),),
              child: Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        ] 
      );});
                
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Mcolors.Cbackground,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Container(
                padding:
                    EdgeInsets.symmetric(horizontal: Dimenssion.width30dp / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(FontAwesomeIcons.shield, color: Colors.black),
                    Text(
                      "Politique de confidentialité",
                      style: TextStyle(
                          color: Colors.black, fontSize: Dimenssion.width16dp),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.black),
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
                padding:
                    EdgeInsets.symmetric(horizontal: Dimenssion.width30dp / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.logout_rounded, color: Colors.red),
                    Text(
                      "Se déconecter",
                      style: TextStyle(
                          color: Colors.red, fontSize: Dimenssion.width16dp),
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );}

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
