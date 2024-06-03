// ignore_for_file: avoid_print
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pal/src/models/auth/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _userModel;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

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
    String firstName,
    String lastName,
    String phone,
    String gender,
    String role,
    String dateOfBirth,
    Uint8List? profilePicture,
  ) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final String userId = userCredential.user!.uid;
      String imageUrl;

      // check if profile picture is null
      if (profilePicture != null) {
        imageUrl = await uploadProfilePic('profile_pictures/$userId',
            profilePicture); // Upload profile picture to Firebase Storage
      } else {
        imageUrl = '';
      }

      // check if role is therapist
      if (role == 'Therapist') {
        await addTherapistDetails(userId, email, firstName, lastName, phone,
            gender, role, dateOfBirth, imageUrl);
      } else {
        await addUserDetails(userId, email, firstName, lastName, phone, gender,
            role, dateOfBirth, imageUrl);
      }
      await fetchAndSetUserModel();
    } catch (error) {
      print("Error registering user: $error");
    }
  }

  Future<void> addUserDetails(
    String userId,
    String email,
    String firstName,
    String lastName,
    String phone,
    String gender,
    String role,
    String dateOfBirth,
    String imageUrl,
  ) async {
    final Timestamp now = Timestamp.now();
    await _db.collection('users').doc(userId).set(
      {
        'id': userId,
        'email': email.trim(),
        'first_name': firstName.trim(),
        'last_name': lastName.trim(),
        'profile_picture': imageUrl,
        'phone': phone.trim(),
        'gender': gender,
        'role': role,
        'is_banned': false,
        'date_of_birth': dateOfBirth,
        'created_at': now,
        'updated_at': now,
      },
    );
  }

  Future<void> addTherapistDetails(
    String userId,
    String email,
    String firstName,
    String lastName,
    String phone,
    String gender,
    String role,
    String dateOfBirth,
    String imageUrl,
  ) async {
    final Timestamp now = Timestamp.now();
    await _db.collection('users').doc(userId).set(
      {
        'id': userId,
        'email': email.trim(),
        'first_name': firstName.trim(),
        'last_name': lastName.trim(),
        'profile_picture': imageUrl,
        'phone': phone.trim(),
        'gender': gender,
        'role': role,
        'is_banned': false,
        'date_of_birth': dateOfBirth,
        'created_at': now,
        'updated_at': now,
        'education': '',
        'specialization': '',
        'is_approved': false,
        'is_submitted': false,
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

  Future<String> uploadProfilePic(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
