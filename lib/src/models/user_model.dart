import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String profile_picture;
  final String first_name;
  final String last_name;
  final String email;
  final String phone;
  final String gender;
  final String role;
  final bool is_banned;
  final String date_of_birth;
  final DateTime created_at;
  final DateTime updated_at;

  UserModel({
    required this.id,
    required this.profile_picture,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.role,
    required this.is_banned,
    required this.date_of_birth,
    required this.created_at,
    required this.updated_at,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      profile_picture: doc['profile_picture'],
      first_name: doc['first_name'],
      last_name: doc['last_name'],
      email: doc['email'],
      phone: doc['phone'],
      gender: doc['gender'],
      role: doc['role'],
      is_banned: doc['is_banned'],
      date_of_birth: doc['date_of_birth'],
      created_at: (doc['created_at'] as Timestamp).toDate(),
      updated_at: (doc['updated_at'] as Timestamp).toDate(),
    );
  }
}
