import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_ace/services/email_service.dart';

class ReportService {
  final CollectionReference userReports =
      FirebaseFirestore.instance.collection('UserReports');
  final CollectionReference postReports =
      FirebaseFirestore.instance.collection('PostReports');

  Future<void> reportUser(String reportedUserId, String reporterUserId,
      String reportedUsername) async {
    userReports.add({
      'reportedUserId': reportedUserId,
      'reportedUsername': reportedUsername,
      'reporterUserId': reporterUserId,
    });
    sendEmailUser(
        reporterUserId: reporterUserId,
        reportedUserId: reportedUserId,
        reportedUsername: reportedUsername);
  }

  Future<void> reportPost(String reporterUserId, String reportedPostId,
      String reportedUserId, String reportedUsername) async {
    postReports.add({
      'reporterUserId': reporterUserId,
      'reportedPostId': reportedPostId,
      'reportedUserId': reportedUserId,
      'reportedUsername': reportedUsername,
    });
    sendEmailPost(
        reporterUserId: reporterUserId,
        reportedUserId: reportedUserId,
        reportedUsername: reportedUsername,
        reportedPostId: reportedPostId);
  }
}
