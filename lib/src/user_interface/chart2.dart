import 'dart:math';

import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart.dart';

class chartDays extends StatefulWidget {
  @override
  _chartDaysState createState() => _chartDaysState();
}

class _chartDaysState extends State<chartDays> {
  late List<quatitedechet> _chartData;
  @override
  void initState() {
    _chartData = getchardata();
    setState(() {
      selectedDate = DateTime.now();
    });
    super.initState();
  }

  DateTime? selectedDate;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:Colors.white,
      appBar: CalendarAppBar(
        backButton: true,
        locale: 'fr',
        fullCalendar: true,
        onDateChanged: (value) => setState(() => selectedDate = value),
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
                    left: Dimenssio.width24dp, right: Dimenssio.width24dp),
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Auj",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                    InkWell(
                        onTap: () {Navigator.push(context, CupertinoPageRoute(
                              builder: (_) => statistique(),
                            ));},
                        child: const Icon(Icons.calendar_month_outlined))
                  ],
                )),
            SfCircularChart(
              margin: EdgeInsets.all(-Dimenssio.height20dp/4),
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
            )
          ],
        ),
      ),
    );
  }

  List<quatitedechet> getchardata() {
    final List<quatitedechet> chartData = [
      quatitedechet("platique", 12),
      quatitedechet("verre", 2),
      quatitedechet("metalle", 6),
      quatitedechet("organique", 4),
      quatitedechet("carton", 5),
    ];
    return chartData;
  }
}

class quatitedechet {
  quatitedechet(this.produit, this.quantite);
  final String produit;
  final int quantite;
}
