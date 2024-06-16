import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String id;
  final String memberId;
  final String therapistId;
  final String availabilityId;
  final String review;
  final num rating;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookingModel({
    required this.id,
    required this.memberId,
    required this.therapistId,
    required this.availabilityId,
    required this.review,
    required this.rating,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BookingModel.fromDocument(DocumentSnapshot doc) {
    return BookingModel(
      id: doc.id,
      memberId: doc.get('member_id'),
      therapistId: doc.get('therapist_id'),
      availabilityId: doc.get('availability_id'),
      review: doc.get('review'),
      rating: doc.get('rating'),
      createdAt: (doc.get('created_at') as Timestamp).toDate(),
      updatedAt: (doc.get('updated_at') as Timestamp).toDate(),
    );
  }
}