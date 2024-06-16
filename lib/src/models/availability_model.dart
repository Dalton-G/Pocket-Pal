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
      id: doc.id,
      therapistId: doc.get('therapist_id'),
      availableOn: (doc.get('available_on') as Timestamp).toDate(),
      availableUntil: (doc.get('available_until') as Timestamp).toDate(),
      isBooked: doc.get('is_booked'),
      createdAt: (doc.get('created_at') as Timestamp).toDate(),
      updatedAt: (doc.get('updated_at') as Timestamp).toDate(),
    );
  }
}
