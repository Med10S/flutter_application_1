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
import '../authentification/models/user_model.dart';
import 'chart.dart';

class ChartDays extends StatefulWidget {
  final String userIdFinal;
  const ChartDays({Key? key,required this.userIdFinal}) : super(key: key);
 

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
                      day==DateFormat('yyyy-MM-dd').format(DateTime.now())?"Auj":day,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (_) => statistique(),
                              ));
                        },
                        child: const Icon(Icons.calendar_month_outlined))
                  ],
                )),
FutureBuilder<List<quatitedechet>>(
          future: _chartDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
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
                  maximumValue: 10,
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
  Future<dynamic> userStat =  ProfileController().getUserStat(day,widget.userIdFinal);
  DechetModel data = await userStat;
  debugPrint("metale1${data.metale}");

  return data;
}

  Future<List<quatitedechet>> getchardata(String day) async {
  DechetModel stas = await getusesstat(day);
  debugPrint("metale${stas.metale}");

  /*stas.then((value) {
          DechetModel data = value; // valeur résolue de l'ID utilisateur
          debugPrint("metale${data.metale}");
          
        });*/
  
  
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
  final int quantite;
}


