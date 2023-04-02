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
    final List<ChartData> chartData = <ChartData>[
      ChartData('Metale', 128, 129, 101),
      ChartData('plastique', 123, 92, 93),
      ChartData('verre', 107, 106, 90),
      ChartData('carton', 87, 95, 71),
      ChartData('organique', 87, 95, 71),
    ];
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
                  SizedBox(height: Dimenssio.height20dp*3,),
              SizedBox(
                  height: Dimenssio.FirstPagesImageHeight,
                  child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <CartesianSeries>[
                        LineSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y),
                        LineSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y1),
                        LineSeries<ChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (ChartData data, _) => data.x,
                            yValueMapper: (ChartData data, _) => data.y2)
                      ])),
            ],
          ))),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1, this.y2);
  final String x;
  final double? y;
  final double? y1;
  final double? y2;
}
