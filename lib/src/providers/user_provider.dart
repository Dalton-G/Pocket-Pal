// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pal/src/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  UserModel? get userModel => _userModel;

  void setUser(UserModel userModel) {
    _userModel = userModel;
    notifyListeners();
  }

  Future<DocumentSnapshot> getUserData(String uid) async {
    return await _db.collection('users').doc(uid).get();
  }

  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      DocumentSnapshot userDoc =
          await _db.collection('users').doc(userCredential.user!.uid).get();
      UserModel userModel = UserModel.fromDocument(userDoc);
      setUser(userModel);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      _userModel = null;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }

  Future<void> signUp(
    String email,
    String password,
    String first_name,
    String last_name,
    String phone,
    String gender,
    String role,
    String date_of_birth,
  ) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final String user_id = userCredential.user!.uid;
      await addUserDetails(
        user_id,
        email,
        first_name,
        last_name,
        phone,
        gender,
        role,
        date_of_birth,
      );
      await fetchAndSetUserModel();
    } catch (error) {
      print("Error registering user: $error");
    }
  }

  Future<void> addUserDetails(
    String user_id,
    String email,
    String first_name,
    String last_name,
    String phone,
    String gender,
    String role,
    String date_of_birth,
  ) async {
    final Timestamp now = Timestamp.now();
    await _db.collection('users').doc(user_id).set(
      {
        'id': user_id,
        'email': email.trim(),
        'first_name': first_name.trim(),
        'last_name': last_name.trim(),
        'profile_picture': '',
        'phone': phone.trim(),
        'gender': gender,
        'role': role,
        'is_banned': false,
        'date_of_birth': date_of_birth,
        'created_at': now,
        'updated_at': now,
      },
    );
  }

  Future<void> fetchAndSetUserModel() async {
    if (_auth.currentUser != null) {
      DocumentSnapshot userDoc =
          await _db.collection('users').doc(_auth.currentUser!.uid).get();
      UserModel userModel = UserModel.fromDocument(userDoc);
      setUser(userModel);
    }
  }
}
