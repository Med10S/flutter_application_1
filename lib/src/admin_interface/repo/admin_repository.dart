
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../authentification/controllers/profil_controller.dart';
import '../../authentification/models/dechet_model.dart';

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