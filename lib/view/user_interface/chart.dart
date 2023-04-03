
import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../welcome.dart';
import 'code_scanner.dart';
import 'main_page.dart';

class statistique extends StatefulWidget {
  const statistique({super.key});

  @override
  State<statistique> createState() => _statistiqueState();
}

class _statistiqueState extends State<statistique> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     var list =[1.2,2.2,3.1];
     list.add(10.2);
     List<ChartData> chartData = <ChartData>[
      ChartData('2/04', list[list.length-1], 9, 5, 4, 0),
      ChartData('3/04', 3, 0, 5, 0, 2),
      ChartData('4/04', 5, 4, 0, 1, 1),
      ChartData('5/04', 6, 2, 2, 0, 2),
      ChartData('6/04', 1, 8, 5, 4, 0),
    ];
    //cette boocle est une demonstration comment tu peut ajouter les donnes depuis firebase 
    //tu les engresitre dans une list apres tu extracte les elements de la list

    for(int i=7;i<11;i++){
      chartData.add(ChartData('$i/04', 1, 8, 5, 4, 0),);

    }
    chartData.add(ChartData('11/04', 1, 8, 5, 1, 0),);
    return SafeArea(
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => QRScan(),
                  ));
            },
            backgroundColor: const Color.fromRGBO(39, 87, 19, 1),
            child: Image.asset('images/QR.png'),
          ),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 5,
            shape: const CircularNotchedRectangle(),
            color: const Color.fromRGBO(39, 87, 19, 1),
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
                        style:
                            TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: 20, top: 10, bottom: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => statistique(),
                                ));
                          },
                          child: Image.asset("images/chart.png")),
                      const Text(
                        "Statistique",
                        style:
                            TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
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
                        style:
                            TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
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
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (_) => Welcome(),
                                ));
                          },
                          child: Image.asset("images/EXIT.png")),
                      const Text(
                        "Sortir",
                        style:
                            TextStyle(color: Color.fromRGBO(230, 198, 84, 1)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Center(
              child: Column(
            children: [
              Container(
                  width: Dimenssio.screenWidth,
                  color: const Color.fromRGBO(47, 103, 23, 1),
                  child: Image.asset('images/logo.png')),
              SizedBox(
                height: Dimenssio.height20dp * 3,
              ),
              SizedBox(
                  height: Dimenssio.FirstPagesImageHeight,
                  child: SfCartesianChart(
                    zoomPanBehavior: ZoomPanBehavior(enablePanning: true,enablePinching: true),
                      legend: Legend(
                          overflowMode: LegendItemOverflowMode.wrap,
                          isVisible: true,
                          position: LegendPosition.bottom,
                          alignment: ChartAlignment.center),
                      primaryXAxis: CategoryAxis(),
                      series: <CartesianSeries>[
                        LineSeries<ChartData, String>(
                            legendIconType: LegendIconType.pentagon,
                            legendItemText: 'plastique',
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y),
                        LineSeries<ChartData, String>(
                            legendIconType: LegendIconType.pentagon,
                            legendItemText: 'carton',
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y1),
                        LineSeries<ChartData, String>(
                            legendIconType: LegendIconType.pentagon,
                            legendItemText: 'verre',
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y2),
                        LineSeries<ChartData, String>(
                            legendIconType: LegendIconType.pentagon,
                            legendItemText: 'metale',
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y3),
                        LineSeries<ChartData, String>(
                            dataSource: chartData,
                            legendItemText: 'organique',
                            legendIconType: LegendIconType.pentagon,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y4)
                      ])),
            ],
          ))),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2, this.y3, this.y4);
  final String x;
  final double? y;
  final double? y1;
  final double? y2;
  final double? y3;
  final double? y4;
}
