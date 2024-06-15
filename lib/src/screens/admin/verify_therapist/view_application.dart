import 'package:flutter/material.dart';
import 'package:pocket_pal/src/widgets/admin/manage_profile/ban_button.dart';
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
    await launchUrl(uri, mode: LaunchMode.externalApplication);
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
              AuthButton(
                buttonText: 'Approve',
              ),
              const SizedBox(height: 20),
              BanButton(
                buttonText: 'Reject',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
