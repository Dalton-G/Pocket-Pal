import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final DateTime created_at;
  final DateTime updated_at;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.created_at,
    required this.updated_at,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
      role: doc['role'],
      created_at: (doc['created_at'] as Timestamp).toDate(),
      updated_at: (doc['updated_at'] as Timestamp).toDate(),
    );
  }
}
