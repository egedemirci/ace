import "package:flutter/material.dart";
import "package:project_ace/templates/notif.dart";
import 'package:project_ace/utilities/colors.dart';



class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  static const String routeName = '/notifications';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  //List<Notification> posts = [];
  List<oNotification> allNotifications = [
    oNotification(text: "started to follow you!", icon: Icon(Icons.person_add_alt_1_rounded), type: false , userName: "harrymaguire"),
    oNotification(text: "want to follow you!", icon: Icon(Icons.person_add_alt_1_rounded), type: true, userName: "taners"),
    oNotification(text: "liked your photo!", icon: Icon(Icons.favorite), type: false, userName: "afu"),
    oNotification(text: "started to follow you!", icon: Icon(Icons.person_add_alt_1_rounded), type: false, userName: "tuzun"),
    
  ];
  
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NOTIFICATIONS"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
              //mapping
              children: allNotifications.map((myNotification)  =>
                  Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.zero, bottom: Radius.circular(0))),
                    color: Colors.white,
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
                                padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: ClipOval(
                                    child: myNotification.icon
                                  ),
                                  radius: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                                child: Text(
                                  "@${myNotification.userName}" + " ",
                                  style: const TextStyle(fontSize: 15),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 1, 0, 0),
                                child: Column(
                                  children:[
                                      Text(
                                      myNotification.text,
                                      maxLines: 3,
                                      style: const TextStyle(fontSize: 15),
                                      overflow: TextOverflow.ellipsis,
                                    ),




                                  ]

                                ),
                              ),

                              const SizedBox(width: 6),


                            ],
                          ),
                          //print(myNotification.type);
                          //myNotification.type ? OutlinedButton(onPressed: (){}, child: Text("Accept!")):Text("a") ,
                          //OutlinedButton(onPressed: (){}, child: Text("Reject!")),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 56,),
                              Visibility(
                                child: OutlinedButton(onPressed: (){}, child: const Text("Accept!",style: TextStyle(fontSize: 13),),style: OutlinedButton.styleFrom(fixedSize: const Size(80, 10)),),
                                visible: myNotification.type,

                              ),
                              const SizedBox(width: 15,),
                              Visibility(
                                child: OutlinedButton(onPressed: (){}, child: const Text("Reject!",style: TextStyle(fontSize: 13)),style: OutlinedButton.styleFrom(fixedSize: const Size(80, 10)),),
                                visible: myNotification.type,

                              ),
                            ],
                          ),
                          //const SizedBox(width: 50,),

                          const Divider(
                              height: 10,
                              thickness: 0.5,
                              color: AppColors.welcomeScreenBackgroundColor),
                        ],
                      ),
                    ),
                  )
              ).toList(),




            ),
        ),
      ),
    );
  }
}
