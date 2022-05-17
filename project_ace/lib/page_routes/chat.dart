import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/own_profile_view.dart';
import 'package:project_ace/page_routes/search.dart';
import 'package:project_ace/templates/message.dart';
import 'package:project_ace/user_interfaces/message_card.dart';
import 'package:project_ace/utilities/styles.dart';

import '../templates/user.dart';
import '../utilities/colors.dart';
import 'add_post.dart';
import 'feed.dart';


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
      urlAvatar: "https://im.haberturk.com/2021/08/16/3163823_8a7125710e96a06ebd68e9fbe7509e39_640x640.jpg",
      message: "Hey Furkan, how you doing. Did you watch the court??",
      username: "johnnydepp",
      createdAt: DateTime.parse('2022-05-17 11:41:04Z'),
    ),
    Message(
      fullName: "me",
      idUser: "435e0648d634175c46bd40ac366545a8",
      urlAvatar: "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/4206da66a0e5deca9115d19a4bc0c63f.png",
      message: "Hi Johnny, I am great.",
      username: "userName",
      createdAt: DateTime.parse('2022-05-17 11:42:04Z'),
    ),
    Message(
      fullName: "me",
      idUser: "435e0648d634175c46bd40ac366545a8",
      urlAvatar: "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/4206da66a0e5deca9115d19a4bc0c63f.png",
      message: "Unfortunately yes. Is it true what Amber told the court?",
      username: "userName",
      createdAt: DateTime.parse('2022-05-17 11:43:04Z'),
    ),
    Message(
      fullName: "Johnny Depp",
      idUser: "119fa058e5b43d7955af3c6d58d43782",
      urlAvatar: "https://im.haberturk.com/2021/08/16/3163823_8a7125710e96a06ebd68e9fbe7509e39_640x640.jpg",
      message: "Some of them.",
      username: "johnnydepp",
      createdAt: DateTime.parse('2022-05-17 11:44:04Z'),
    ),
    Message(
      fullName: "Johnny Depp",
      idUser: "119fa058e5b43d7955af3c6d58d43782",
      urlAvatar: "https://im.haberturk.com/2021/08/16/3163823_8a7125710e96a06ebd68e9fbe7509e39_640x640.jpg",
      message: "But believe me she is an evil!!",
      username: "johnnydepp",
      createdAt: DateTime.parse('2022-05-17 11:44:04Z'),
    ),
    Message(
      fullName: "me",
      idUser: "435e0648d634175c46bd40ac366545a8",
      urlAvatar: "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/4206da66a0e5deca9115d19a4bc0c63f.png",
      message: "I know man",
      username: "userName",
      createdAt: DateTime.parse('2022-05-17 11:43:04Z'),
    ),
    Message(
      fullName: "me",
      idUser: "435e0648d634175c46bd40ac366545a8",
      urlAvatar: "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/4206da66a0e5deca9115d19a4bc0c63f.png",
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
        urlAvatar: "https://img.poki.com/cdn-cgi/image/quality=78,width=600,height=600,fit=cover,f=auto/4206da66a0e5deca9115d19a4bc0c63f.png",
        username: myUsername,
        message: message,
        createdAt: DateTime.now(),
      ));
      _controller.clear();
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.profileScreenTextColor,
        title: Row(
          children: [
            Text(
              '@$userNameChatted',
              style: userNameChatHeader
            ),
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
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [

                Column(
                  children: messages
                      .map((message) => MessageCard(
                    message: message,
                    isMe: message.username == myUsername,
                  ))
                      .toList(),
                ),
        Container(
          color: AppColors.profileScreenBackgroundColor,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
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
                  onChanged: (value) =>
                      setState(() {
                        message = value;
                      }),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: message.trim().isEmpty ? null : (){sendMessage(messages);},
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                  child: const Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
              ])
                ),
            ),
          ),
        );
  }
}

