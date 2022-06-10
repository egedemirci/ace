import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ace/page_routes/change_password.dart';
import 'package:project_ace/page_routes/delete_account.dart';
import 'package:project_ace/page_routes/edit_bio.dart';
import 'package:project_ace/page_routes/login.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = '/profile_settings';

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  final ImagePicker _picker = ImagePicker();
  final UserServices _userServices = UserServices();
  File? _image;
  bool isPrivate = false;
  bool isDisabled = false;
  bool sharedIsDisabled = false;

  onChangedSwitch(bool newVal, String userId) {
    setState(() {
      isPrivate = newVal;
      _userServices.updatePrivacy(userId, isPrivate);
    });
  }

  onChangedDisableAccount(bool newVal, String userId) async {
    setState(() {
      if (newVal == true) {
        _userServices.enableUser(userId);
        isDisabled = newVal;
      } else {
        _userServices.disableUser(userId);
        isDisabled = newVal;
      }
    });
  }

  Future pickImage() async {
    try {
      final image = await _picker.pickImage(source: ImageSource.gallery);
      final imageTemporary = File(image!.path);
      setState(() {
        _image = imageTemporary;
      });
    } catch (e) {
      FirebaseCrashlytics.instance.log(e.toString());
    }
  }

  void changePP() async {
    await pickImage();
    if (_image != null) {
      await _userServices.uploadProfilePicture(
          FirebaseAuth.instance.currentUser, _image!);
    }
  }

  Future getUserPrivacy() async {
    final upp =
        await UserServices().getPrivacy(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      isPrivate = upp;
    });
  }

  Future getUserDisabled() async {
    final f = await UserServices()
        .getDisabled(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      isDisabled = f;
    });
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
    getUserDisabled();
    getUserPrivacy();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);
    final user = Provider.of<User?>(context);
    if (user == null) {
      return Login(analytics: widget.analytics);
    }
    setUserId(widget.analytics, user.uid);
    setCurrentScreen(
        widget.analytics, "Profile Settings View", "profile_settings.dart");
    return Scaffold(
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
        centerTitle: true,
        title: SizedBox(
          width: screenWidth(context) * 0.6,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Profile Settings",
              style: messageHeader,
            ),
          ),
        ),
        foregroundColor: AppColors.welcomeScreenBackgroundColor,
        elevation: 0,
        backgroundColor: AppColors.profileScreenBackgroundColor,
        toolbarHeight: screenHeight(context) * 0.08,
      ),
      backgroundColor: AppColors.profileScreenBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(radius),
                  color: AppColors.metaGoogleConnectButtonColor,
                ),
                height: 54.0,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Account Privacy:  ${isPrivate ? "Private" : "Public"}',
                      style: profileSettingsChangeButton,
                    ),
                    CupertinoSwitch(
                      value: isPrivate,
                      onChanged: (newPrivacy) {
                        onChangedSwitch(newPrivacy, user.uid);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.018),
              SizedBox(
                height: screenHeight(context) * 0.062,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, ChangePassword.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.metaGoogleConnectButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Change password',
                    style: profileSettingsChangeButton,
                  ),
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.018),
              SizedBox(
                height: 54.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, EditBioView.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.metaGoogleConnectButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Edit bio',
                    style: profileSettingsChangeButton,
                  ),
                ),
              ),
              SizedBox(height: screenHeight(context) * 0.018),
              SizedBox(
                height: screenHeight(context) * 0.062,
                child: ElevatedButton(
                  onPressed: changePP,
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.metaGoogleConnectButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Change profile picture',
                    style: profileSettingsChangeButton,
                  ),
                ),
              ),

              SizedBox(height: screenHeight(context) * 0.018),
              SizedBox(
                height: screenHeight(context) * 0.062,
                child: ElevatedButton(
                  onPressed: () async {
                    if (isDisabled) {
                      await _userServices.enableUser(user.uid);
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setBool("disable", false);
                      _showDialog(
                          "Success", "You successfully enabled your account!");
                      setState(() {
                        isDisabled = false;
                      });
                    } else {
                      await _userServices.disableUser(user.uid);
                      var prefs = await SharedPreferences.getInstance();
                      prefs.setBool("disable", true);
                      _showDialog(
                          "Success", "You successfully disabled your account!");
                      setState(() {
                        isDisabled = true;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      primary: isDisabled
                          ? AppColors.messagesFromUserFillColor
                          : AppColors.deactivateAccountButtonFillColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    isDisabled ? 'Enable Account' : 'Disable Account',
                    style: profileSettingsDeactivateAndDelete,
                  ),
                ),
              ),
              //DEACTIVATE WITH SWITCH
              /*
              SizedBox(height: screenHeight(context) * 0.018),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(radius),
                  color: AppColors.metaGoogleConnectButtonColor,
                ),
                height: 54.0,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Deactive Account:  ${isDisabled ? "Disable" : "Enable"}',
                      style: profileSettingsChangeButton,
                    ),
                    CupertinoSwitch(
                      value: isDisabled,
                      onChanged: (newDisable) {
                        onChangedDisableAccount(newDisable, user.uid);
                      },
                    )
                  ],
                ),
              ),
              */
              SizedBox(height: screenHeight(context) * 0.018),
              SizedBox(
                height: screenHeight(context) * 0.062,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, DeleteAccount.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.deleteAccountButtonFillColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Delete account',
                    style: profileSettingsDeactivateAndDelete,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
