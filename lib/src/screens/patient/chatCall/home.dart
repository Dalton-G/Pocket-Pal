import 'package:flutter/material.dart';
import 'package:pocket_pal/src/screens/patient/chatCall/chat_list.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class Home extends StatelessWidget {
  Home({super.key});

  TextEditingController userName = TextEditingController();
  TextEditingController userID = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void login() async {
      await ZIMKit().connectUser(id: userID.text, name: userName.text);
      await ZIMKit().updateUserInfo(
          avatarUrl:
              "https://firebasestorage.googleapis.com/v0/b/crudtutorial-90500.appspot.com/o/black-coffee.png?alt=media&token=e63d8c88-94a3-4021-807d-10288c432fdf");
      ZegoUIKitPrebuiltCallInvitationService().init(
        notificationConfig: ZegoCallInvitationNotificationConfig(
          androidNotificationConfig: ZegoCallAndroidNotificationConfig(
            showFullScreen: true,
          ),
        ),
        // appID: 382666142
        appID: 303929327,
        appSign:
            // "66eb567f04dd67480c87f3967bdd971f96308e62ce70a14e3e3971674fd7a89e",
            "c66bfd5a6cc72b673497f8429a1ec0faaca26c9489571dafe8af3b8bfb1f811f",
        userID: userID.text,
        userName: userName.text,
        plugins: [ZegoUIKitSignalingPlugin()],
      );
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return ChatList();
        },
      ));
    }

    return Center(
      child: Container(
        height: 300,
        width: 300,
        child: Column(
          children: [
            TextFormField(
              controller: userName,
              decoration: InputDecoration(
                  label: Text("Username"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: userID,
              decoration: InputDecoration(
                  label: Text("User Id"), border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  login();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    foregroundColor: Colors.white,
                    textStyle: TextStyle(fontSize: 12)),
                child: Text("Login!")),
          ],
        ),
      ),
    );
  }
}
