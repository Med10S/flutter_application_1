import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/colors/colors.dart';
import 'package:flutter_application_1/src/Bluetooth_page.dart';
import 'package:flutter_application_1/src/authentification/controllers/profil_controller.dart';
import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:flutter_application_1/src/repository/user_repository/user_repository.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/src/user_interface/chart.dart';
import 'package:flutter_application_1/src/user_interface/chart2.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/authentification_repository/authentification_repository.dart';
import '../welcome.dart';
import 'code_scanner.dart';
import 'compte.dart';
import 'package:intl/intl.dart';

class User_Main_Page extends StatefulWidget {
  const User_Main_Page({super.key});

  @override
  State<User_Main_Page> createState() => _User_Main_PageState();
}

class _User_Main_PageState extends State<User_Main_Page> {
  final _db = FirebaseFirestore.instance;
  final userRepo = Get.put(UserRepository());

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int val = 0;
  @override
  void initState() {
    super.initState();
    _initializeStats();
    _fetchData();
    Timer.periodic(const Duration(seconds: 24), (timer) {
      initaliserPoint();
    });
  }

  Future<void> _fetchData() async {
    val = await getMyIntValue();
  }

  void _initializeStats() async {
    Future<String> usedId = getdata_from_here();
    usedId.then((value) async {
      String userIdFinal = value;
      debugPrint('user id : $userIdFinal');
// valeur résolue de l'ID utilisateur
      await initializeStatsCollection(userIdFinal);
    });
  }

  Future<void> initializeStatsCollection(String userId) async {
    DateTime maintenant = DateTime.now();
    final userRef = _db.collection('Users').doc(userId);
    final statsRef =
        userRef.collection('Stats').doc(maintenant.year.toString());
    final day = DateFormat('yyyy-MM-dd').format(maintenant);

    // get the current data in the stats document
    final data = await statsRef.get().then((snapshot) => snapshot.data());

    // define the keys for each data index
    final keys = ['plastique', 'verre', 'carton', 'metale', 'organique'];

    // if the stats document doesn't exist, create it with all keys initialized to 0
    if (data == null) {
      final initialData = {for (var key in keys) key: 0};
      await statsRef.set({day: initialData});
    } else if (!data.containsKey(day)) {
      // if the day doesn't exist, initialize all keys to 0
      final initialData = {for (var key in keys) key: 0};
      await statsRef.update({day: initialData});
    }
  }

//--------------------------------------------------------------------------------------
/*cette fonction doit ce deplacer vers la class de bluetooth */
  void _updatedata() async {
    Future<String> usedId = getdata_from_here();
    usedId.then((value) async {
      String userIdFinal = value;
      debugPrint('user id : $userIdFinal');
// valeur résolue de l'ID utilisateur
      await userRepo.createStatsCollection(userIdFinal, 50, 4);
    });
  }
//--------------------------------------------------------------------------------------

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

  List<String> time = [
    "09/03/2023",
    "10/03/2023",
    "15/03/2023",
    "15/03/2023",
    "15/03/2023"
  ];

  List<double> quantite = [3, 10, 6, 10, 20];
  int? points;

  Future<int> getMyIntValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int myIntValue = prefs.getInt('points_loacal') ??
        0; // 0 est une valeur par défaut si la clé n'existe pas
    return myIntValue;
  }

  initaliserPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('points_loacal', 0);
  }

//openssl
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return SafeArea(
        child: Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/logo.png'),
          Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).cardColor,
            ),
            height: Dimenssion.FirstPagesImageHeight / 2,
            width: Dimenssion.screenWidth,
            child: FutureBuilder(
              future: controller.getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    UserModel userData = snapshot.data as UserModel;
                    int sum = val + userData.points;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          sum.toString(),
                          style: TextStyle(
                              fontSize: Dimenssion.width20dp * 4,
                              color: const Color.fromRGBO(230, 198, 84, 1)),
                        ),
                        Text(
                          "Points",
                          style: TextStyle(
                              fontSize: Dimenssion.width20dp * 2,
                              color: const Color.fromRGBO(230, 198, 84, 1)),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else {
                    return const Center(
                      child: Text("Somthing went wrong"),
                    );
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 5),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: SizedBox(
              height: Dimenssion.height250dp / 1.08,
              child: ListTileTheme(
                tileColor: Theme.of(context).cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  itemCount: time.length,
                  // Appliquer un BorderRadius de 20 à tous les éléments de la liste
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(top: Dimenssion.width16dp),
                      child: Material(
                        color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.circular(20),
                        child: ListTileTheme(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: itemBuilder(context, index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => const QRScan(
                  extraction: false,
                ),
              ));
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: Image.asset('images/QR.png'),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        shape: const CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),
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
              padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
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
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      _updatedata();
                    },
                    child:
                        Image.asset("images/next.png", height: 40, width: 40),
                  ),
                  const Text(
                    "Statistique",
                    style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder(
                    future: controller.getUserData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          UserModel userData = snapshot.data as UserModel;
                          if (userData.role == "admin") {
                            return InkWell(
                              onTap: () {
                                Get.snackbar(
                                    "utlisateur info", "acces authoriser");
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (_) => const QRScan(
                                              extraction: true,
                                            )));
                              },
                              child: Column(
                                children: [
                                  Stack(children: const [
                                    Icon(
                                      Icons.admin_panel_settings,
                                      color: Color.fromRGBO(255, 182, 76, 1),
                                      size: 45,
                                    ),
                                    Icon(
                                      Icons.admin_panel_settings_outlined,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      size: 45,
                                    )
                                  ]),
                                  const Text(
                                    "Administrateur",
                                    style: TextStyle(
                                        color: Color.fromRGBO(230, 198, 84, 1)),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                Get.snackbar("next page", "utlisateur info");
                              },
                              child: Column(
                                children: [
                                  Image.asset("images/info_client.png"),
                                  const Text(
                                    "Compte",
                                    style: TextStyle(
                                        color: Color.fromRGBO(230, 198, 84, 1)),
                                  ),
                                ],
                              ),
                            );
                            ;
                          }
                        } else {
                          // Add any other widget or error handling logic here
                          return Container();
                        }
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
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
    ));
  }

  itemBuilder(BuildContext context, int index) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time[index],
            style: TextStyle(
              fontSize: Dimenssion.width24dp / 1.2,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : const Color.fromRGBO(14, 77, 89, 1),
            ),
          ),
          Text(
            quantite[index].toString() + " Point(s)",
            style: TextStyle(
              fontSize: Dimenssion.width24dp / 1.3,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : const Color.fromRGBO(14, 77, 89, 1),
            ),
          ),
        ],
      ),
      trailing: Image.asset('images/recycleviewicon.png'),
      onTap: () {
        // Action à exécuter lorsqu'on appuie sur l'élément de la liste
      },
    );
  }
}
