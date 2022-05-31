import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/message_services.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/chat_room.dart';
import 'package:project_ace/templates/message.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/user_interfaces/chat_card.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(
      {Key? key,
      required this.chatId,
      required this.otherUserId,
      required this.analytics})
      : super(key: key);
  final String chatId;
  final String otherUserId;
  final FirebaseAnalytics analytics;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();
  MessageService messageService = MessageService();
  UserServices userService = UserServices();

  String message = '';
  String otherUsername = " ";
  String otherUserpp= " ";

  Future getUserName() async {
    final uname =
    await userService.getUsername(widget.otherUserId);
    setState(() {
      otherUsername = "@$uname";
    });
  }

  Future getUserPP() async {
    final upp =
    await userService.getUserPp(widget.otherUserId);
    setState(() {
      otherUserpp = upp;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
    getUserPP();
  }

  sendMessage(chatId, text, senderUsername, senderAvatar) {
    messageService.sendMessage(chatId, text, senderUsername, senderAvatar);
    _controller.clear();
  }

  _sendMessageArea(chatId, senderUsername, senderAvatar) {
    return Container(
      color: AppColors.profileScreenBackgroundColor,
      height: screenHeight(context) * 0.110,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              //onTap: () async {
               // await Future.delayed(const Duration(milliseconds: 500));
               // _scrollDown();
             // },
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
              onChanged: (value) {setState((){
                message = value;
              });}
            ),
          ),
          SizedBox(width: screenWidth(context) * 0.048),
          IconButton(
              onPressed: message.trim().isEmpty
                  ? null
                  : () {
                sendMessage(chatId, message, senderUsername, senderAvatar);
                message = "";
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



  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Chat View", "chat.dart");
    String prevUserName = "";
    final user = Provider.of<User?>(context);
    setUserId(widget.analytics, user!.uid);
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
                      child: Text(otherUsername,
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
        body: StreamBuilder(
          stream:
              messageService.chatRoomReference.doc(widget.chatId).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Oops, something went wrong"));
            }
            if(snapshot.hasData && snapshot.data != null && snapshot.data!.data() != null){
              List<dynamic> messages = (snapshot.data!.data() as Map<String, dynamic>)["texts"];
                return FutureBuilder<DocumentSnapshot>(
                    future: userService.usersRef.doc(user.uid).get(),
                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> querySnapshot){
                      if(!querySnapshot.hasData){
                        return const Center(child: CircularProgressIndicator());
                      }
                      else {
                        MyUser myUser = MyUser.fromJson(
                            (querySnapshot.data!.data() ??
                                Map<String, dynamic>.identity()) as Map<
                                String,
                                dynamic>);
                        if (myUser.isDisabled == true) {
                          return const Center(
                              child: Text("Your account is not active."));
                        }
                        else {
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  reverse: true,
                                  keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.all(20),
                                  itemCount: messages.length,
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    Message message = Message.fromJson(
                                        messages.reversed.toList()[index]);
                                    final bool isMe = message.senderUsername ==
                                        myUser.username;
                                    final bool isSameUser = prevUserName ==
                                        message.senderUsername;
                                    prevUserName = message.senderUsername;
                                    return ChatCard(
                                      urlAvatar: otherUserpp,
                                        message: message,
                                        isMe: isMe,
                                        isSameUser: isSameUser);
                                  },
                                ),
                              ),
                            _sendMessageArea(widget.chatId, myUser.username,
                                myUser.profilepicture)
                          ],
                        );
                      }
                    }
                  });
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
