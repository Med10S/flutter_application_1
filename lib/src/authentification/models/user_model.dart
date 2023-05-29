import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class UserModel {
  final String? id;
  final String fullName;
  final String email;
  final String password;
  final int points;
  final String role;
  final String niveau;


  const UserModel({
    this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.points,
    required this.role,
    required this.niveau,
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
        niveau:data["niveau"]);
  }
}
