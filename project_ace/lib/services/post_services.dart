import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/post.dart';

class PostService {
  final CollectionReference postsRef =
      FirebaseFirestore.instance.collection('Posts');
  final CollectionReference usersRef = UserServices().usersRef;
  final FirebaseStorage storage = FirebaseStorage.instance;

  createPost(String userId, Post post) async {
    usersRef.doc(userId).update({
      'posts': FieldValue.arrayUnion([post.toJson()]),
      'postCount': FieldValue.increment(1),
    });
    postsRef.doc(post.postId).set(post.toJson());
  }

  Future<void> editPost(String userId, String postId, String text) async {
    var docRef = await usersRef.doc(userId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for (; i < posts.length; i++) {
      if (postId == posts[i]["postId"]) {
        thePost = posts[i];
        break;
      }
    }
    thePost["text"] = text;
    posts[i] = thePost;
    usersRef.doc(userId).update({'posts': posts});
    postsRef.doc(postId).update({'text': text});
  }

  Future<String> uploadPostPicture(User? user, File file, String postId) async {
    var storageRef = storage.ref().child("posts/${user!.uid}/$postId");
    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> uploadPostVideo(User? user, File file, String postId) async {
    var storageRef = storage.ref().child("posts/${user!.uid}/$postId");
    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }


  deletePost(String userId, Map<String, dynamic> post) async {
    var docRef = await usersRef.doc(userId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for (; i < posts.length; i++) {
      if (post["postId"] == posts[i]["postId"]) {
        thePost = posts[i];
        break;
      }
    }
    await usersRef.doc(userId).update({
      "posts": FieldValue.arrayRemove([thePost])
    });
    await postsRef.doc(post["postId"].toString()).delete();
    //posts.doc(userId + post["postId"].toString()).delete();
  }

  likePost(String userId, String otherUserId, String postId) async {
    var docRef = await usersRef.doc(otherUserId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for (; i < posts.length; i++) {
      if (postId == posts[i]["postId"]) {
        thePost = posts[i];
        break;
      }
    }
    if (!thePost["likes"].contains(userId)) {
      thePost["likes"] = thePost["likes"] + [userId];
      posts[i] = thePost;
      usersRef.doc(otherUserId).update({"posts": posts});
      UserServices().pushNotifications(userId, otherUserId, "likedPost");
    } else {
      thePost["likes"].remove(userId);
      posts[i] = thePost;
      usersRef.doc(otherUserId).update({"posts": posts});
    }
    var docRefPost = await postsRef.doc(postId).get();
    if (!docRefPost["likes"].contains(userId)) {
      postsRef.doc(postId).update({
        "likes": FieldValue.arrayUnion([userId])
      });
    } else {
      postsRef.doc(postId).update({
        "likes": FieldValue.arrayRemove([userId])
      });
    }
  }

  dislikePost(String userId, String otherUserId, String postId) async {
    var docRef = await usersRef.doc(otherUserId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for (; i < posts.length; i++) {
      if (postId == posts[i]["postId"]) {
        thePost = posts[i];
        break;
      }
    }
    if (!thePost["dislikes"].contains(userId)) {
      thePost["dislikes"] = thePost["dislikes"] + [userId];
      posts[i] = thePost;
      usersRef.doc(otherUserId).update({"posts": posts});
      //TODO await UserServices().pushNotifications(userId, otherUserId, "dislikedPost");
    } else {
      thePost["dislikes"].remove(userId);
      posts[i] = thePost;
      usersRef.doc(otherUserId).update({"posts": posts});
    }
    var docRefPost = await postsRef.doc(postId).get();

    if (!docRefPost["dislikes"].contains(userId)) {
      postsRef.doc(postId).update({
        "dislikes": FieldValue.arrayUnion([userId])
      });
    } else {
      postsRef.doc(postId).update({
        "dislikes": FieldValue.arrayRemove([userId])
      });
    }
  }

  Future<void> sendCommendTo(
      String userId, String otherUserId, String postId, String context) async {
    var docRef = await usersRef.doc(otherUserId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for (; i < posts.length; i++) {
      if (postId == posts[i]["postId"]) {
        thePost = posts[i];
        break;
      }
    }
    thePost["comments"] = thePost["comments"] +
        [
          {"senderId": userId, "context": context}
        ];
    posts[i] = thePost;
    usersRef.doc(otherUserId).update({"posts": posts});
    postsRef.doc(postId).update({
      "comments": FieldValue.arrayUnion([
        {"senderId": userId, "context": context}
      ])
    });
    UserServices().pushNotifications(userId, otherUserId, "commentedToPost");

  }

  Future<void> disablePost(String postId) async {
    postsRef.doc(postId).update({'isDisabled': true});
  }

  Future<void> enablePost(String postId) async {
    postsRef.doc(postId).update({'isDisabled': false});
  }
}
