import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pal/src/models/booking_model.dart';
import 'package:pocket_pal/src/models/user_model.dart';
import 'package:pocket_pal/src/models/availability_model.dart';
import 'package:pocket_pal/src/providers/therapist/session_note_provider.dart';
import 'package:pocket_pal/src/utils/date_utils.dart' as utils;

class BookingProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _bookings = [];
  List<Map<String, dynamic>> _patients = [];

  List<Map<String, dynamic>> get bookings => _bookings;
  List<Map<String, dynamic>> get patients => _patients;

  Future<void> getBookings(String therapistId) async {
    try {
      QuerySnapshot bookingSnapshot = await _db
          .collection('bookings')
          .where('therapist_id', isEqualTo: therapistId)
          .get();

      List<Map<String, dynamic>> bookingData = [];

      for (var bookingDoc in bookingSnapshot.docs) {
        var booking = BookingModel.fromDocument(bookingDoc);

        DocumentSnapshot userDoc = await _db.collection('users').doc(booking.memberId).get();
        UserModel user = UserModel.fromDocument(userDoc);

        // Compute age
        int age = utils.DateUtils.computeAge(DateTime.parse(user.dateOfBirth));

        // Fetch availability data
        DocumentSnapshot availabilityDoc = await _db.collection('availabilities').doc(booking.availabilityId).get();
        AvailabilityModel availability = AvailabilityModel.fromDocument(availabilityDoc);

        // Combine data
        bookingData.add({
          'name': '${user.firstName} ${user.lastName}',
          'details': '$age years old',
          'imageUrl': user.profilePicture,
          'startTime': availability.availableOn,
          'endTime': availability.availableUntil,
          'bookingId': booking.id,
        });
      }

      _bookings = bookingData;
      notifyListeners();
    } catch (e) {
      print("Error fetching bookings: $e");
    }
  }

  Future<void> getPatients(String therapistId, SessionNoteProvider noteProvider) async {
    try {
      QuerySnapshot bookingSnapshot = await _db
          .collection('bookings')
          .where('therapist_id', isEqualTo: therapistId)
          .get();

      Map<String, Map<String, dynamic>> patientData = {};

      for (var bookingDoc in bookingSnapshot.docs) {
        var booking = BookingModel.fromDocument(bookingDoc);
        var user = await _fetchUserDetails(booking.memberId);
        var availability = await _fetchAvailabilityDetails(booking.availabilityId);
        var sessionNote = await noteProvider.fetchSessionNote(booking.id);

        // Combine data
        if (patientData.containsKey(user.id)) {
          patientData[user.id]?['sessions'].add({
            'startTime': availability.availableOn,
            'endTime': availability.availableUntil,
            'notes': sessionNote?.content ?? 'No notes'
          });
        } else {
          patientData[user.id] = {
            'name': '${user.firstName} ${user.lastName}',
            'details': '${utils.DateUtils.computeAge(DateTime.parse(user.dateOfBirth))} years old',
            'imageUrl': user.profilePicture,
            'sessions': [
              {
                'startTime': availability.availableOn,
                'endTime': availability.availableUntil,
                'notes': sessionNote?.content ?? 'No notes'
              }
            ]
          };
        }
      }

      _patients = patientData.values.toList();
      notifyListeners();
    } catch (e) {
      print("Error fetching patients: $e");
    }
  }

  Future<UserModel> _fetchUserDetails(String userId) async {
    DocumentSnapshot userDoc = await _db.collection('users').doc(userId).get();
    return UserModel.fromDocument(userDoc);
  }

  Future<AvailabilityModel> _fetchAvailabilityDetails(String availabilityId) async {
    DocumentSnapshot availabilityDoc = await _db.collection('availabilities').doc(availabilityId).get();
    return AvailabilityModel.fromDocument(availabilityDoc);
  }
}
