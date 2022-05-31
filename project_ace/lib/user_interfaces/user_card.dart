import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/chat.dart';
import 'package:project_ace/page_routes/profile_view.dart';
import 'package:project_ace/services/message_services.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';


class UserCard extends StatelessWidget {
  final MyUser user;
  final bool isNewChat;
  final FirebaseAnalytics analytics;
  const UserCard({Key? key, required this.user, required this.isNewChat, required this.analytics}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myUser = Provider.of<User?>(context);
    MessageService messageService = MessageService();
    if(!isNewChat) {
      return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView(userId: user.userId, analytics: analytics)));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: CircleAvatar(
                    backgroundColor: AppColors.welcomeScreenBackgroundColor,
                    radius: 32,
                    backgroundImage: (user.profilepicture != "default")
                        ? NetworkImage(user.profilepicture)
                        : const NetworkImage(
                        "https://minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg"),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                      child: Text(
                        user.fullName,
                        style: postCardUserRealName,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                      child: Text(
                        "@${user.username}",
                        style: postCardUserName,
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        );
    }
    else{
      return Row(
        children: [
          Container(
            width: screenWidth(context) * 0.65,
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileView(userId: user.userId, analytics: analytics)));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child: CircleAvatar(
                        backgroundColor: AppColors.welcomeScreenBackgroundColor,
                        radius: 32,
                        backgroundImage: (user.profilepicture != "default")
                            ? NetworkImage(user.profilepicture)
                            : const NetworkImage(
                            "https://minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg"),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 14, 0, 0),
                          child: Text(
                            user.fullName,
                            style: postCardUserRealName,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                          child: Text(
                            "@${user.username}",
                            style: postCardUserName,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.circular(10),
              color: AppColors
                  .profileSettingButtonFillColor,
            ),
            width: screenWidth(context) * 0.3,
            child: TextButton.icon(
              onPressed: () {
                messageService.createMessage(myUser!.uid, user.userId);
                String chatId = user.userId+myUser.uid;
                if(myUser.uid.compareTo(user.userId) < 0) {
                  chatId = myUser.uid + user.userId;
                }
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(chatId: chatId, otherUserId: user.userId, analytics: analytics,)));
              },
              icon: const Icon(
                Icons.mail_outline_rounded,
                color: AppColors
                    .profileSettingsButtonIconColor,
              ),
              label: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Message",
                  style:
                  profileViewProfileSettingsButton,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
