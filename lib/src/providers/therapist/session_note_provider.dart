import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:pocket_pal/src/models/session_note_model.dart';

class SessionNoteProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addSessionNote({
    required String bookingId,
    required String content,
  }) async {
    try {
      final String id = Uuid().v4();
      final Timestamp now = Timestamp.now();
      await _db.collection('session_notes').doc(id).set({
        'id': id,
        'booking_id': bookingId,
        'content': content,
        'created_at': now,
        'updated_at': now,
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateSessionNote({
    required String noteId,
    required String content,
  }) async {
    try {
      final Timestamp now = Timestamp.now();
      await _db.collection('session_notes').doc(noteId).update({
        'content': content,
        'updated_at': now,
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<SessionNoteModel?> fetchSessionNote(String bookingId) async {
    try {
      QuerySnapshot sessionNotesSnapshot = await _db.collection('session_notes')
          .where('booking_id', isEqualTo: bookingId)
          .get();
      if (sessionNotesSnapshot.docs.isNotEmpty) {
        return SessionNoteModel.fromDocument(sessionNotesSnapshot.docs.first);
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}