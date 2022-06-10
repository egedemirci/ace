import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/comment.dart';
import 'package:project_ace/templates/post.dart';
import 'package:project_ace/templates/topic.dart';

class PostServices {
  final CollectionReference postsRef =
      FirebaseFirestore.instance.collection('Posts');
  final CollectionReference usersRef = UserServices().usersRef;
  final CollectionReference topicsRef =
      FirebaseFirestore.instance.collection('Topics');
  final FirebaseStorage storage = FirebaseStorage.instance;

  createPost(String userId, Post post) async {
    usersRef.doc(userId).update({
      'posts': FieldValue.arrayUnion([post.toJson()])
    });
    postsRef.doc(post.postId).set(post.toJson());
    if (post.topic.isNotEmpty) {
      var docRef = await topicsRef.doc(post.topic).get();
      if (docRef.data() != null) {
        topicsRef.doc(post.topic).update({
          "postIdList": FieldValue.arrayUnion([post.postId])
        });
      } else {
        Topic myTopic = Topic(text: post.topic, postIdList: [post.postId]);
        topicsRef.doc(post.topic).set(myTopic.toJson());
      }
    }
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
      String userId, String otherUserId, String postId, Comment comment) async {
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
    thePost["comments"] = thePost["comments"] + [comment.toJson()];
    posts[i] = thePost;
    usersRef.doc(otherUserId).update({"posts": posts});
    postsRef.doc(postId).update({
      "comments": FieldValue.arrayUnion([comment.toJson()])
    });
    UserServices().pushNotifications(userId, otherUserId, "commentedToPost");
  }

  Future<void> disablePost(String postId) async {
    postsRef.doc(postId).update({'isDisabled': true});
  }

  Future<void> enablePost(String postId) async {
    postsRef.doc(postId).update({'isDisabled': false});
  }

  reSharePost(String userId, Post post) async {
    var docRef = await usersRef.doc(userId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    bool isReshared = false;
    int i = 0;
    for (; i < posts.length; i++) {
      if (post.postId == posts[i]["postId"]) {
        thePost = posts[i];
        isReshared = true;
        break;
      }
    }
    Post newPost = Post(
        postId: userId + (posts.length + 1).toString(),
        userId: userId,
        assetUrl: post.assetUrl,
        text: post.text,
        mediaType: post.mediaType,
        createdAt: DateTime.now(),
        username: post.username,
        topic: post.topic,
        urlAvatar: post.urlAvatar,
        fullName: post.fullName,
        fromWho: post.userId,
        isShared: true);
    if (isReshared) {
      await usersRef.doc(userId).update({
        "posts": FieldValue.arrayRemove([thePost])
      });
    } else {
      await usersRef.doc(userId).update({
        'posts': FieldValue.arrayUnion([newPost.toJson()])
      });
      await postsRef.doc(newPost.postId).set(newPost.toJson());
    }
  }
}
