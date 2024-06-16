import 'package:cloud_firestore/cloud_firestore.dart';

class SessionNoteModel {
  final String id;
  final String bookingId;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

  SessionNoteModel({
    required this.id,
    required this.bookingId,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SessionNoteModel.fromDocument(DocumentSnapshot doc) {
    return SessionNoteModel(
      id: doc.id,
      bookingId: doc.get('booking_id'),
      content: doc.get('content'),
      createdAt: (doc.get('created_at') as Timestamp).toDate(),
      updatedAt: (doc.get('updated_at') as Timestamp).toDate(),
    );
  }
}
