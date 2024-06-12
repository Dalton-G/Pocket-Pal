import 'package:cloud_firestore/cloud_firestore.dart';

class AvailabilityModel {
  final String id;
  final String therapistId;
  final DateTime availableOn;
  final DateTime availableUntil;
  final bool isBooked;
  final DateTime createdAt;
  final DateTime updatedAt;

  AvailabilityModel({
    required this.id,
    required this.therapistId,
    required this.availableOn,
    required this.availableUntil,
    required this.isBooked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AvailabilityModel.fromDocument(DocumentSnapshot doc) {
    return AvailabilityModel(
      id: doc['id'],
      therapistId: doc['therapist_id'],
      availableOn: (doc['available_on'] as Timestamp).toDate(),
      availableUntil: (doc['available_until'] as Timestamp).toDate(),
      isBooked: doc['is_booked'],
      createdAt: (doc['created_at'] as Timestamp).toDate(),
      updatedAt: (doc['updated_at'] as Timestamp).toDate(),
    );
  }
}
