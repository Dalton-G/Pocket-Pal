import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:pocket_pal/src/models/availability_model.dart';

class AvailabilityProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<AvailabilityModel> _availabilities = [];

  List<AvailabilityModel> get availabilities => _availabilities;

  Future<void> addAvailability({
    required String therapistId,
    required DateTime availableOn,
    required DateTime availableUntil,
  }) async {
    try {
      final String id = Uuid().v4();
      final Timestamp now = Timestamp.now();
      await _db.collection('availabilities').doc(id).set({
        'id': id,
        'therapist_id': therapistId,
        'available_on': availableOn,
        'available_until': availableUntil,
        'is_booked': false,
        'created_at': now,
        'updated_at': now,
      });
      await getAvailabilities(therapistId);
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAvailabilities(String therapistId) async {
    try {
      final snapshot = await _db
          .collection('availabilities')
          .where('therapist_id', isEqualTo: therapistId)
          .get();

      _availabilities = snapshot.docs
          .map((doc) => AvailabilityModel.fromDocument(doc))
          .toList();

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> removeAvailability(String id, String therapistId) async {
    try {
      await _db.collection('availabilities').doc(id).delete();
      await getAvailabilities(therapistId);
    } catch (e) {
      print(e);
    }
  }
}
