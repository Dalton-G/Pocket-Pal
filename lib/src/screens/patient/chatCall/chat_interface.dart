import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatInterface extends StatelessWidget {
  final ZIMKitConversation conversation;

  const ChatInterface({super.key, required this.conversation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return ZIMKitMessageListPage(
            conversationID: conversation.id,
            appBarBuilder: (context, defaultAppBar) {
              return AppBar(
                foregroundColor: Colors.white,
                title: ValueListenableBuilder<ZIMKitConversation>(
                  valueListenable: ZIMKit().getConversation(
                    conversation.id,
                    ZIMConversationType.peer,
                  ),
                  builder: (context, conversation, child) {
                    const avatarNameFontSize = 16.0;
                    return Row(
                      children: [
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          // TODO: Add profile picture
                          child: conversation.icon,
                        ),
                        child!,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              conversation.name,
                              style: const TextStyle(
                                fontSize: avatarNameFontSize,
                              ),
                              overflow: TextOverflow.clip,
                            ),
                            // Text(conversation.id,
                            //     style: const TextStyle(fontSize: 12),
                            //     overflow: TextOverflow.clip)
                          ],
                        )
                      ],
                    );
                  },
                  child: const SizedBox(width: 20 * 0.75),
                ),
                actions: [
                  IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () {},
                  ),
                  // IconButton(
                  //     icon: Icon(Icons.video_camera_back),
                  //     onPressed: () {}),
                  ZegoSendCallInvitationButton(
                    icon: ButtonIcon(icon: Icon(Icons.video_camera_back)),
                    verticalLayout: false,
                    margin: EdgeInsets.only(right: 10),
                    iconSize: Size.square(40),
                    iconTextSpacing: 0,
                    isVideoCall: true,
                    resourceID: "zegouikit_call",
                    buttonSize: Size.square(40),
                    //You need to use the resourceID that you created in the subsequent steps. Please continue reading this document.
                    invitees: [
                      ZegoUIKitUser(
                        id: conversation.id,
                        name: conversation.name,
                      ),
                    ],
                  )
                ],
                backgroundColor: Colors.green,
                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back),
                    );
                  },
                ),
              );
            },
            theme: ThemeData(
              primaryColor: Colors.green,
              fontFamily: "Overpass",
            ),
            // appBarActions: [
            //   IconButton(
            //       icon: const Icon(Icons.local_phone), onPressed: () {}),
            //   IconButton(
            //       icon: const Icon(Icons.videocam), onPressed: () {}),
            // ],
          );
        },
      ),
    );
  }
}
