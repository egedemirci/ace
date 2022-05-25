import 'dart:convert';
import 'dart:io' show Platform;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/page_routes/profile_view.dart';
import 'package:project_ace/templates/user.dart';
import 'package:project_ace/page_routes/signup.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/firebase_auth.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import "package:project_ace/utilities/api.dart";
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:project_ace/utilities/styles.dart';

import '../services/analytics.dart';

class Login extends StatefulWidget {
  const Login({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = "/login";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  String _password = '';
  String _email = '';
  late String s;

  final FirebaseAuthService _auth = FirebaseAuthService();

  Future<dynamic> loginUser() async {
    dynamic result = await _auth.signInWithEmailPassword(_email, _password);
    if (result is String) {
      _showDialog("Login Error", result);
    } else if (result is User) {
      // user is signed in.
      Navigator.pushNamedAndRemoveUntil(context, ProfileView.routeName, (route) => false);
    } else {
      _showDialog("Login Error", result.toString());
    }
  }

  Future getUsers() async {
    final url = Uri.parse(API.allUsers);
    final response = await http.get(Uri.https(url.authority, url.path));
    //_showDialog("Response", "${response.statusCode}");
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Successful
      // _showDialog("HTTP Response: ${response.statusCode}", response.body);
      /*
      Map<String, dynamic> post = jsonDecode(response.body);
      print('User ID: ${post["userId"]}');
      print('Title: ${post["title"]}');
      print('Body: ${post["body"]}');
      JSONPost newPost = JSONPost(
          title: post["title"],
          body: post["body"],
          userID: post["userId"],
          postID: post["id"]);
      print(newPost);
      */
      var responseList = jsonDecode(response.body) as List;
      /*
      print("Post Count: ${responseList.length}");
      List<JSONPost> postItems =
          responseList.map((postItem) => JSONPost.fromJSON(postItem)).toList();
      print("${postItems[10]}");
       */
      List<MyUser> users =
          responseList.map((user) => MyUser.fromJSON(user)).toList();
      print("Latitude: ${users[1].address.geo.lat}");
      print("Longitude: ${users[1].address.geo.lng}");
    } else {
      // Unsuccessful
      _showDialog("HTTP Response: ${response.statusCode}", response.body);
    }
  }

  Future<void> _showDialog(String title, String message) async {
    bool isAndroid = Platform.isAndroid;
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          if (isAndroid) {
            return AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                children: [
                  Text(message),
                ],
              )),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          } else {
            return CupertinoAlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                  child: ListBody(
                children: [
                  Text(message),
                ],
              )),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    s = '';
  }

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(widget.analytics, "Login View", "loginView");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.loginScreenBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight(context)*0.048),
            ClipRect(
              child: Image(
                  image: const NetworkImage('https://i.hizliresim.com/bxfjezq.png'),
                  width: screenWidth(context)*0.5,
                  height: screenHeight(context)*0.25),
            ),
            SizedBox(height: screenHeight(context)*0.048),
            SizedBox(
              width: screenWidth(context)*0.75,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(maxHeight: screenHeight(context)*0.075),
                      child: TextFormField(
                        autocorrect: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "e-mail",
                                style: loginForm,
                              )
                            ],
                          ),
                          fillColor: AppColors.loginFormBackgroundColor,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Cannot leave email empty!';
                            }
                            if (!EmailValidator.validate(value)) {
                              return 'Please enter a valid email address!';
                            }
                          }
                        },
                        onSaved: (value) {
                          _email = value ?? "";
                        },
                      ),
                    ),
                    SizedBox(height: screenHeight(context)*0.024),
                    Container(
                      constraints: BoxConstraints(maxHeight: screenHeight(context)*0.075),
                      child: TextFormField(
                        autocorrect: false,
                        enableSuggestions: false,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "password",
                                style: loginForm,
                              )
                            ],
                          ),
                          fillColor: AppColors.loginFormBackgroundColor,
                          filled: true,
                        ),
                        validator: (value) {
                          if (value != null) {
                            if (value.isEmpty) {
                              return 'Cannot leave password empty!';
                            }
                            if (value.length < 6) {
                              return 'Password is too short!';
                            }
                          }
                        },
                        onSaved: (value) {
                          _password = value ?? "";
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight(context)*0.024),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      await loginUser();
                    } else {
                      _showDialog(
                          'Form Error', "Your email or password is invalid!");
                    }
                  },
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "LOG IN",
                      style: loginSignUpButton,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.loginSignupButtonBackgroundColor,
                    fixedSize: Size(screenWidth(context)*0.3, screenHeight(context)*0.05),
                  ),
                ),
                SizedBox(height: screenHeight(context)*0.012),
                Text(
                  "OR CONNECT WITH",
                  style: loginPageText,
                ),
                SizedBox(height: screenHeight(context)*0.012),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      child: Image.asset("assets/images/meta.png", scale: 25),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors
                              .loginPageMetaGoogleOptionBackgroundColor,
                          fixedSize: Size(screenWidth(context)*0.3, screenHeight(context)*0.05)),
                    ),
                    SizedBox(width: screenHeight(context)*0.024),
                    OutlinedButton(
                      onPressed: () {},
                      child: Image.asset("assets/images/google.png", scale: 25),
                      style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors
                              .loginPageMetaGoogleOptionBackgroundColor,
                          fixedSize: Size(screenWidth(context)*0.3, screenHeight(context)*0.05)),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight(context)*0.012),
                Text(
                  "NEED ACCOUNT?",
                  style: loginPageText,
                ),
                SizedBox(height: screenHeight(context)*0.012),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, SignUp.routeName, (route) => false);
                  },
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "SIGN UP",
                      style: loginSignUpButton,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.loginSignupButtonBackgroundColor,
                    fixedSize: Size(screenWidth(context)*0.3, screenHeight(context)*0.05),
                  ),
                ),
              ],
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
