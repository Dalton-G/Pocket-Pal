import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _db = FirebaseFirestore.instance;

Future<int> getTotalUsers(String role) async {
  final collectionRef = _db.collection('users');
  final normalCaseRole =
      await collectionRef.where('role', isEqualTo: role).get();
  final lowerCaseRole =
      await collectionRef.where('role', isEqualTo: role.toLowerCase()).get();
  return normalCaseRole.docs.length + lowerCaseRole.docs.length;
}

Future<int> getTotalBookings() async {
  final collectionRef = _db.collection('bookings');
  final count = await collectionRef.get();
  return count.docs.length;
}

Future<int> getTotalPosts() async {
  final collectionRef = _db.collection('posts');
  final count = await collectionRef.get();
  return count.docs.length;
}

Future<Map<String, int>> getUserCountsByType() async {
  Map<String, int> userCounts = {'Admins': 0, 'Therapists': 0, 'Members': 0};

  QuerySnapshot adminSnapshot =
      await _db.collection('users').where('role', isEqualTo: 'Admin').get();
  QuerySnapshot adminLSnapshot =
      await _db.collection('users').where('role', isEqualTo: 'admin').get();

  QuerySnapshot therapistSnapshot =
      await _db.collection('users').where('role', isEqualTo: 'Therapist').get();
  QuerySnapshot therapistLSnapshot =
      await _db.collection('users').where('role', isEqualTo: 'therapist').get();

  QuerySnapshot memberSnapshot =
      await _db.collection('users').where('role', isEqualTo: 'Member').get();
  QuerySnapshot memberLSnapshot =
      await _db.collection('users').where('role', isEqualTo: 'member').get();

  userCounts['Admins'] = adminSnapshot.docs.length + adminLSnapshot.docs.length;
  userCounts['Therapists'] =
      therapistSnapshot.docs.length + therapistLSnapshot.docs.length;
  userCounts['Members'] =
      memberSnapshot.docs.length + memberLSnapshot.docs.length;

  return userCounts;
}
