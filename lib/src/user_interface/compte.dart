import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
        final controller = Get.put(ProfileController());

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
                              builder: (_) => User_Main_Page(),
                            ));
                      },
                      child: Image.asset("images/home.png")),
                  const Text(
                    "home",
                    style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                  )
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
                  const Text(
                    "Statistique",
                    style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                  )
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
                  const Text(
                    "QR Scaner",
                    style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                  )
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
                      },
                      child: Image.asset("images/EXIT.png")),
                  const Text(
                    "Sortir",
                    style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                  )
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
  return Column(
    children: [
      Container(
            padding: EdgeInsets.only(top:Dimenssion.height20dp/2),

        height: Dimenssion.height55dp*2,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.only(
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
            SizedBox(height: 20.0),
            Container(
                  padding: EdgeInsets.symmetric( horizontal:Dimenssion.height20dp/1.2 ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello"),
                      Text(_userModel!.fullName,style: TextStyle(fontWeight: FontWeight.bold),),
                    ],
                  ),
                  InkWell(
                    onTap: () {Fluttertoast.showToast(
        msg: "pas encore!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );},
                    child: CircleAvatar(
                      child: Icon(Icons.edit),
                      backgroundColor: Theme.of(context).focusColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
                  SizedBox(height: 20.0),

        Padding(
          padding: const EdgeInsets.all(4.0),
          child: CustomButton(text: "Acceuil",root: "/mainuserpage",),
        ),
      Padding(
          padding: const EdgeInsets.all(4.0),
          child: CustomButton(text: "A propos de nous",root: "/Apropos",),
        ),Padding(
          padding: const EdgeInsets.all(4.0),
          child: CustomButton(text: "Education",root: "/Education",),
        ),
       Padding(
         padding: const EdgeInsets.all(4.0),
         child: SizedBox(
            height: Dimenssion.height55dp,
            child: ElevatedButton(
              onPressed:(){
                AuthentificationRepository.instance.logout();
                },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Mcolors.Cbackground,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: Dimenssion.width30dp / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
  );
}



  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
