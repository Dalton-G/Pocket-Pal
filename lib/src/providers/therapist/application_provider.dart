import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:pocket_pal/src/models/application_model.dart';

class ApplicationProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadFile(PlatformFile file, String therapistId, String fileType) async {
    String fileName = '${DateTime.now().toIso8601String()}-$fileType.${file.extension}';
    Reference storageReference = _storage.ref().child('therapist-applications/$therapistId/$fileName');
    UploadTask uploadTask = storageReference.putFile(File(file.path!));
    await uploadTask.whenComplete(() => null);
    return await storageReference.getDownloadURL();
  }

  Future<void> submitApplication({
    required String therapistId,
    required String email,
    required String specialization,
    required String stateOfLicensure,
    required PlatformFile resumeFile,
    required List<PlatformFile> licenseFiles,
  }) async {
    String resumeUrl = await uploadFile(resumeFile, therapistId, 'resume');
    List<String> licenseUrls = [];

    for (var licenseFile in licenseFiles) {
      String licenseUrl = await uploadFile(licenseFile, therapistId, 'license');
      licenseUrls.add(licenseUrl);
    }

    DocumentReference docRef = _db.collection('applications').doc();

    ApplicationModel application = ApplicationModel(
      id: docRef.id,
      therapistId: therapistId,
      specialization: specialization,
      state_of_licensure: stateOfLicensure,
      resumeUrl: resumeUrl,
      licenseUrls: licenseUrls,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await docRef.set({
      'id': application.id,
      'therapistId': application.therapistId,
      'specialization': application.specialization,
      'state_of_licensure': application.state_of_licensure,
      'resumeUrl': application.resumeUrl,
      'licenseUrls': application.licenseUrls,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    notifyListeners();
  }
}
