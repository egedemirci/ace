import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/templates/notif.dart';
import 'package:project_ace/templates/post.dart';

class UserServices {
  final CollectionReference usersRef =
      FirebaseFirestore.instance.collection('Users');

  final FirebaseStorage storage = FirebaseStorage.instance;

  Future addUser(String username, String fullName, String? userId) async {
    await usersRef.doc(userId).set({
      'username': username,
      'usernameLower': username.toLowerCase(),
      'userId': userId,
      'biography': '',
      'profilepicture':
          'https://firebasestorage.googleapis.com/v0/b/sucial-ff03d.appspot.com/o/user%2Fprofile%2FprofilePic%2Fnopp.png?alt=media&token=eaebea99-fc2d-4ede-893d-070e2d2595b0',
      'fullName': fullName,
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

  Future deleteUser(String userId) async {
    usersRef.doc(userId).delete();
  }

  /*Future deleteUserr(User user,String email, String password) async{
    String uid = user.uid;
    var result = await user.reauthenticateWithCredential(
        EmailAuthProvider.credential(email: email, password: password));
    await result.user!.delete();
    UserServices usersService = UserServices();
    usersService.deleteUser(uid);
  }*/

  Future<void> disableUser(String userId) async {
    await usersRef.doc(userId).update({'isDisabled': true});
    var docRef = await usersRef.doc(userId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    int i = 0;
    PostService postService = PostService();
    for (; i < posts.length; i++) {
      posts[i]["isDisabled"] = true;
      postService.disablePost(userId + posts[i]['postId'].toString());
    }
    usersRef.doc(userId).update({'posts': posts});
  }

  //Profile Picture Change
  Future getUserPp(String userId) async {
    var crrGet = await usersRef.doc(userId).get();
    return crrGet.get("profilepicture");
  }

  setProfilePic(String url, String userId) async {
    usersRef.doc(userId).update({
      'profilepicture': url,
    });
    var docRef = await usersRef.doc(userId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    int i = 0;
    for (; i < posts.length; i++) {
      posts[i]["urlAvatar"] = url;
    }
    usersRef.doc(userId).update({'posts': posts});
  }

  Future<String> uploadFile(User? user, File file) async {
    var storageRef =
        storage.ref().child("user/profile/profilePic/${user!.uid}");
    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> uploadProfilePicture(User? user, File image) async {
    String url = await uploadFile(user, image);
    setProfilePic(url, user!.uid);
  }

  Future enableUser(String userId) async {
    await usersRef.doc(userId).update({'isDisabled': false});
    var docRef = await usersRef.doc(userId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    int i = 0;
    PostService postService = PostService();
    for (; i < posts.length; i++) {
      posts[i]["isDisabled"] = false;
      postService.enablePost(userId + posts[i]['postId'].toString());
    }
    usersRef.doc(userId).update({'posts': posts});
  }

  Future<bool> doesUsernameExist(String username) async {
    final QuerySnapshot result =
        await usersRef.where('username', isEqualTo: username).limit(1).get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length == 1;
  }

  Future<String> getUsername(String userId) async {
    var docRef = await usersRef.doc(userId).get();
    var coll = docRef.data() as Map<String, dynamic>;
    var username = coll["username"];
    return username;
  }

  Future<bool> isUserFollow(String userId, String otherUserId) async {
    var docRef = await usersRef.doc(userId).get();
    var coll = docRef.data() as Map<String, dynamic>;
    var following = coll["following"];
    return following.contains(otherUserId);
  }

  Future<bool> hasFollower(String userId, String otherUserId) async {
    var docRef = await usersRef.doc(otherUserId).get();
    var coll = docRef.data() as Map<String, dynamic>;
    var following = coll["followers"];
    return following.contains(userId);
  }

  updatePrivacy(String userId, bool isPrivate) async {
    usersRef.doc(userId).update({"isPrivate": isPrivate});
  }

  Future<void> addBookmark(String userId, Post post) async {
    var docRef = await usersRef.doc(userId).get();
    var bookmarks = (docRef.data() as Map<String, dynamic>)["bookmarks"];
    bool isInBookmarks = false;
    if (bookmarks.length == 0) {
      bookmarks = bookmarks + [post.toJson()];
    } else {
      var theBookmark = bookmarks[0];
      for (var bookmark in bookmarks) {
        if (bookmark["postId"] == post.postId) {
          isInBookmarks = true;
          theBookmark = bookmark;
          break;
        }
      }
      if (isInBookmarks) {
        bookmarks.remove(theBookmark);
      } else {
        bookmarks = bookmarks + [post.toJson()];
      }
    }
    usersRef.doc(userId).update({"bookmarks": bookmarks});
  }

  editBio(String userId, String editedBio) async {
    await usersRef.doc(userId).update({"biography": editedBio});
  }

  getBio(String userId) async {
    var docRef = await usersRef.doc(userId).get();
    var coll = docRef.data() as Map<String, dynamic>;
    var bio = coll["biography"];
    return bio;
  }
  userFollow(String userToBeFollow, String mainUserId, bool isPrivate) async
  {
    if(isPrivate == true) {
      usersRef.doc(userToBeFollow).update(
          {
            "requests": FieldValue.arrayUnion([mainUserId]),
          }
      );
    }
    else{
      usersRef.doc(mainUserId).update(
          {
            "following": FieldValue.arrayUnion([userToBeFollow]),
          }
      );
      usersRef.doc(userToBeFollow).update(
          {
            "followers": FieldValue.arrayUnion([mainUserId]),
          }
      );
    }
  }
  unfollow(String userToBeFollow, String mainUserId) async
  {
      usersRef.doc(mainUserId).update(
          {
            "following": FieldValue.arrayRemove([userToBeFollow]),
          }
      );
      usersRef.doc(userToBeFollow).update(
          {
            "followers": FieldValue.arrayRemove([mainUserId]),
          }
      );
  }
  removeRequest(String userToBeFollow, String mainUserId) async
  {
    usersRef.doc(userToBeFollow).update(
        {
          "requests": FieldValue.arrayRemove([mainUserId]),
        }
    );
  }
  pushNotifications(String crrUserId, String otherUserId, String type) async
  {
    usersRef.doc(otherUserId).update(
        {
          "notifications": FieldValue.arrayUnion([
            AppNotification(
                notifType: type,
                subjectId: crrUserId,
                createdAt: DateTime.now()).toJson()
          ]),
          "isThereNewNotif": true
        }
    );
  }
}
