import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/templates/chat_room.dart';
import 'package:project_ace/templates/message.dart';
import 'package:project_ace/user_interfaces/chat_card.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:project_ace/utilities/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.analytics, required this.chatRoom}) : super(key: key);

  final ChatRoom chatRoom;
  final FirebaseAnalytics analytics;
  static const String routeName = "/individualChat";

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //TODO Get messages in this chat room
  List<Message> messages = [];

  final _controller = TextEditingController();
  final ScrollController scrollController = ScrollController();
  String message = '';

  String myUsername = "userName";
  String userNameChatted = "johnnydepp";

  void sendMessage() async {
    setState(() {
      FocusScope.of(context).unfocus();
      //TODO Send message to firebase
      _controller.clear();
    });
  }

  _sendMessageArea() {
    return Container(
      color: AppColors.profileScreenBackgroundColor,
      height: screenHeight(context) * 0.110,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 500));
                _scrollDown();
              },
              controller: _controller,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Type your message',
                labelStyle: writeSomething,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0),
                  gapPadding: 10,
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              onChanged: (value) => setState(() {
                message = value;
              }),
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
              onPressed: message.trim().isEmpty
                  ? null
                  : () {
                      sendMessage();
                      message = "";
                      _scrollDown();
                    },
              icon: Container(
                  padding: const EdgeInsets.fromLTRB(6, 4, 8, 8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(Icons.send, color: Colors.white))),
        ],
      ),
    );
  }

  void _scrollDown() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Chat View", "chatView");
    String prevUserName = "";
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              }),
          foregroundColor: AppColors.profileScreenTextColor,
          title: Row(
            children: [
              SizedBox(
                  width: screenWidth(context) * 0.60,
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('@$userNameChatted',
                          style: userNameChatHeader))),
              const Spacer(),
              IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Navigator.pushNamed(context, '/notifications');
                },
                icon: const Icon(
                  Icons.notifications_active,
                  color: AppColors.bottomNavigationBarBackgroundColor,
                ),
              )
            ],
          ),
          centerTitle: true,
          backgroundColor: AppColors.profileScreenBackgroundColor,
          elevation: 0.0,
        ),
        backgroundColor: AppColors.profileScreenBackgroundColor,
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final Message _message = messages[index];
                  final bool isMe = _message.senderUsername == myUsername;
                  final bool isSameUser = prevUserName == _message.senderUsername;
                  prevUserName = _message.senderUsername;
                  return ChatCard(
                      message: _message, isMe: isMe, isSameUser: isSameUser);
                },
              ),
            ),
            _sendMessageArea()
          ],
        ));
  }
}
