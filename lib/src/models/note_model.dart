import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String id;
  final String patientId;
  final String therapistId;
  final DateTime sessionDate;
  final String content;
  final String followUpActions;
  final DateTime createdAt;
  final DateTime updatedAt;

  NoteModel({
    required this.id,
    required this.patientId,
    required this.therapistId,
    required this.sessionDate,
    required this.content,
    required this.followUpActions,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NoteModel.fromDocument(DocumentSnapshot doc) {
    return NoteModel(
      id: doc['id'],
      patientId: doc['patient_id'],
      therapistId: doc['therapist_id'],
      sessionDate: (doc['session_date'] as Timestamp).toDate(),
      content: doc['content'],
      followUpActions: doc['follow_up_actions'],
      createdAt: (doc['created_at'] as Timestamp).toDate(),
      updatedAt: (doc['updated_at'] as Timestamp).toDate(),
    );
  }
}
