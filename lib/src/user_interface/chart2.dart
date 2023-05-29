import 'dart:math';

import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../authentification/controllers/profil_controller.dart';
import '../authentification/models/dechet_model.dart';
import '../repository/authentification_repository/authentification_repository.dart';
import 'chart3.dart';
import 'code_scanner.dart';
import 'main_page.dart';

class ChartDays extends StatefulWidget {
  final String userIdFinal;
  const ChartDays({Key? key, required this.userIdFinal}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChartDaysState();

  //_chartDaysState createState() => _chartDaysState();
}

class ChartDaysState extends State<ChartDays> {
  late List<quatitedechet> _chartData;
  late List<quatitedechet> chartData;
  late Future<List<quatitedechet>> _chartDataFuture;
  final _db = FirebaseFirestore.instance;

  @override
  void initState() {
    _initData();
    super.initState();
  }

  Future<void> _initData() async {
    setState(() {
      selectedDate = DateTime.now();
      day = DateFormat('yyyy-MM-dd').format(selectedDate!);
      _chartDataFuture = getchardata(day);
    });
  }

  DateTime? selectedDate;
  Random random = Random();
  String day = DateFormat('yyyy-MM-dd').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) => QRScan(extraction: false),
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
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (_) => ChartCalendare(
                                  userIdFinal: widget.userIdFinal),
                            ));
                      },
                      child: Stack(children: const [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 40,
                          color: Color.fromRGBO(230, 192, 58, 1),
                        ),
                        Icon(Icons.calendar_today,
                            color: Colors.black, size: 40)
                      ])),
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
                  Image.asset("images/info_client.png"),
                  const Text(
                    "Compte",
                    style: TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                  )
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
      appBar: CalendarAppBar(
        backButton: true,
        locale: 'fr',
        fullCalendar: true,
        onDateChanged: (value) => setState(() {
          selectedDate = value;
          day = DateFormat('yyyy-MM-dd').format(selectedDate!);
          _chartDataFuture = getchardata(day);
        }),
        lastDate: DateTime.now(),
        accent: const Color.fromRGBO(47, 103, 23, 1),
      ),

      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
                padding: EdgeInsets.only(
                    left: Dimenssion.width24dp, right: Dimenssion.width24dp),
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      day == DateFormat('yyyy-MM-dd').format(DateTime.now())
                          ? "Auj"
                          : day,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => ChartCalendare(
                                  userIdFinal: widget.userIdFinal),
                              ));
                        },
                        child: const Icon(Icons.calendar_month_outlined))
                  ],
                )),
            FutureBuilder<List<quatitedechet>>(
              future: _chartDataFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final _chartData = snapshot.data!;

                  return SfCircularChart(
                    margin: EdgeInsets.all(-Dimenssion.height20dp / 4),
                    backgroundColor: Colors.transparent,
                    legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap,
                        position: LegendPosition.bottom),
                    series: <CircularSeries>[
                      RadialBarSeries<quatitedechet, String>(
                        maximumValue: 300,
                        dataSource: _chartData,
                        legendIconType: LegendIconType.seriesType,
                        cornerStyle: CornerStyle.bothCurve,
                        xValueMapper: (quatitedechet data, _) => data.produit,
                        yValueMapper: (quatitedechet data, _) => data.quantite,
                        dataLabelSettings: DataLabelSettings(isVisible: true),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<DechetModel> getusesstat(String day) async {
    Future<dynamic> userStat =
        ProfileController().getUserStat(day, widget.userIdFinal);
    DechetModel data = await userStat;
    debugPrint("metale1${data.metale}");
    return data;
  }

  Future<List<quatitedechet>> getchardata(String day) async {
    DechetModel stas = await getusesstat(day);
    debugPrint("metale${stas.metale}");

    final chartData = [
      quatitedechet("platique", stas.plastique),
      quatitedechet("verre", stas.verre),
      quatitedechet("metalle", stas.metale),
      quatitedechet("organique", stas.organique),
      quatitedechet("carton", stas.carton),
    ];

    return chartData;
  }
}

class quatitedechet {
  quatitedechet(this.produit, this.quantite);
  final String produit;
  final double quantite;
}
