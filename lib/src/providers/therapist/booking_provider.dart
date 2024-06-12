import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pal/src/models/booking_model.dart';
import 'package:pocket_pal/src/models/user_model.dart';
import 'package:pocket_pal/src/models/availability_model.dart';
import 'package:pocket_pal/src/utils/date_utils.dart' as utils;

class BookingProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Map<String, dynamic>> _bookings = [];

  List<Map<String, dynamic>> get bookings => _bookings;

  Future<void> fetchBookings(String therapistId) async {
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

        // Compute age using the utility function
        int age = utils.DateUtils.computeAge(DateTime.parse(user.dateOfBirth));

        // Fetch availability data
        DocumentSnapshot availabilityDoc = await _db.collection('availabilities').doc(booking.availabilityId).get();
        AvailabilityModel availability = AvailabilityModel.fromDocument(availabilityDoc);

        // Combine data
        bookingData.add({
          'name': '${user.firstName} ${user.lastName}',
          'details': '$age years old - ${user.education}',
          'imageUrl': user.profilePicture,
          'startTime': availability.availableOn,
          'endTime': availability.availableUntil,
        });
      }

      _bookings = bookingData;
      notifyListeners();
    } catch (e) {
      print("Error fetching bookings: $e");
    }
  }
}
