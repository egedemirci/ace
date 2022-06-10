import 'dart:convert';

import 'package:http/http.dart' as http;

Future sendEmailPost({
  required String reporterUserId,
  required String reportedUserId,
  required String reportedUsername,
  required String reportedPostId,
}) async {
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  /*final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'service_id': 'service_7jct9yf',
        'template_id': 'template_i9y64ib',
        'user_id': '0K9K-hMu7euez00BP',
        'template_params': {
          'reporterUserId': reporterUserId,
          'reportedUserId': reportedUserId,
          'reportedUsername': reportedUsername,
          'reportedPostId': reportedPostId,
        }
      })
  );
  print(response.body);*/
}

Future sendEmailUser({
  required String reporterUserId,
  required String reportedUserId,
  required String reportedUsername,
}) async {
  final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
  /*final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'service_id': 'service_7jct9yf',
        'template_id': 'template_0wvw7gz',
        'user_id': '0K9K-hMu7euez00BP',
        'template_params': {
          'reporterUserId': reporterUserId,
          'reportedUserId': reportedUserId,
          'reportedUsername': reportedUsername,
        }
      })
  );
  print(response.body);*/
}
