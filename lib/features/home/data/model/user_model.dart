import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String name;
  final int age;
  final Timestamp? timestamp;
  final List<String>? serach;

  UserModel(
      {this.timestamp, required this.name, required this.age, this.serach});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      timestamp: map['timestamp'],
      name: map['name'] ?? '',
      age: map['age'] ?? '',
      // serach: map['search'] ??''
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'search': serach,
      'timestamp': timestamp ?? FieldValue.serverTimestamp(),
    };
  }
}
