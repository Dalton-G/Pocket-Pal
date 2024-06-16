import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:uuid/uuid.dart';

class ApplicationProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(PlatformFile file, String therapistId, String fileType) async {
    try {
      String fileName = '${DateTime.now().toIso8601String()}-$fileType.${file.extension}';
      Reference storageReference = _storage.ref().child('therapist-applications/$therapistId/$fileName');
      UploadTask uploadTask = storageReference.putFile(File(file.path!));
      await uploadTask.whenComplete(() => null);
      return await storageReference.getDownloadURL();
    } catch (e) {
      print('File upload failed: $e');
      rethrow;
    }
  }

  Future<void> submitApplication({
    required String therapistId,
    required String specialization,
    required String stateOfLicensure,
    required PlatformFile resumeFile,
    required List<PlatformFile> licenseFiles,
  }) async {
    try {
      String resumeUrl = await uploadFile(resumeFile, therapistId, 'resume');
      List<String> licenseUrls = [];

      for (var licenseFile in licenseFiles) {
        String licenseUrl = await uploadFile(licenseFile, therapistId, 'license');
        licenseUrls.add(licenseUrl);
      }

      final String id = Uuid().v4();
      final Timestamp now = Timestamp.now();

      await _db.collection('applications').doc(id).set({
        'id': id,
        'therapistId': therapistId,
        'specialization': specialization,
        'state_of_licensure': stateOfLicensure,
        'resumeUrl': resumeUrl,
        'licenseUrls': licenseUrls,
        'createdAt': now,
        'updatedAt': now,
      });

      // Update the user's document to set is_submitted to true
      await _db.collection('users').doc(therapistId).update({
        'is_submitted': true,
        'updated_at': now,
      });

      notifyListeners();
    } catch (e) {
      print('Application submission failed: $e');
    }
  }
}
