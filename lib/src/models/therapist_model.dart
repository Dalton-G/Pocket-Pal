import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pocket_pal/src/models/user_model.dart';

class TherapistModel extends UserModel {
  final String education;
  final String specialization;
  final bool is_approved;
  final double avg_rating;

  TherapistModel({
    required String id,
    required String profile_picture,
    required String first_name,
    required String last_name,
    required String email,
    required String phone,
    required String gender,
    required String role,
    required bool is_banned,
    required String date_of_birth,
    required DateTime created_at,
    required DateTime updated_at,
    required this.education,
    required this.specialization,
    required this.is_approved,
    required this.avg_rating,
  }) : super(
          id: id,
          profile_picture: profile_picture,
          first_name: first_name,
          last_name: last_name,
          email: email,
          phone: phone,
          gender: gender,
          role: role,
          is_banned: false,
          date_of_birth: date_of_birth,
          created_at: DateTime.now(),
          updated_at: DateTime.now(),
        );

  factory TherapistModel.fromDocument(DocumentSnapshot doc) {
    return TherapistModel(
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
      education: doc['education'],
      specialization: doc['specialization'],
      is_approved: doc['is_approved'],
      avg_rating: doc['avg_rating'],
    );
  }
}
