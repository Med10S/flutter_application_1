import 'dart:math';

import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

import '../../widgets/models_ui/1_item_nav_bar.dart';
import '../authentification/controllers/profil_controller.dart';
import '../authentification/models/dechet_model.dart';
import '../repository/authentification_repository/authentification_repository.dart';
import '../welcome.dart';
import 'chart3.dart';
import 'code_scanner.dart';
import 'compte.dart';
import 'main_page.dart';

class ChartDays extends StatefulWidget {
  final String? userIdFinal;
  const ChartDays({Key? key, this.userIdFinal}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChartDaysState();

  //_chartDaysState createState() => _chartDaysState();
}

class ChartDaysState extends State<ChartDays> {
  late List<quatitedechet> chartData;
  late Future<List<quatitedechet>> _chartDataFuture;

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

              widget: Column(
                children: [
                  Stack(children: const [
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 40,
                      color: Color.fromRGBO(230, 192, 58, 1),
                    ),
                    Icon(Icons.calendar_today, color: Colors.black, size: 40)
                  ])
                ],
              ),
              page:ChartCalendare(userIdFinal: widget.userIdFinal!),              
              left: 0,
              right: 20,
              top: 10,
              bottom: 10,
            ),
            OneItemNavBar(
                                        push: true,

              imagepath: "images/info_client.png",
              page: const AccountScreen(),
              left: 5,
              bottom: 0,
              top: 0,
              right: 0,
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
                                    userIdFinal: widget.userIdFinal!),
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
        ProfileController().getUserStat(day, widget.userIdFinal!);

    DechetModel data = await userStat;
    return data;
  }

  Future<List<quatitedechet>> getchardata(String day) async {
    DechetModel stas = await getusesstat(day);

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
