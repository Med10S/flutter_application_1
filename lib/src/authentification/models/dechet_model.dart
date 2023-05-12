import 'package:cloud_firestore/cloud_firestore.dart';
class DechetModel {
  final int carton;
  final int metale;
  final int organique;
  final int plastique;
  final int verre;


  const DechetModel({
    required this.carton,
    required this.metale,
    required this.organique,
    required this.plastique,
    required this.verre,
  });
    
    
  toJson() {
    return {
      "carton": carton,
      "metale": metale,
      "organique": organique,
      "plastique": plastique,
      "verre": verre,
    };
  }
  
  factory DechetModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return DechetModel(
        carton: data["carton"],
        metale: data["metale"],
        organique: data["organique"],
        plastique: data["plastique"],
        verre: data["verre"]);
  }
}
