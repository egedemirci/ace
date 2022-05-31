import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/user_interfaces/user_card.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';

class UserListView extends StatefulWidget {
  final List<dynamic> userIdList;
  final String title;
  final bool isNewChat;
  final FirebaseAnalytics analytics;

  const UserListView({Key? key, required this.userIdList, required this.title, required this.isNewChat, required this.analytics}) : super(key: key);

  @override
  State<UserListView> createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
  UserServices userService = UserServices();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return Container();
    }
    return Scaffold(
      backgroundColor: AppColors.profileScreenBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          width: screenWidth(context) * 0.6,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              widget.title,
              style: feedHeader,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.profileScreenBackgroundColor,
        foregroundColor: AppColors.profileScreenTextColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: userService.usersRef.snapshots().asBroadcastStream(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> querySnapshot){
            if(!querySnapshot.hasData){
              return const Center(child: CircularProgressIndicator());
            }
            else{
              List<dynamic> userList = querySnapshot.data!.docs
                  .where(
                      (QueryDocumentSnapshot<Object?> element) {
                    return ((widget.userIdList.contains(
                        element["userId"])) &&
                        !element["isDisabled"]);
                  }
              ).toList();

              return SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: List.from(userList
                          .map(
                              (myUser) =>
                              UserCard(
                                  user: MyUser.fromJson(myUser.data() as Map<String, dynamic>),
                                isNewChat: widget.isNewChat,
                                analytics: widget.analytics,
                              )
                      )
                          .toList()
                      ),
                    ),
                  ),
                ),
              );
            }
          }
      ),
    );
  }
}
