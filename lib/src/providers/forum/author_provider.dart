import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthorProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, Map<String, dynamic>> _userData = {};

  Map<String, dynamic> getUserData(String userId) {
    return _userData[userId] ?? {};
  }

  Future<void> fetchUserData(String userId) async {
    if (_userData.containsKey(userId)) {
      return;
    }

    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(userId).get();
      _userData[userId] = snapshot.data() as Map<String, dynamic>;
    } catch (error) {
      print('Error fetching user data: $error');
    }

    notifyListeners();
  }

  Future<void> fetchAllUserData(List<String> userIds) async {
    for (var userId in userIds) {
      if (!_userData.containsKey(userId)) {
        try {
          DocumentSnapshot snapshot =
              await _firestore.collection('users').doc(userId).get();
          _userData[userId] = snapshot.data() as Map<String, dynamic>;
        } catch (error) {
          print('Error fetching user data for userId: $userId, Error: $error');
        }
      }
    }

    notifyListeners();
  }
}
