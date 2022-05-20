import 'package:flutter/material.dart';
import 'package:project_ace/templates/message.dart';
import 'package:project_ace/user_interfaces/chat_card.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';

import 'package:project_ace/utilities/colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  static const String routeName = "/individualChat";
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [
    Message(
      fullName: "Johnny Depp",
      idUser: "119fa058e5b43d7955af3c6d58d43782",
      urlAvatar:
          "https://im.haberturk.com/2021/08/16/3163823_8a7125710e96a06ebd68e9fbe7509e39_640x640.jpg",
      message: "Hey Furkan, how you doing. Did you watch the court??",
      username: "johnnydepp",
      createdAt: DateTime.parse('2022-05-17 11:41:04Z'),
    ),
    Message(
      fullName: "me",
      idUser: "435e0648d634175c46bd40ac366545a8",
      urlAvatar:
          "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/4206da66a0e5deca9115d19a4bc0c63f.png",
      message: "Hi Johnny, I am great.",
      username: "userName",
      createdAt: DateTime.parse('2022-05-17 11:42:04Z'),
    ),
    Message(
      fullName: "me",
      idUser: "435e0648d634175c46bd40ac366545a8",
      urlAvatar:
          "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/4206da66a0e5deca9115d19a4bc0c63f.png",
      message: "Unfortunately yes. Is it true what Amber told the court?",
      username: "userName",
      createdAt: DateTime.parse('2022-05-17 11:43:04Z'),
    ),
    Message(
      fullName: "Johnny Depp",
      idUser: "119fa058e5b43d7955af3c6d58d43782",
      urlAvatar:
          "https://im.haberturk.com/2021/08/16/3163823_8a7125710e96a06ebd68e9fbe7509e39_640x640.jpg",
      message: "Some of them.",
      username: "johnnydepp",
      createdAt: DateTime.parse('2022-05-17 11:44:04Z'),
    ),
    Message(
      fullName: "Johnny Depp",
      idUser: "119fa058e5b43d7955af3c6d58d43782",
      urlAvatar:
          "https://im.haberturk.com/2021/08/16/3163823_8a7125710e96a06ebd68e9fbe7509e39_640x640.jpg",
      message: "But believe me she is an evil!!",
      username: "johnnydepp",
      createdAt: DateTime.parse('2022-05-17 11:44:04Z'),
    ),
    Message(
      fullName: "Johnny Depp",
      idUser: "119fa058e5b43d7955af3c6d58d43782",
      urlAvatar:
      "https://im.haberturk.com/2021/08/16/3163823_8a7125710e96a06ebd68e9fbe7509e39_640x640.jpg",
      message: "She made me suffer so many bad things that I couldn't even explain in court.",
      username: "johnnydepp",
      createdAt: DateTime.parse('2022-05-17 11:44:04Z'),
    ),
    Message(
      fullName: "me",
      idUser: "435e0648d634175c46bd40ac366545a8",
      urlAvatar:
          "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/4206da66a0e5deca9115d19a4bc0c63f.png",
      message: "I know man",
      username: "userName",
      createdAt: DateTime.parse('2022-05-17 11:43:04Z'),
    ),
    Message(
      fullName: "me",
      idUser: "435e0648d634175c46bd40ac366545a8",
      urlAvatar:
          "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/4206da66a0e5deca9115d19a4bc0c63f.png",
      message: "Take care",
      username: "userName",
      createdAt: DateTime.parse('2022-05-17 11:43:04Z'),
    ),
  ];

  final _controller = TextEditingController();
  String message = '';

  String myUsername = "userName";
  String userNameChatted = "johnnydepp";

  void sendMessage(List<Message> listMessages) async {
    setState(() {
      FocusScope.of(context).unfocus();
      listMessages.add(Message(
        fullName: "me",
        idUser: "435e0648d634175c46bd40ac366545a8",
        urlAvatar:
            "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/4206da66a0e5deca9115d19a4bc0c63f.png",
        username: myUsername,
        message: message,
        createdAt: DateTime.now(),
      ));
      _controller.clear();
    });
  }

  _sendMessageArea(){
    return Container(
      color: AppColors.profileScreenBackgroundColor,
      height: screenHeight(context)*0.110,
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
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
              onPressed: message.trim().isEmpty ? null : () {
                sendMessage(messages);},
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
    String prevUserName = "";
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.profileScreenTextColor,
        title: Row(
          children: [
            SizedBox(width: screenWidth(context)*0.60,child: FittedBox(fit: BoxFit.scaleDown ,child: Text('@$userNameChatted', style: userNameChatHeader))),
            const Spacer(),
            IconButton(
              onPressed: () {
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
              padding: const EdgeInsets.all(20),
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index){
                final Message _message = messages[index];
                final bool isMe = _message.username == myUsername;
                final bool isSameUser = prevUserName == _message.username;
                prevUserName = _message.username;
                return ChatCard(message: _message, isMe: isMe, isSameUser: isSameUser);
              },
            ),
          ),
          _sendMessageArea()
        ],
      )

    );
  }
}
