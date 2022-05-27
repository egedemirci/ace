import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('Users');

  Future addUser(String username, String? userId) async {
    await users.doc(userId).set({
      'username': username,
      'usernameLower': username.toLowerCase(),
      'userId': userId,
      'biography': '',
      'profilepicture':
          'https://firebasestorage.googleapis.com/v0/b/sucial-ff03d.appspot.com/o/user%2Fprofile%2FprofilePic%2Fnopp.png?alt=media&token=eaebea99-fc2d-4ede-893d-070e2d2595b0',
      'fullName': 'unknown',
      'isSignupDone': false,
      'followers': [],
      'subscribedTopic': [],
      'following': [],
      'posts': [],
      'requests': [],
      'isPrivate': false,
      'notifications': [],
      'isThereNewNotif': false,
      'isDisabled': false,
      'postCount': 0,
      'bookmarks': []
    });
  }
}
