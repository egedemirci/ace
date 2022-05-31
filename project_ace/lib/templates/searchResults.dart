import 'package:cloud_firestore/cloud_firestore.dart';

class SearchResults {
  final String? fullName;
  final String? username;
  final String? avatarURL;
  final String? userId;

  SearchResults({this.fullName, this.username, this.avatarURL, this.userId});

  List<SearchResults> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
          snapshot.data() as Map<String, dynamic>;
      return SearchResults(
          fullName: dataMap["fullName"],
          username: dataMap['username'],
          avatarURL: dataMap["profilepicture"],
          userId: dataMap["userId"]);
    }).toList();
  }
}
