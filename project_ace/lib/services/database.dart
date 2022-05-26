import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ace/templates/message.dart';
import 'package:project_ace/templates/user.dart';


CollectionReference usersRef = FirebaseFirestore.instance.collection("Users");
CollectionReference chatRoomsRef = FirebaseFirestore.instance.collection("ChatRooms");
CollectionReference notificationsRef = FirebaseFirestore.instance.collection("Notifications");
CollectionReference postsRef = FirebaseFirestore.instance.collection("Posts");
CollectionReference topicsRef = FirebaseFirestore.instance.collection("Topics");


class DatabaseMethods {

  Future<void> addUserInfo(MyUser userData) async {
    usersRef.add(userData.toJson()).catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return usersRef
        .where("email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  searchByName(String searchField) {
    return usersRef
        .where('userName', isEqualTo: searchField)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String currentUsername, String otherUsername) async{
    String chatroomId = otherUsername+currentUsername;

    if(currentUsername.compareTo(otherUsername) < 0) {
      chatroomId = currentUsername + otherUsername;
    }
    DocumentSnapshot ds = await chatRoomsRef.doc(chatroomId).get();
    if(!ds.exists) {
      await chatRoomsRef.doc(chatroomId
      ).set(
          {
            'lastMessage': "",
            'lastMessageCreatedAt': DateTime.now(),
            'lastSenderUsername': "",
            'userName1': currentUsername,
            'userName2': otherUsername,
          }
      );
    }
  }

  getChats(String chatRoomId) async{
    return chatRoomsRef
        .doc(chatRoomId)
        .collection("Messages")
        .orderBy('time')
        .snapshots();
  }


  Future<void> sendMessage(String chatId, Message message, String sender) async
  {
    await chatRoomsRef.doc(chatId).collection("Messages").add(message.toJson());
  }

  getUserChats(String itIsMyName) async {
    return await chatRoomsRef
        .where('usersChatting', arrayContains: itIsMyName)
        .snapshots();
  }

}