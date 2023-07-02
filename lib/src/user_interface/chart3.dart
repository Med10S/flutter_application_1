import 'dart:math';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

import '../../widgets/custom_dialogue_stat.dart';
import '../authentification/controllers/profil_controller.dart';
import '../authentification/models/dechet_model.dart';
import '../repository/authentification_repository/authentification_repository.dart';
import '../welcome.dart';
import 'chart2.dart';
import 'code_scanner.dart';
import 'compte.dart';
import 'main_page.dart';

class ChartCalendare extends StatefulWidget {
  final String userIdFinal;

  const ChartCalendare({super.key, required this.userIdFinal});

  @override
  State<ChartCalendare> createState() => _ChartCalendareState();
}

class _ChartCalendareState extends State<ChartCalendare> {
  DateTime? selectedDate;
  Random random = Random();
  String day2 = "";
  String day = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => const QRScan(extraction: false),
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
                                builder: (_) => const UserMainPage(),
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
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) =>
                                    ChartDays(userIdFinal: widget.userIdFinal),
                              ));
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
              Padding(
                padding: const EdgeInsets.only(right: 5),
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
                        child: const Icon(Icons.logout, color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: Dimenssion.height20dp / 2,
            ),
            Image.asset('images/logo.png'),
            Container(
              margin: const EdgeInsets.all(10),
              height: Dimenssion.FirstPagesImageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).cardColor,
              ),
              child: CalendarCarousel(
                height: Dimenssion.FirstPagesImageHeight,
                todayButtonColor: Colors.green,
                dayButtonColor: Theme.of(context).focusColor,
                onDayPressed: (DateTime date, List<dynamic> events) {
                  String day3 = DateFormat('yyyy-MM-dd').format(date);
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CustomDialogStat(
                        isDark: isDark,
                        date: day3,
                        userIdFinal: widget.userIdFinal,
                        image: Image.asset('images/chart.png'),
                      );
                    },
                  );
                },
                weekendTextStyle: const TextStyle(color: Colors.black),
                thisMonthDayBorderColor: Colors.grey,
                customDayBuilder: (
                  bool isSelectable,
                  int index,
                  bool isSelectedDay,
                  bool isToday,
                  bool isPrevMonthDay,
                  TextStyle textStyle,
                  bool isNextMonthDay,
                  bool isThisMonthDay,
                  DateTime day,
                ) {
                  String date = DateFormat('yyyy-MM-dd').format(day);
                  return FutureBuilder<List<QuatiteDechet>>(
                    future: getchardata(date),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final chartData = snapshot.data!;
                        bool allNonZero = chartData
                            .every((element) => element.quantite == 0.0);

                        if (allNonZero) {
                          return Center(child: Text('${day.day}'));
                        } else {
                          // Traitez le cas où au moins un élément est égal à zéro
                          return Center(
                              child: Text(
                            '${day.day}',
                            style: const TextStyle(color: Colors.red),
                          ));
                        }
                      }
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                    "Click sur n'importe quelle journée\npour visualiser tes statistiques !!"),
                Image.asset(
                  'images/click.png',
                  scale: 10,
                  color: Colors.red,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<List<QuatiteDechet>> getchardata(String day) async {
    DechetModel stas = await getusesstat(day);

    final chartData = [
      QuatiteDechet("platique", stas.plastique),
      QuatiteDechet("verre", stas.verre),
      QuatiteDechet("metalle", stas.metale),
      QuatiteDechet("organique", stas.organique),
      QuatiteDechet("carton", stas.carton),
    ];

    return chartData;
  }

  Future<DechetModel> getusesstat(String day) async {
    Future<dynamic> userStat =
        ProfileController().getUserStat(day, widget.userIdFinal);
    DechetModel data = await userStat;
    return data;
  }
}
