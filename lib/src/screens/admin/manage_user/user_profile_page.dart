import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pocket_pal/src/widgets/admin/manage_profile/ban_button.dart';
import 'package:pocket_pal/src/widgets/auth/alertDialog.dart';
import 'package:pocket_pal/theme/app_theme.dart';

class UserProfilePage extends StatefulWidget {
  final Map<String, dynamic> userData;
  final VoidCallback? onBanUser;

  UserProfilePage({Key? key, required this.userData, required this.onBanUser})
      : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String formatTimestamp(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  bool isBanned = false;

  @override
  void initState() {
    super.initState();
    checkBanStatus();
  }

  void checkBanStatus() {
    bool banned = widget.userData['is_banned'] ?? false;
    setState(() {
      isBanned = banned;
    });
  }

  void toggleBanStatus() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userData['id'])
          .update({'is_banned': !isBanned});
      setState(() {
        isBanned = !isBanned;
      });
      showAuthDialog(
          context,
          isBanned ? "User has been banned!" : "User has been unbanned",
          "The user ban status has been updated successfully.");
      if (widget.onBanUser != null) {
        widget.onBanUser!();
      }
    } catch (e) {
      print("Error Toggling Ban Status $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 35.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage:
                      NetworkImage(widget.userData['profile_picture']),
                ),
                SizedBox(height: 10),
                Text(
                  "${widget.userData['first_name']} ${widget.userData['last_name']}",
                  style: AppTheme.mediumTextGrey,
                ),
                Text(
                  "${widget.userData['role']}",
                  style: AppTheme.smallTextGreen,
                ),
                const SizedBox(height: 10),
                buildBanChip(),
                const SizedBox(height: 10),
                Divider(
                  color: AppTheme.primaryGreen,
                ),
                const SizedBox(height: 10),
                Text("Details:", style: AppTheme.normalTextGreen),
                Text(
                  "Gender: ${widget.userData['gender']}",
                  style: AppTheme.smallTextGrey,
                ),
                Text(
                  "Joined: ${formatTimestamp(widget.userData['created_at'])}",
                  style: AppTheme.smallTextGrey,
                ),
                Text(
                  "Id: ${widget.userData['id']}",
                  style: AppTheme.smallTextGrey,
                ),
                const SizedBox(height: 20),
                Divider(
                  color: AppTheme.primaryGreen,
                ),
                const SizedBox(height: 10),
                Text("Contact:", style: AppTheme.normalTextGreen),
                Text(
                  "Email: ${widget.userData['email']}",
                  style: AppTheme.smallTextGrey,
                ),
                Text(
                  "Phone: ${widget.userData['phone']}",
                  style: AppTheme.smallTextGrey,
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  child: BanButton(
                    buttonText: isBanned ? "Unban User" : "Ban User",
                  ),
                  onTap: toggleBanStatus,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBanChip() {
    return Chip(
      label: Text(
        isBanned ? "Banned" : "Active",
        style: AppTheme.smallTextWhite,
      ),
      backgroundColor: isBanned ? AppTheme.lightRed : AppTheme.primaryGreen,
    );
  }
}
