import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pal/src/widgets/admin/manage_profile/ban_button.dart';
import 'package:pocket_pal/src/widgets/auth/alertDialog.dart';
import 'package:pocket_pal/src/widgets/auth/authButton.dart';
import 'package:pocket_pal/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewTherapistApplication extends StatefulWidget {
  final Map<String, dynamic> applicationData;
  final Map<String, dynamic> therapistData;
  const ViewTherapistApplication(
      {super.key, required this.applicationData, required this.therapistData});

  @override
  State<ViewTherapistApplication> createState() =>
      _ViewTherapistApplicationState();
}

class _ViewTherapistApplicationState extends State<ViewTherapistApplication> {
  void _launchResume(BuildContext context) async {
    final resumeUrl = widget.applicationData['resumeUrl'];
    final Uri uri = Uri.parse(resumeUrl);
    await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
  }

  void _showLicenseDialog(BuildContext context) {
    final List<String> licenseUrls =
        List<String>.from(widget.applicationData['licenseUrls']);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Stack(
            children: [
              Positioned(
                top: 8.0,
                right: 8.0,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Therapist License",
                      style: AppTheme.normalTextGreen,
                    ),
                    const Divider(),
                    Expanded(
                      child: PageView.builder(
                        itemCount: licenseUrls.length,
                        itemBuilder: (context, index) {
                          return Image.network(licenseUrls[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _approveApplication(BuildContext context) async {
    final _db = FirebaseFirestore.instance;
    final _storage = FirebaseStorage.instance;
    final String applicationId = widget.applicationData['id'];
    final String therapistId = widget.therapistData['id'];

    try {
      // Delete resume from Firebase Storage
      final String resumeUrl = widget.applicationData['resumeUrl'];
      if (resumeUrl.isNotEmpty) {
        await _storage.refFromURL(resumeUrl).delete();
      }

      // Delete license images from Firebase Storage
      final List<String> licenseUrls =
          List<String>.from(widget.applicationData['licenseUrls']);
      for (String licenseUrl in licenseUrls) {
        await _storage.refFromURL(licenseUrl).delete();
      }

      // Delete the application document
      await _db.collection('applications').doc(applicationId).delete();

      // Update the therapist document to set 'is_approved' to true
      await _db.collection('users').doc(therapistId).update({
        'is_approved': true,
      });

      Navigator.pop(context);

      showAuthDialog(
        context,
        "Application Approved",
        "The therapist has been approved",
      );
    } catch (e) {
      showAuthDialog(
        context,
        "Error: $e",
        "Failed to approve the application. Please try again.",
      );
    }
  }

  void _rejectApplication(BuildContext context) async {
    final _db = FirebaseFirestore.instance;
    final _storage = FirebaseStorage.instance;
    final String applicationId = widget.applicationData['id'];
    final String therapistId = widget.therapistData['id'];

    try {
      // Delete resume from Firebase Storage
      final String resumeUrl = widget.applicationData['resumeUrl'];
      if (resumeUrl.isNotEmpty) {
        await _storage.refFromURL(resumeUrl).delete();
      }

      // Delete license images from Firebase Storage
      final List<String> licenseUrls =
          List<String>.from(widget.applicationData['licenseUrls']);
      for (String licenseUrl in licenseUrls) {
        await _storage.refFromURL(licenseUrl).delete();
      }

      // Delete the application document
      await _db.collection('applications').doc(applicationId).delete();

      // Update the therapist document to set 'is_approved' to true
      await _db.collection('users').doc(therapistId).update({
        'is_banned': true,
      });

      Navigator.pop(context);

      showAuthDialog(
        context,
        "Application Rejected",
        "The therapist has been rejected",
      );
    } catch (e) {
      showAuthDialog(
        context,
        "Error: $e",
        "Failed to reject the application. Please try again.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Application'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: widget.therapistData['profile_picture'] == ""
                    ? AssetImage('lib/src/assets/images/avatar.png')
                        as ImageProvider
                    : NetworkImage(widget.therapistData['profile_picture']),
              ),
              const SizedBox(height: 20),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.therapistData['first_name'],
                      style: AppTheme.largeTextGreen,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.therapistData['last_name'],
                      style: AppTheme.largeTextGrey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(widget.therapistData['email'],
                  style: AppTheme.normalTextGrey),
              Text(widget.therapistData['phone'],
                  style: AppTheme.normalTextGreen),
              Divider(),
              const SizedBox(height: 10),
              Text(
                "- Profession -",
                style: AppTheme.mediumTextGrey,
              ),
              Text(widget.applicationData['specialization'],
                  style: AppTheme.normalTextGreen),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _launchResume(context),
                    child: const Text("View Resume"),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () => _showLicenseDialog(context),
                    child: const Text("View License"),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () => _approveApplication(context),
                child: AuthButton(
                  buttonText: 'Approve',
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _rejectApplication(context),
                child: BanButton(
                  buttonText: 'Reject',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
