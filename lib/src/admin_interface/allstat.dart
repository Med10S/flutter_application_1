// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../authentification/models/dechet_model.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'AI_generation/chatapi.dart';
import 'admin_repository.dart';

final today = DateUtils.dateOnly(DateTime.now());
List<DateTime> iterateDatesBetween(DateTime startDate, DateTime endDate) {
  DateTime currentDate = startDate;
  List<DateTime> dates = [];

  while (
      currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
    dates.add(currentDate);

    // Move to the next day
    currentDate = currentDate.add(const Duration(days: 1));
  }

  return dates;
}

class AllDataLevel extends StatelessWidget {
  const AllDataLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ChatApi chatApi = ChatApi();
  String _response = '';
  bool isListening = false;
  String? firstDate, lastDate;
  DechetModel? stats;
  final _responseController = StreamController<String>();
  Stream<String> get responseStream => _responseController.stream;

  List<DateTime?> _rangeDatePickerWithActionButtonsWithValue = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 5)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Admin Statistiques"),
      ),
      body: Center(
        child: SizedBox(
          width: 375,
          child: ListView(
            children: <Widget>[
              _buildCalendarWithActionButtons(),
              ElevatedButton(
                onPressed: () {
                  if (stats == null || (firstDate == "" && lastDate == "")) {
                    Fluttertoast.showToast(
                      msg:
                          "veuillez attentdre que vous visualiser le graphe en premier",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0,
                    );
                  } else {
                    String message = """
"En tant que membre de l'établissement universitaire, 
voici les données de poids de mes poubelles de tri entre le $firstDate et le $lastDate  : 
papier (${stats!.carton} kg), plastique (${stats!.plastique} kg), 
métal (${stats!.metale} kg), matière organique (${stats!.organique} kg) et verre (${stats!.verre} g). 
Pouvez-vous me donner deux conseils soit inovative soit pour sensibiliser la communauté à la réduction des 
déchets en respectant une réponse de moins de 300 mots ?"
                                """;
                    print("carton $message bool $isListening ");
                    _sendMessage(message);
                  }
                },
                child: const Text('donne moi des conseils'),
              ),
              Text("SUggestions".toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).cardColor,
                ),
                width: Dimenssion.screenWidth,
                child: Text(_response),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DateTime> _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    List<DateTime> dates = [];
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();

    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';

        firstDate = startDate;
        lastDate = endDate;
        try {
          dates = iterateDatesBetween(values[0]!, values[1]!);
        } catch (e) {
          Fluttertoast.showToast(
            msg: "veuillez chousir un itervalle de dates",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
        valueText = '$startDate / $endDate';
      } else {
        return [];
      }
    }

    return dates;
  }

  Widget _buildCalendarWithActionButtons() {
    final controller = Get.put(UserStatsExtractor());
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.range,
      disableModePicker: true,
    );
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Text(
            'selectionne une tranche de dates ensuite clic sur ok \nvous allez visualiser les statiques de tout le utlisateur cp2',
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).cardColor,
            ),
            height: Dimenssion.FirstPagesImageHeight,
            child: CalendarDatePicker2WithActionButtons(
              config: config,
              value: _rangeDatePickerWithActionButtonsWithValue,
              onValueChanged: (dates) => setState(() {
                _rangeDatePickerWithActionButtonsWithValue = dates;
              }),
            ),
          ),
          const SizedBox(height: 10),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Selection(s):  '),
              const SizedBox(width: 10),
              Flexible(
                child: Column(
                  children: [
                    const Text(""),
                    Center(
                      child: Column(
                        children: [
                          FutureBuilder<DechetModel>(
                            future: controller.extractStatsByLevel(
                                'cp2',
                                _getValueText(
                                  config.calendarType,
                                  _rangeDatePickerWithActionButtonsWithValue,
                                ).map((dateTime) {
                                  return DateFormat('yyyy-MM-dd')
                                      .format(dateTime)
                                      .toString();
                                }).toList()),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                stats = snapshot.data!;
                                isListening = true;

                                List<Statistic> data = [
                                  Statistic('Carton', stats!.carton,
                                      Colors.blue), // Custom color for Carton
                                  Statistic('Metal', stats!.metale,
                                      Colors.red), // Custom color for Metal
                                  Statistic(
                                      'Organique',
                                      stats!.organique,
                                      Colors
                                          .green), // Custom color for Organique
                                  Statistic(
                                      'Plastique',
                                      stats!.plastique,
                                      Colors
                                          .orange), // Custom color for Plastique
                                  Statistic('Verre', stats!.verre,
                                      Colors.purple), // Custom color for Verre
                                ];

                                return SizedBox(
                                    height: Dimenssion.FirstPagesImageHeight,
                                    child: charts.BarChart(
                                      [
                                        charts.Series<Statistic, String>(
                                          id: 'stats',
                                          data: data,
                                          colorFn: (Statistic stat, _) =>
                                              charts.ColorUtil.fromDartColor(
                                                  stat.color),
                                          domainFn: (Statistic stat, _) =>
                                              stat.category,
                                          measureFn: (Statistic stat, _) =>
                                              stat.value,
                                        ),
                                      ],
                                      animate: true,
                                      primaryMeasureAxis:
                                          const charts.NumericAxisSpec(
                                        renderSpec: charts.GridlineRendererSpec(
                                          labelAnchor:
                                              charts.TickLabelAnchor.before,
                                          labelJustification: charts
                                              .TickLabelJustification.outside,
                                          labelStyle: charts.TextStyleSpec(
                                            color: charts.MaterialPalette.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ));
                              } else {
                                return const Text('No data available');
                              }
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  void _sendMessage(String? message) async {
    if (message != null && message.isNotEmpty && isListening) {
      String response = await chatApi.completeChat(message);
      setState(() {
        _response = response;
      });
      _responseController.add(response);
    }
  }
}

class Statistic {
  final String category;
  final double value;
  final Color color;

  Statistic(this.category, this.value, this.color);
}
