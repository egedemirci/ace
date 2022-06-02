
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ace/services/email_service.dart';

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
  Future<void> reportPost(String reporterUserId, String reportedPostId, String reportedUserId, String reportedUsername) async{
    postReports.add(
        {
          'reporterUserId': reporterUserId,
          'reportedPostId': reportedPostId,
          'reportedUserId': reportedUserId,
          'reportedUsername': reportedUsername,
        }
    );
    sendEmail(reporterUserId: reporterUserId, reportedUserId: reportedUserId, reportedUsername: reportedUsername, reportedPostId: reportedPostId);
  }
}