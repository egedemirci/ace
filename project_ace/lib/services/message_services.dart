import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ace/templates/chat_room.dart';
import 'package:project_ace/templates/message.dart';

class MessageService {
  final CollectionReference chatRoomReference =
      FirebaseFirestore.instance.collection('ChatRooms');

  createMessage(String currentId, String otherId) async {
    String bigger = otherId + currentId;
    if (currentId.compareTo(otherId) < 0) {
      bigger = currentId + otherId;
    }
    DocumentSnapshot ds = await chatRoomReference.doc(bigger).get();
    if (!ds.exists) {
      await chatRoomReference.doc(bigger).set(ChatRoom(
          chatRoomId: bigger,
          lastMessageCreatedAt: DateTime.now(),
          usersChatting: [currentId, otherId]).toJson());
    }
  }

  Future<void> sendMessage(String chatId, String message, String senderUsername,
      String senderAvatar) async {
    await chatRoomReference.doc(chatId).update({
      'texts': FieldValue.arrayUnion([
        Message(
                senderUsername: senderUsername,
                message: message,
                createdAt: DateTime.now(),
                urlAvatar: senderAvatar)
            .toJson()
      ]),
      'lastMessage': message,
      'lastSenderUsername': senderUsername,
      'lastMessageCreatedAt': DateTime.now().toIso8601String(),
    });
  }
}
