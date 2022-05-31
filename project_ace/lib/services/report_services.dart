
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportService{
  final CollectionReference userReports = FirebaseFirestore.instance.collection('userReports');
  final CollectionReference postReports = FirebaseFirestore.instance.collection('postReports');

  Future<void> reportUser(String reportedUserId, String reporterUserId, String whyReported) async{
    userReports.add(
        {
          'reportedUserId': reportedUserId,
          'reporterUserId': reporterUserId,
          'whyReported': whyReported
        }
    );
  }
  Future<void> reportPost(String reportedPostId, String reporterUserId) async{
    postReports.add(
        {
          'reportedPostId': reportedPostId,
          'reporterUserId': reporterUserId,

        }
    );
  }
}