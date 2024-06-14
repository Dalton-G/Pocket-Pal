import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String profilePicture;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;
  final String role;
  final bool isBanned;
  final String dateOfBirth;
  final DateTime createdAt;
  final DateTime updatedAt;
  String? education;
  String? specialization;
  bool? isApproved;
  bool? isSubmitted;

  UserModel({
    required this.id,
    required this.profilePicture,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.role,
    required this.isBanned,
    required this.dateOfBirth,
    required this.createdAt,
    required this.updatedAt,
    this.education,
    this.specialization,
    this.isApproved,
    this.isSubmitted,
  });

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    return UserModel(
      id: doc['id'],
      profilePicture: (doc.data() as Map<String, dynamic>)
                  .containsKey('profile_picture') &&
              doc.get('profile_picture') != ""
          ? doc.get('profile_picture')
          : 'https://firebasestorage.googleapis.com/v0/b/pocketpal-ebd3b.appspot.com/o/therapist-applications%2Fuser%2Fdefault_profile_pic.jpg?alt=media&token=bc6e5b94-a63a-47f6-92b0-11421b2e39d9',
      firstName: doc['first_name'],
      lastName: doc['last_name'],
      email: doc['email'],
      phone: doc['phone'],
      gender: doc['gender'],
      role: doc['role'],
      isBanned: doc['is_banned'],
      dateOfBirth: doc['date_of_birth'],
      createdAt: (doc['created_at'] as Timestamp).toDate(),
      updatedAt: (doc['updated_at'] as Timestamp).toDate(),
      education: (doc.data() as Map<String, dynamic>).containsKey('education')
          ? doc.get('education')
          : '',
      specialization:
          (doc.data() as Map<String, dynamic>).containsKey('specialization')
              ? doc.get('specialization')
              : '',
      isApproved:
          (doc.data() as Map<String, dynamic>).containsKey('is_approved')
              ? doc.get('is_approved')
              : null,
      isSubmitted:
          (doc.data() as Map<String, dynamic>).containsKey('is_submitted')
              ? doc.get('is_submitted')
              : null,
    );
  }
}
