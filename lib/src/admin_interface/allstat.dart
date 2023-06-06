import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/admin_interface/AI_generation/chatgpt.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import '../authentification/controllers/profil_controller.dart';
import '../authentification/models/dechet_model.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:http/http.dart' as http;
import 'package:dart_openai/openai.dart';

class UserStatsExtractor {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
final controller = Get.put(ProfileController());

  Future<DechetModel> extractStatsByLevel(String level,List<String> dates) async {
    Map<String, dynamic> totalStats = {
      'carton': 0.0,
      'metale': 0.0,
      'organique': 0.0,
      'plastique': 0.0,
      'verre': 0.0,
    };

    QuerySnapshot usersSnapshot = await _db.collection('Users').get();

    for (QueryDocumentSnapshot userDoc in usersSnapshot.docs) {
          String userId = userDoc.id;
    String? niveau = (userDoc.data() as Map<String, dynamic>?)?['niveau'] as String?;
      if (niveau == level) {
        for(String date in dates){
Future<dynamic>? userStats = controller.getUserStat(date,userId);
        DechetModel data = await userStats;
        if (userStats != null) {
          totalStats['carton'] += data.carton;
          totalStats['metale'] += data.metale;
          totalStats['organique'] += data.organique;
          totalStats['plastique'] += data.plastique;
          totalStats['verre'] += data.verre;
        }
        }
        
      }
    }
  debugPrint("carton : ${totalStats['carton']} metal :${totalStats['metale']} organique: ${totalStats['organique']} plastique : ${totalStats['plastique']} verre :${totalStats['verre']}");
    return DechetModel(
      carton: totalStats['carton'],
      metale: totalStats['metale'],
      organique: totalStats['organique'],
      plastique: totalStats['plastique'],
      verre: totalStats['verre'],
    );
    
  }
}
final today = DateUtils.dateOnly(DateTime.now());
List<DateTime> iterateDatesBetween(DateTime startDate, DateTime endDate) {
  DateTime currentDate = startDate;
  List<DateTime> dates = [];

  while (currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)) {
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
      child:  Scaffold(
        body:  MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<DateTime?> _rangeDatePickerWithActionButtonsWithValue = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 5)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Admin Statistiques"),
      ),
      body: Center(
        child: SizedBox(
          width: 375,
          child: ListView(
            children: <Widget>[
              _buildCalendarWithActionButtons(),
              TextButton(child: Text("clic"),onPressed: (){
Navigator.push(
              context,
              CupertinoPageRoute(
                builder: (_) =>  Chatgpt()
              ));
              },)
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
    List<DateTime> dates=[];
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
            try{
       dates = iterateDatesBetween(values[0]!,values[1]!);  

            }catch(e){
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
          const Text('selectionne une tranche de dates ensuite clic sur ok \nvous allez visualiser les statiques de tout le utlisateur cp2',textAlign: TextAlign.center,),
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
              onValueChanged: (dates) => setState(
                  ()  {
                    _rangeDatePickerWithActionButtonsWithValue = dates;
                  
                    }
          
                  ),
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
                    const Text(
                     "" 
                    ),
                    Center(
        child: Column(
          children: [
            FutureBuilder<DechetModel>(  
                future: controller.extractStatsByLevel('cp2', _getValueText(config.calendarType,_rangeDatePickerWithActionButtonsWithValue,).map((dateTime) {
      return DateFormat('yyyy-MM-dd').format(dateTime).toString();}).toList()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    DechetModel stats = snapshot.data!;
    List<Statistic> data = [
                   Statistic('Carton', stats.carton, Colors.blue), // Custom color for Carton
          Statistic('Metal', stats.metale, Colors.red), // Custom color for Metal
          Statistic('Organique', stats.organique, Colors.green), // Custom color for Organique
          Statistic('Plastique', stats.plastique, Colors.orange), // Custom color for Plastique
          Statistic('Verre', stats.verre, Colors.purple), // Custom color for Verre
        
                ];
    
                return SizedBox(
                  height: Dimenssion.FirstPagesImageHeight,
                  child: charts.BarChart(
                    [
                      charts.Series<Statistic, String>(
                        id: 'stats',
                        data: data,
                        colorFn: (Statistic stat, _) => charts.ColorUtil.fromDartColor(stat.color),
                        domainFn: (Statistic stat, _) => stat.category,
                        measureFn: (Statistic stat, _) => stat.value,
                      ),
                    ],
                    animate: true,
                    
                    
        primaryMeasureAxis: const charts.NumericAxisSpec(
          renderSpec: charts.GridlineRendererSpec(
            labelAnchor: charts.TickLabelAnchor.before,
            labelJustification: charts.TickLabelJustification.outside,
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
  Future<void> _onSubmitted(String message) async {
  
  final response = await completeChat(message);
  print(response);
  
}
}
void sendMessage(String message) async {
   
  try {
    final reply = await sendChatRequest(message);
    // Faites quelque chose avec la réponse, par exemple, affichez-la dans l'interface utilisateur
    print(reply);
  } catch (e) {
    // Gérez les erreurs
    print('Erreur: $e');
  }
}

Future<String> sendChatRequest(String message) async {
  const apiKey = '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'; // Remplacez par votre clé API
  const endpoint = 'https://api.openai.com/v1/chat/completions';

  final response = await http.post(

    Uri.parse(endpoint),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: '{"messages": [{"role": "system", "content": "user: $message"}]}',
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final replies = data['choices'][0]['message']['content'];
    return replies;
  } else {
    throw Exception('Failed to send chat request: ${response.statusCode}');
  }
}
 
 ChatApi() {
    OpenAI.apiKey = "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";
    OpenAI.organization = "org-9QH8md76FeLgKX8US3aEOoVf";
  }
Future<String> completeChat( messages) async {
  final chatCompletion = await OpenAI.instance.chat.create(
    model: 'gpt-3.5-turbo',
    messages: [
      
        OpenAIChatCompletionChoiceMessageModel(
          role:  OpenAIChatMessageRole.user ,
          content: messages,
        ),
      
    ],
  );
  return chatCompletion.choices.first.message.content;
}

class Statistic {
  final String category;
  final double value;
  final Color color;

  Statistic(this.category, this.value,this.color);
}
