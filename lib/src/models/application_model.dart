import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationModel {
  final String id;
  final String therapistId;
  final String specialization;
  final String stateOfLicensure;
  final String resumeUrl;
  final List<String> licenseUrls;
  final DateTime createdAt;
  final DateTime updatedAt;

  ApplicationModel({
    required this.id,
    required this.therapistId,
    required this.specialization,
    required this.stateOfLicensure,
    required this.resumeUrl,
    required this.licenseUrls,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ApplicationModel.fromDocument(DocumentSnapshot doc) {
    return ApplicationModel(
      id: doc.id,
      therapistId: doc.get('therapistId'),
      specialization: doc.get('specialization'),
      stateOfLicensure: doc.get('state_of_licensure'),
      resumeUrl: doc.get('resumeUrl'),
      licenseUrls: List<String>.from(doc.get('licenseUrls')),
      createdAt: (doc.get('createdAt') as Timestamp).toDate(),
      updatedAt: (doc.get('updatedAt') as Timestamp).toDate(),
    );
  }
}
