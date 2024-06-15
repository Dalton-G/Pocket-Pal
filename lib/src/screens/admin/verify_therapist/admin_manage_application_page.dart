import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pal/src/screens/admin/verify_therapist/view_application.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class AdminManageApplicationPage extends StatefulWidget {
  const AdminManageApplicationPage({super.key});

  @override
  State<AdminManageApplicationPage> createState() =>
      _AdminManageApplicationPageState();
}

class _AdminManageApplicationPageState
    extends State<AdminManageApplicationPage> {
  Stream<QuerySnapshot<Map<String, dynamic>>> getApplicationStream() {
    return FirebaseFirestore.instance.collection('applications').snapshots();
  }

  Future<Map<String, dynamic>> getTherapistData(String therapistId) async {
    final docRef =
        FirebaseFirestore.instance.collection('users').doc(therapistId);
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      return snapshot.data()!;
    } else {
      print("Therapist data not found for ID: $therapistId");
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      appBar: AppBar(
        title: const Text("Verify Therapist"),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: getApplicationStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              return snapshot.hasData && snapshot.data!.docs.isNotEmpty
                  ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final applicationDoc = snapshot.data!.docs[index];
                        final applicationData = applicationDoc.data();

                        final therapistId = applicationData['therapistId'];
                        applicationData['licenseUrls'] as List<dynamic>;
                        final specialization =
                            applicationData['specialization'];
                        applicationData['state_of_licensure'];

                        return FutureBuilder<Map<String, dynamic>>(
                          future: getTherapistData(therapistId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final therapistData = snapshot.data!;
                              final therapistName =
                                  "${therapistData['first_name']} ${therapistData['last_name']}";
                              return ListTile(
                                title: Text(therapistName,
                                    style: AppTheme.smallTextGrey),
                                subtitle: Text(specialization),
                                leading: CircleAvatar(
                                  backgroundImage: therapistData[
                                              'profile_picture'] !=
                                          ""
                                      ? NetworkImage(
                                          therapistData['profile_picture'])
                                      : AssetImage(
                                              'lib/src/assets/images/avatar.png')
                                          as ImageProvider<Object>?,
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewTherapistApplication(
                                                        therapistData:
                                                            therapistData,
                                                        applicationData:
                                                            applicationData)));
                                      },
                                      child: const Text('View Application'),
                                    ),
                                  ],
                                ),
                              );
                            } else if (snapshot.hasError) {
                              print(
                                  "Error fetching therapist name: ${snapshot.error}");
                              return Container();
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        );
                      },
                    )
                  : const Center(child: Text('No applications found.'));
          }
        },
      ),
    );
  }
}
