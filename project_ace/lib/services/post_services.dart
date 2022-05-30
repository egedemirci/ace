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
    postsRef.doc(userId + post.postId).set(post.toJson());
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
    postsRef.doc(userId + postId).update({'text': text});
  }

  Future<String> uploadPostPicture(User? user, File file, String postId) async {
    var storageRef = storage.ref().child("posts/${user!.uid}/$postId");
    var uploadTask = await storageRef.putFile(file);
    String downloadURL = await uploadTask.ref.getDownloadURL();
    return downloadURL;
  }

  deletePost(String userId, Map<String, dynamic> post) async {
    usersRef.doc(userId).update({
      "posts": FieldValue.arrayRemove([post])
    });
    postsRef.doc(userId + post["postId"]).delete();
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
      // TODO pushNotifications(userId, otherUserId, " liked your post.");
    } else {
      thePost["likes"].remove(userId);
      posts[i] = thePost;
      usersRef.doc(otherUserId).update({"posts": posts});
    }


    var docRefPost = await postsRef.doc(otherUserId + postId).get();
    if (!docRefPost["likes"].contains(userId)) {
      postsRef.doc(otherUserId + postId).update({
        "likes": FieldValue.arrayUnion([userId])
      });
    } else {
      postsRef.doc(otherUserId + postId).update({
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
      //TODO pushNotifications(userId, otherUserId, " disliked your post.");
    } else {
      thePost["dislikes"].remove(userId);
      posts[i] = thePost;
      usersRef.doc(otherUserId).update({"posts": posts});
    }
    var docRefPost = await postsRef.doc(otherUserId + postId).get();

    if (!docRefPost["dislikes"].contains(userId)) {
      postsRef.doc(otherUserId + postId).update({
        "dislikes": FieldValue.arrayUnion([userId])
      });
    } else {
      postsRef.doc(otherUserId + postId).update({
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
    postsRef.doc(otherUserId + postId).update({
      "comments": FieldValue.arrayUnion([
        {"senderId": userId, "context": context}
      ])
    });
    //TODO pushNotifications(userId, otherUserId, " commented on your post.");
  }

  Future<void> disablePost(String postId) async {
    postsRef.doc(postId).update({'isDisabled': true});
  }

  Future<void> enablePost(String postId) async {
    postsRef.doc(postId).update({'isDisabled': false});
  }
}
