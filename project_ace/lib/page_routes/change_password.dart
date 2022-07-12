import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/auth_services.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:provider/provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = "/changePassword";

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController pass = TextEditingController();
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
    setUserId(widget.analytics, user.uid);
    setCurrentScreen(
        widget.analytics, "Change Password View", "change_password.dart");
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
        title: SizedBox(
          width: screenWidth(context) * 0.65,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Change Your Password",
              style: messageHeader,
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: screenHeight(context) * 0.08,
        foregroundColor: AppColors.welcomeScreenBackgroundColor,
        backgroundColor: AppColors.profileScreenBackgroundColor,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight(context) * 0.096),
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
                          controller: oldPassword,
                          autocorrect: false,
                          enableSuggestions: false,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "old password",
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
                          controller: pass,
                          autocorrect: false,
                          enableSuggestions: false,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "new password",
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.024),
              ElevatedButton(
                onPressed: () async {
                  bool isSuccess = false;
                  bool process = true;
                  if (oldPassword.text == "") {
                    _showDialog("Try Again", "Old Password cannot be empty!");
                  }
                  if (oldPassword.text != "") {
                    if (_formKey.currentState!.validate() &&
                        oldPassword.text != pass.text) {
                      isSuccess = await _auth.changePassword(
                          oldPassword.text, pass.text);
                      if (!isSuccess) {
                        process = false;
                        oldPassword.clear();
                        pass.clear();
                        _showDialog("Try Again", "Old Password is wrong!");
                      }
                    }
                  }
                  _formKey.currentState!.save();
                  if (oldPassword.text == pass.text && process) {
                    oldPassword.clear();
                    pass.clear();
                    _showDialog("Try Again", "New Password is the same!");
                  }
                  if (isSuccess) {
                    oldPassword.clear();
                    pass.clear();
                    await _showDialog("Success",
                        "Your password has changed successfully!\nYou will now be signed out.");
                    _auth.signOutUser();
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: AppColors.metaGoogleConnectButtonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            screenHeight(context) * 0.0115))),
                child: Text(
                  'Change password',
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
