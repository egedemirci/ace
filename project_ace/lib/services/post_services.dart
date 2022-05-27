import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/templates/post.dart';

class PostService{
  final CollectionReference postsRef = FirebaseFirestore.instance.collection('Posts');
  final CollectionReference usersRef = UserServices().usersRef;
/*
  createPost(String userId, Post post) async
  {
    usersRef.doc(userId).update(
        {
          'posts': FieldValue.arrayUnion([post.toJson()]),
          'postCount': FieldValue.increment(1),
        }
    );

    postsRef.doc(userId + post.postId.toString()).set(
        post.toJson()
    );

  }
*/
  Future<void> editPost(String userId, int postId, String text) async
  {
    var docRef = await usersRef.doc(userId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for(; i < posts.length ; i++)
    {
      if(postId == posts[i]["postId"])
      {
        thePost = posts[i];
        break;
      }
    }
    thePost["text"] = text;
    posts[i] = thePost;
    usersRef.doc(userId).update(
        {
          'posts': posts
        }
    );
    postsRef.doc(userId + postId.toString()).update({
      'text': text
    });
  }

  deletePost(String userId, Map<String, dynamic> post) async{
    usersRef.doc(userId).update({
      "posts": FieldValue.arrayRemove([post])
    });
    postsRef.doc(userId + post["postId"].toString()).delete();
  }

  likePost(String userId, String otherUserId, int postId) async
  {
    var docRef = await usersRef.doc(otherUserId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for(; i < posts.length ; i++)
    {
      if(postId == posts[i]["postId"])
      {
        thePost = posts[i];
        break;
      }
    }
    if(!thePost["likes"].contains(userId)) {
      thePost["likes"] = thePost["likes"] + [userId];
      posts[i] = thePost;
      usersRef.doc(otherUserId).update({
        "posts": posts
      });
      // TODO pushNotifications(userId, otherUserId, " liked your post.");
    }
    else{
      thePost["likes"].remove(userId);
      posts[i] = thePost;
      usersRef.doc(otherUserId).update({
        "posts": posts
      });
    }
    PostService postService = PostService();
    postService.likePost(userId, otherUserId, postId);

    var docRefPost = await postsRef.doc(otherUserId+ postId.toString()).get() ;

    if(!docRefPost["likes"].contains(userId)) {
      postsRef.doc(otherUserId+ postId.toString()).update({
        "likes": FieldValue.arrayUnion([userId])
      });

    }
    else{
      postsRef.doc(otherUserId+ postId.toString()).update({
        "likes": FieldValue.arrayRemove([userId])
      });
    }
  }
  dislikePost(String userId, String otherUserId, int postId) async
  {
    var docRef = await usersRef.doc(otherUserId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for(; i < posts.length ; i++)
    {
      if(postId == posts[i]["postId"])
      {
        thePost = posts[i];
        break;
      }
    }
    if(!thePost["dislikes"].contains(userId)) {
      thePost["dislikes"] = thePost["dislikes"] + [userId];
      posts[i] = thePost;
      usersRef.doc(otherUserId).update({
        "posts": posts
      });
      //TODO pushNotifications(userId, otherUserId, " disliked your post.");

    }
    else{
      thePost["dislikes"].remove(userId);
      posts[i] = thePost;
      usersRef.doc(otherUserId).update({
        "posts": posts
      });
    }
    var docRefPost = await postsRef.doc(otherUserId+ postId.toString()).get();

    if(!docRefPost["dislikes"].contains(userId)) {
      postsRef.doc(otherUserId+ postId.toString()).update({
        "dislikes": FieldValue.arrayUnion([userId])
      });
    }
    else{
      postsRef.doc(otherUserId+ postId.toString()).update({
        "dislikes": FieldValue.arrayRemove([userId])
      });
    }
  }

  Future<void> sendCommendTo(String userId, String otherUserId, int postId, String context) async
  {
    var docRef = await usersRef.doc(otherUserId).get();
    var posts = (docRef.data() as Map<String, dynamic>)["posts"];
    var thePost = posts[0];
    int i = 0;
    for(; i < posts.length ; i++)
    {
      if(postId == posts[i]["postId"])
      {
        thePost = posts[i];
        break;
      }
    }
    thePost["comments"] = thePost["comments"] + [{"senderId": userId, "context": context}];
    posts[i] = thePost;
    usersRef.doc(otherUserId).update({
      "posts": posts
    });
    postsRef.doc(otherUserId + postId.toString()).update({
      "comments": FieldValue.arrayUnion([{"senderId":  userId, "context": context}])
    });

    //TODO pushNotifications(userId, otherUserId, " commented on your post.");
  }

  Future<void> disablePost(String postId) async
  {
    postsRef.doc(postId).update(
        {
          'isDisabled': true
        }
    );
  }
  Future<void> enablePost(String postId) async
  {
    postsRef.doc(postId).update(
        {
          'isDisabled': false
        }
    );
  }
}