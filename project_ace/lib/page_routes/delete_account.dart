import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/auth_services.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key, required this.analytics}) : super(key: key);
  final FirebaseAnalytics analytics;
  static const String routeName = '/delete_account';

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final AuthServices _auth = AuthServices();

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
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return Login(analytics: widget.analytics);
    }
    setCurrentScreen(
        widget.analytics, "Delete Account View", "delete_account.dart");
    setUserId(widget.analytics, user.uid);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.profileScreenBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: screenHeight(context) * 0.025,
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
          splashRadius: screenHeight(context) * 0.03,
        ),
        toolbarHeight: screenHeight(context) * 0.08,
        elevation: 0,
        centerTitle: true,
        foregroundColor: AppColors.welcomeScreenBackgroundColor,
        title: SizedBox(
          width: screenWidth(context) * 0.65,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Delete Your Account",
              style: messageHeader,
            ),
          ),
        ),
        backgroundColor: AppColors.profileScreenBackgroundColor,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight(context) * 0.048),
              SizedBox(height: screenHeight(context) * 0.048),
              SizedBox(
                width: screenWidth(context) * 0.75,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            maxHeight: screenHeight(context) * 0.075),
                        child: TextFormField(
                          controller: username,
                          autocorrect: false,
                          enableSuggestions: false,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "username",
                                  style: loginForm,
                                )
                              ],
                            ),
                            fillColor: AppColors.loginFormBackgroundColor,
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight(context) * 0.024),
                      Container(
                        constraints: BoxConstraints(
                            maxHeight: screenHeight(context) * 0.075),
                        child: TextFormField(
                          controller: password,
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.03),
              OutlinedButton(
                onPressed: () async {
                  bool isSuccessful = await _auth.deleteUser(password.text);
                  if (!isSuccessful) {
                    _showDialog("Error",
                        "Your account could not be deleted because you could not confirm the requested information!");
                    password.clear();
                    username.clear();
                  }
                },
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(
                      screenWidth(context) * 0.5, screenHeight(context) * 0.07),
                  elevation: 0,
                  backgroundColor: AppColors.sharePostColor,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          screenHeight(context) * 0.0345)),
                ),
                child: Text(
                  "Confirm delete",
                  style: aceButton,
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
