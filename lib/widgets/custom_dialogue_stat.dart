import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/dimention.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../src/authentification/controllers/profil_controller.dart';
import '../src/authentification/models/dechet_model.dart';
import '../src/user_interface/chart2.dart';
import 'package:intl/intl.dart';

class CustomDialogStat extends StatelessWidget {
  final bool isDark;
  final String date;
  final String userIdFinal;
  final Image image;
  const CustomDialogStat({super.key, 
    required this.isDark,
    required this.date,
    required this.userIdFinal,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    final Brightness brightnessValue =
        MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:const  EdgeInsets.only(
            top: 16,
            bottom: 16,
            left: 16,
            right: 16,
          ),
          margin: const EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: isDark ? const Color.fromARGB(255, 0, 0, 0) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "votre consomation pour : ${date == DateFormat('yyyy-MM-dd').format(DateTime.now()) ? "Auj" : date}",
                textAlign: TextAlign.center,
              ),
              FutureBuilder<List<quatitedechet>>(
                future: getchardata(date),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final chartData = snapshot.data!;
                    return SfCircularChart(
                      margin: const EdgeInsets.all(0),
                      backgroundColor: Colors.transparent,
                      legend: Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.wrap,
                          position: LegendPosition.bottom),
                      series: <CircularSeries>[
                        RadialBarSeries<quatitedechet, String>(
                          maximumValue: 10,
                          dataSource: chartData,
                          legendIconType: LegendIconType.seriesType,
                          cornerStyle: CornerStyle.bothCurve,
                          xValueMapper: (quatitedechet data, _) => data.produit,
                          yValueMapper: (quatitedechet data, _) =>
                              data.quantite,
                          dataLabelSettings: const DataLabelSettings(isVisible: true),
                        )
                      ],
                    );
                    // Ici, vous pouvez utiliser les données `_chartData` pour personnaliser
                    // l'apparence de chaque jour dans le calendrier en fonction des statistiques.
                  }
                },
              )
            ],
          ),
        ), Positioned(
      top: -Dimenssion.height32dp,
      left: 16,
      right: 16,
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60,
        child: ClipRRect(
         
          child: image,
        ),
      ),
    ),

      ],
      
    );
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

  Future<DechetModel> getusesstat(String day) async {
    Future<dynamic> userStat =
        ProfileController().getUserStat(day, userIdFinal);
    DechetModel data = await userStat;
    debugPrint("metale1${data.metale}");
    return data;
  }
}
