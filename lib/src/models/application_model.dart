import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationModel {
  final String id;
  final String therapistId;
  final String specialization;
  final String state_of_licensure;
  final String resumeUrl;
  final List<String> licenseUrls;
  final DateTime createdAt;
  final DateTime updatedAt;

  ApplicationModel({
    required this.id,
    required this.therapistId,
    required this.specialization,
    required this.state_of_licensure,
    required this.resumeUrl,
    required this.licenseUrls,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ApplicationModel.fromDocument(DocumentSnapshot doc) {
    return ApplicationModel(
      id: doc['id'],
      therapistId: doc['therapistId'],
      specialization: doc['specialization'],
      state_of_licensure: doc['state_of_licensure'],
      resumeUrl: doc['resumeUrl'],
      licenseUrls: List<String>.from(doc['licenseUrls']),
      createdAt: (doc['createdAt'] as Timestamp).toDate(),
      updatedAt: (doc['updatedAt'] as Timestamp).toDate(),
    );
  }
}
