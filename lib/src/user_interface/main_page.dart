import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/src/authentification/controllers/profil_controller.dart';
import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:flutter_application_1/src/repository/user_repository/user_repository.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/src/user_interface/chart2.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../colors/colors.dart';
import 'code_scanner.dart';
import 'package:intl/intl.dart';

import 'compte.dart';

class User_Main_Page extends StatefulWidget {
  const User_Main_Page({super.key});

  @override
  State<User_Main_Page> createState() => _User_Main_PageState();
}

class _User_Main_PageState extends State<User_Main_Page> {
  Brightness platformBrightness = Brightness.light;
  final _db = FirebaseFirestore.instance;
  final userRepo = Get.put(UserRepository());
  List<Map<String, dynamic>> pointsList = [];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int val = 0;
  List<Map<String, dynamic>>? val2 = List.empty();
  @override
  void initState() {
    super.initState();
    getPlatformBrightness().then((brightness) {
      setState(() {
        platformBrightness = brightness;
        setStatusBarColor();
      });
    });
    _initializeStats();
    _fetchData();
    _fetchDataHistoryque();
    getValueListFromSharedPreferences();

    Timer.periodic(const Duration(hours: 12), (timer) {
      initaliserPoint();
    });
  }

  Future<Brightness> getPlatformBrightness() async {
    Brightness brightness;
    try {
      brightness = WidgetsBinding.instance.window.platformBrightness;
    } on PlatformException {
      brightness = Brightness.light;
    }
    return brightness;
  }

  void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: platformBrightness,
        statusBarColor: platformBrightness == Brightness.dark
            ? const Color.fromRGBO(
                26, 98, 114, 1) // Couleur de la barre d'état en mode nuit
            : Mcolors
                .couleurPrincipal, // Couleur de la barre d'état en mode jour
      ),
    );
  }

  Future<void> _fetchDataHistoryque() async {
    pointsList = await getValueListFromSharedPreferences();
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
    /**pour initialiser les quantite de chaque jours si elle n'existe pas a chaque connection a zero  */
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
      final initialData = {for (var key in keys) key: 0.0};
      await statsRef.set({day: initialData});
    } else if (!data.containsKey(day)) {
      // if the day doesn't exist, initialize all keys to 0
      final initialData = {for (var key in keys) key: 0.0};
      await statsRef.update({day: initialData});
    }
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

  Future<int> getMyIntValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int myIntValue = prefs.getInt('points_loacal') ??
        0; // 0 est une valeur par défaut si la clé n'existe pas
    return myIntValue;
  }

  initaliserPoint() async {
    ///pour renitialiser la donne enregister depuis le bluetooth a zero
    ///cette fonction est appller dans intistate chaque 24h
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

            ///j'utlise toujourd des FutureBuilder pour constuire le widget apres que les donnes arrivent

            child: SizedBox(
              height: Dimenssion.height250dp / 1.08,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: getValueListFromSharedPreferences(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<Map<String, dynamic>> valueList = snapshot.data!;

                      return ListView.builder(
                        itemCount: valueList.length,
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
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return const Center(
                        child: Text("Something went wrong"),
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
                              builder: (_) => const User_Main_Page(),
                            ));
                      },
                      child: Image.asset("images/home.png")),
                  
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
                                  
                                ],
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                Get.snackbar("next page", "utlisateur info");
                              },
                              child: Column(
                                children:  [
                                  Stack(children: const [
                                    
                                  Icon(Icons.store,size: 40,color: Mcolors.couleurSecondaire,),
                                  ],),
                                 
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
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (_) => const AccountScreen()));
                      },
                      child: Image.asset("images/info_client.png")),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget itemBuilder(BuildContext context, int index) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            ///pointsList est une list avec les donne de la date
            /// et les points elle se comporte comme un tableau
            ///donc je peux l'acceder avec [index] j'utliser ['date'] car les donnes sont
            ///enregistrer en format JONSON

            "${pointsList[index]['date']}",
            style: TextStyle(
              fontSize: Dimenssion.width24dp / 1.2,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : const Color.fromRGBO(14, 77, 89, 1),
            ),
          ),
          Text(
            "${pointsList[index]['value']} Point(s)",
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

  /// cette fonction a pour but d'extraire les donne enregister depuis la class bluetooth car precedament
  /// j'ai enregister les points avec le timstamp dans une list de type Map<String, dynamic>>

  Future<List<Map<String, dynamic>>> getValueListFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Obtenir la liste de valeurs à partir des préférences partagées
    List<String>? valueListJson = prefs.getStringList('value_list');

    if (valueListJson != null) {
      // Convertir la liste JSON en une liste de Maps
      List<Map<String, dynamic>> valueList = valueListJson
          .map((json) => Map<String, dynamic>.from(jsonDecode(json)))
          .toList();

      return valueList;
    }

    return [];
  }
}
