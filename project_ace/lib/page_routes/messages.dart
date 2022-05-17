import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/styles.dart';
import "package:project_ace/templates/message.dart";

import 'add_post.dart';
import 'feed.dart';
import 'own_profile_view.dart';



class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);
  static const String routeName = '/messages';

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<Message> allMessages = [
    Message(
        text: "Duis ultricies velit ut justo egestas, quis maximus nibh ultrices. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean non porta urna. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nullam et nisi quis neque elementum cursus eget eget metus. Duis sodales, enim ut finibus.",
        fullName: "Furkan Un",
        profilePicture: Image.network("https://www.mockofun.com/wp-content/uploads/2019/12/circle-photo.jpg"),
        userName: "fun"),
    Message(
        text: "Morbi placerat laoreet magna, at feugiat elit tempor eu. Duis ut mattis nisi. Donec commodo purus at mollis lacinia. Proin porttitor congue ipsum eu finibus.",
        fullName: "Efe Tuzun",
        profilePicture: Image.network("https://www.mockofun.com/wp-content/uploads/2019/12/circle-photo.jpg"),
        userName: "tuzun"),
    Message(
        text: "Arcu luctus eget. Nullam vitae blandit ipsum, vel tristique est. Maecenas pharetra orci sed convallis aliquam. Duis laoreet aliquam sagittis. Nunc vel lectus placerat, accumsan nibh sed, pretium justo.",
        fullName: "Taner Sonmez",
        profilePicture: Image.network("https://www.mockofun.com/wp-content/uploads/2019/12/circle-photo.jpg"),
        userName: "taners"),
    Message(
    text: "Praesent cursus nulla a mi eleifend, quis ornare enim semper. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
    fullName: "Ege Demirci",
    profilePicture: Image.network("https://www.mockofun.com/wp-content/uploads/2019/12/circle-photo.jpg"),
    userName: "ege.demirci"),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.profileScreenBackgroundColor,
      bottomNavigationBar: BottomAppBar(
        color: AppColors.welcomeScreenBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  tooltip: "Messages",
                  iconSize: 40,
                  icon: const Icon(
                    Icons.email,
                    color: AppColors.userNameColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, MessageScreen.routeName);
                  }),
              const Spacer(),
              IconButton(
                  tooltip: "Search",
                  iconSize: 40,
                  icon: const Icon(
                    Icons.search,
                    color: AppColors.userNameColor,
                  ),
                  onPressed: () {
                    // Navigator.push(context, Search.routeName);
                  }),
              const Spacer(),
              IconButton(
                  tooltip: "Home",
                  iconSize: 40,
                  icon: const Icon(
                    Icons.home,
                    color: AppColors.userNameColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Feed.routeName, (route) => false);
                  }),
              const Spacer(),
              IconButton(
                  tooltip: "Add Post",
                  iconSize: 40,
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: AppColors.userNameColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AddPost.routeName);
                  }),
              const Spacer(),
              IconButton(
                  tooltip: "Profile",
                  iconSize: 40,
                  icon: const Icon(
                    Icons.person_outline,
                    color: AppColors.userNameColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, OwnProfileView.routeName, (route) => false);
                  }),
            ],
          ),
        ),
      ),
      appBar:AppBar(
        elevation: 0,
        foregroundColor: AppColors.profileScreenTextColor,
        backgroundColor: AppColors.profileScreenBackgroundColor,
        title: Row(
          children:[
            const Spacer(),
            Text(
              "Messages",
              style: Styles.messageHeader ,
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
            ),
          ] ,
        ),
        centerTitle: true,

      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: allMessages
                .map((myMessage) => Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.zero, bottom: Radius.circular(0))),
              color: AppColors.profileScreenBackgroundColor,
              elevation: 0,
              child: Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //photo
                  CircleAvatar(
                    foregroundColor:
                    AppColors.notificationIconColor,
                    backgroundColor:
                    AppColors.profileScreenBackgroundColor,
                    child: ClipOval(child: myMessage.profilePicture ),
                    radius: 50,
                  ),


                  //text ve name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [

                            Text(
                              "${myMessage.fullName} ",
                              style: Styles.messageUserRealName,
                            ),
                            const SizedBox(width: 5,),
                            Text(
                              "@${myMessage.userName} ",
                              style: Styles.messageUserName,
                            ),

                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "${"Hi, how are u? i hope you are fine."} ",
                          style: Styles.messageText,
                        ),

                      ),

                      Container(
                        padding: const  EdgeInsets.fromLTRB(0, 30 , 0, 0),
                        width: MediaQuery.of(context).size.width/1.5,
                        height: 20,
                        child: Divider(
                          thickness: 1.0,
                          color: AppColors.notificationIconColor,
                        ),
                      ),






                      /*
                      SizedBox(height: 80,),
                      const Divider(
                          height: 10,
                          thickness: 1.5,
                          color: AppColors.notificationIconColor),
                      */
                    ],

                  ),

                ],

              ),

            ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
/*
SingleChildScrollView(
        child: SafeArea(
          child: Column(
            //mapping
            children: allMessages
                .map((myNotification) => Card(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.zero, bottom: Radius.circular(0))),
              color: AppColors.profileScreenBackgroundColor,
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(4, 0, 8, 0),
                          child: CircleAvatar(
                            foregroundColor:
                            AppColors.notificationIconColor,
                            backgroundColor:
                            AppColors.profileScreenBackgroundColor,
                            child: ClipOval(child: myNotification.profilePicture),
                            radius: 30,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(0, 1, 0, 0),
                          child: Text(
                            "@${myNotification.userName} ",
                            style: GoogleFonts.montserrat(
                              color: AppColors.notificationIconColor,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.fromLTRB(0, 1, 0, 0),
                          child: Column(children: [
                            Text(
                              myNotification.text,
                              maxLines: 3,
                              style: GoogleFonts.montserrat(
                                color: AppColors.notificationIconColor,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ]),
                        ),
                        const SizedBox(width: 6),
                      ],
                    ),
                    //print(myNotification.type);
                    //myNotification.type ? OutlinedButton(onPressed: (){}, child: Text("Accept!")):Text("a") ,
                    //OutlinedButton(onPressed: (){}, child: Text("Reject!")),


                    //const SizedBox(width: 50,),
                    const Divider(
                        height: 10,
                        thickness: 1.5,
                        color: AppColors.notificationIconColor),
                  ],
                ),
              ),
            ))
                .toList(),
          ),
        ),
      ),
 */
