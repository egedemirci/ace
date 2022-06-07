import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_ace/services/post_services.dart';
import 'package:project_ace/templates/notif.dart';

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
          'https://minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg',
      'fullName': fullName,
      'followers': [],
      'subscribedTopics': [],
      'following': [],
      'posts': [],
      'requests': [],
      'isPrivate': false,
      'notifications': [],
      'isThereNewNotif': false,
      'isDisabled': false,
      'bookmarks': []
    });
  }

  Future deleteUser(String userId) async {
    usersRef.doc(userId).delete();
  }

  Future<void> disableUser(String userId) async {
    await usersRef.doc(userId).update({'isDisabled': true});
    var docRef = await usersRef.doc(userId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    int i = 0;
    PostServices postService = PostServices();
    for (; i < posts.length; i++) {
      posts[i]["isDisabled"] = true;
      postService.disablePost(userId + posts[i]['postId'].toString());
    }
    usersRef.doc(userId).update({'posts': posts});
  }

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
    PostServices postService = PostServices();
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

  updatePrivacy(String userId, bool isPrivate) async {
    usersRef.doc(userId).update({"isPrivate": isPrivate});
  }

  Future<bool> getPrivacy(String userId) async {
    var docRef = await usersRef.doc(userId).get();
    var coll = docRef.data() as Map<String, dynamic>;
    bool privacy = coll["isPrivate"];
    return privacy;
  }

  Future<bool> getDisabled(String userId) async {
    var docRef = await usersRef.doc(userId).get();
    var coll = docRef.data() as Map<String, dynamic>;
    bool isDisabled = coll["isDisabled"];
    return isDisabled;
  }

  Future<void> addBookmark(String userId, String postId) async {
    var docRef = await usersRef.doc(userId).get();
    var bookmarks = (docRef.data() as Map<String, dynamic>)["bookmarks"];
    bool isInBookmarks = false;
    if (bookmarks.length == 0) {
      bookmarks = bookmarks + [postId];
    } else {
      var theBookmark = bookmarks[0];
      for (var pid in bookmarks) {
        if (pid == postId) {
          isInBookmarks = true;
          theBookmark = pid;
          break;
        }
      }
      if (isInBookmarks) {
        bookmarks.remove(theBookmark);
      } else {
        bookmarks = bookmarks + [postId];
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

  userFollow(String userToBeFollow, String mainUserId, bool isPrivate) async {
    if (isPrivate == true) {
      usersRef.doc(userToBeFollow).update({
        "requests": FieldValue.arrayUnion([mainUserId]),
      });
      pushNotifications(mainUserId, userToBeFollow, "followRequest");
    } else {
      usersRef.doc(mainUserId).update({
        "following": FieldValue.arrayUnion([userToBeFollow]),
      });
      usersRef.doc(userToBeFollow).update({
        "followers": FieldValue.arrayUnion([mainUserId]),
      });
      pushNotifications(userToBeFollow, mainUserId, "followedYou");
    }
  }

  unfollow(String userToBeFollow, String mainUserId) async {
    usersRef.doc(mainUserId).update({
      "following": FieldValue.arrayRemove([userToBeFollow]),
    });
    usersRef.doc(userToBeFollow).update({
      "followers": FieldValue.arrayRemove([mainUserId]),
    });
  }

  removeRequest(String userToBeFollow, String mainUserId) async {
    var docRef = await usersRef.doc(userToBeFollow).get();
    var notifications =
        (docRef.data() as Map<String, dynamic>)["notifications"];
    var theNotif = notifications[0];
    int i = 0;
    for (; i < notifications.length; i++) {
      if ((notifications[i]["notifType"] == "followRequest") &&
          (notifications[i]["subjectId"] == mainUserId)) {
        theNotif = notifications[i];
        break;
      }
    }
    usersRef.doc(userToBeFollow).update({
      "requests": FieldValue.arrayRemove([mainUserId]),
      "notifications": FieldValue.arrayRemove([theNotif])
    });
  }

  pushNotifications(String crrUserId, String otherUserId, String type) async {
    usersRef.doc(otherUserId).update({
      "notifications": FieldValue.arrayUnion([
        AppNotification(
                notifType: type,
                subjectId: crrUserId,
                createdAt: DateTime.now())
            .toJson()
      ]),
      "isThereNewNotif": true
    });
  }

  getRecommendations(String userId) async {
    var docRef = await usersRef.doc(userId).get();
    var followings = await (docRef.data() as Map<String, dynamic>)["following"];
    List<dynamic> recommendations = [];
    for (var following in followings) {
      var doc = await usersRef.doc(following).get();
      var followingsFollowing =
          await (doc.data() as Map<String, dynamic>)["following"];
      for (var temp in followingsFollowing) {
        if (!followings.contains(temp) &&
            !recommendations.contains(temp) &&
            temp != userId) {
          recommendations.add(temp);
        }
      }
    }
    return recommendations;
  }

  updateLocation(String userId, double lat, double lon) async {
    usersRef.doc(userId).update({"geoLocation": GeoPoint(lat, lon)});
  }

  Future<bool> isUsernameExist(String username) async {
    final QuerySnapshot users =
        await usersRef.where('username', isEqualTo: username).limit(1).get();
    final List<DocumentSnapshot> documents = users.docs;
    return documents.length == 1;
  }
}
