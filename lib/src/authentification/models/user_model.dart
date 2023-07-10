import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String password;
  final double? points;
  final String? role;
  final String? niveau;

  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.fullName,
    this.points,
    this.role,
    this.niveau,
  });

  toJson() {
    return {
      "FullName": fullName,
      "Email": email,
      "Password": password,
      "points": points,
      "role": role,
      "niveau": niveau,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
        id: document.id,
        email: data["Email"],
        password: data["Password"],
        role: data["role"],
        fullName: data["FullName"],
        points: data["points"],
        niveau: data["niveau"]);
  }
}
