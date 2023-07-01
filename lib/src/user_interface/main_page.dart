// ignore_for_file: unused_field

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/authentification/controllers/profil_controller.dart';
import 'package:flutter_application_1/src/authentification/models/user_model.dart';
import 'package:flutter_application_1/src/repository/user_repository/user_repository.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:flutter_application_1/src/user_interface/chart2.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../colors/colors.dart';
import '../../utilities/status_bar_controller.dart';
import '../../widgets/models_ui/1ItemNavBar.dart';
import 'code_scanner.dart';

import 'compte.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  Brightness platformBrightness = Brightness.light;
  final statusController = Get.put(Statusbarcontroller());

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
    statusController.getPlatformBrightness().then((brightness) {
      setState(() {
        platformBrightness = brightness;
        statusController.setStatusBarColor(platformBrightness,
            Mcolors.couleurPrincipal, const Color.fromRGBO(26, 98, 114, 1));
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

  Future<void> _fetchDataHistoryque() async {
    pointsList = await getValueListFromSharedPreferences();
  }

  Future<void> _fetchData() async {
    val = await getMyIntValue();
  }

  void _initializeStats() async {
    Future<String> usedId = userRepo.getUserId();
    usedId.then((value) async {
      String userIdFinal = value;
      await userRepo.initializeStatsCollection(userIdFinal);
    });
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
      child: FutureBuilder(
        future: controller.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              UserModel userData = snapshot.data as UserModel;
              int sum = val + userData.points!;
              return Scaffold(
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                sum.toString(),
                                style: TextStyle(
                                    fontSize: Dimenssion.width20dp * 4,
                                    color:
                                        const Color.fromRGBO(230, 198, 84, 1)),
                              ),
                              Text(
                                "Points",
                                style: TextStyle(
                                    fontSize: Dimenssion.width20dp * 2,
                                    color:
                                        const Color.fromRGBO(230, 198, 84, 1)),
                              )
                            ],
                          )),
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                        ),

                        ///j'utlise toujourd des FutureBuilder pour constuire le widget apres que les donnes arrivent

                        child: SizedBox(
                          height: Dimenssion.height250dp / 1.08,
                          child: FutureBuilder<List<Map<String, dynamic>>>(
                            future: getValueListFromSharedPreferences(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  List<Map<String, dynamic>> valueList =
                                      snapshot.data!;

                                  return ListView.builder(
                                    itemCount: valueList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        padding: EdgeInsets.only(
                                            top: Dimenssion.width16dp),
                                        child: Material(
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: ListTileTheme(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
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
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.centerDocked,
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
                        OneItemNavBar(
                          push: true,
                          imagepath: "images/home.png",
                          page: const UserMainPage(),
                          left: 5,
                          bottom: 0,
                          top: 0,
                          right: 0,
                        ),
                        OneItemNavBar(
                          push: true,
                          imagepath: "images/chart.png",
                          page: ChartDays(userIdFinal: userData.id!),
                          left: 5,
                          right: 20,
                          top: 10,
                          bottom: 10,
                        ),
                        userData.role == "admin"
                            ? OneItemNavBar(
                                push: true,
                                widget: Column(
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
                                page: const QRScan(
                                  extraction: true,
                                ),
                                left: 20,
                                top: 10,
                                bottom: 10,
                                right: 0,
                              )
                            : OneItemNavBar(
                                push: true,
                                widget: Column(
                                  children: [
                                    Stack(
                                      children: const [
                                        Icon(
                                          Icons.store,
                                          size: 40,
                                          color: Mcolors.couleurSecondaire,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                page: ChartDays(userIdFinal: userData.id!),
                                left: 20,
                                top: 10,
                                bottom: 10,
                                right: 0,
                              ),
                        OneItemNavBar(
                          push: true,
                          imagepath: "images/info_client.png",
                          page: const AccountScreen(),
                          left: 5,
                          right: 20,
                          top: 10,
                          bottom: 10,
                        ),
                      ],
                    ),
                  ));
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
    );
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
