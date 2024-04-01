import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocket_pal/src/screens/patient/chatCall/chat_interface.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_zimkit/zego_zimkit.dart';

class ChatList extends StatelessWidget {
  ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        // Logout chat service
        ZIM.getInstance()?.logout();
        // Logout call service
        ZegoUIKitPrebuiltCallInvitationService().uninit();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                // Logout chat service
                ZIM.getInstance()?.logout();
                // Logout call service
                ZegoUIKitPrebuiltCallInvitationService().uninit();
                Navigator.pop(context, true);
              }),
        ),
        body: ZIMKitConversationListView(
          onPressed: (context, conversation, defaultAction) {
            debugPrint(conversation.id);
            debugPrint(conversation.name);
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatInterface(
                    conversation: conversation,
                  ),
                ));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ZIMKit().showDefaultNewPeerChatDialog(context);
          },
          child: Icon(CupertinoIcons.chat_bubble_2_fill),
        ),
      ),
    );
  }
}
