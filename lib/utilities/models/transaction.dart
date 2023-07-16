import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String localisation;
  final bool soldeVerfication;
  final String userID;
  final String time;
  final String destination;
  final int totalItems;
  TransactionModel(
      {required this.localisation,
      required this.soldeVerfication,
      required this.userID,
      required this.time,
      required this.totalItems,
      required this.destination});

  Map<String, dynamic> toJson() {
    return {
      'localisation': localisation,
      'soldeVerification': soldeVerfication,
      'userID': userID,
      'time': time,
      'totalItems': totalItems,
      'destination': destination,
    };
  }

  factory TransactionModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    final data = snapshot.data()!;

    return TransactionModel(
      totalItems: data['totalItems'],
      localisation: data['localisation'],
      soldeVerfication: data['soldeVerfication'],
      userID: data['userID'],
      time: data['time'],
      destination: data['destination'],
    );
  }
}
