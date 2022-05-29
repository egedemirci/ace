import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ace/page_routes/change_password.dart';
import 'package:project_ace/page_routes/delete_account.dart';
import 'package:project_ace/page_routes/edit_bio.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';

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

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(
        widget.analytics, "Profile Settings View", "profile_settings.dart");
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.profileScreenTextColor,
        title: SizedBox(
          width: screenWidth(context) * 0.6,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Profile Settings',
              style: profileSettingsHeader,
            ),
          ),
        ),
        backgroundColor: AppColors.profileScreenBackgroundColor,
        centerTitle: true,
        elevation: 0.0,
      ),
      backgroundColor: AppColors.profileScreenBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // TODO: Extend the implementation of Screen Sizes
              SizedBox(
                height: 54.0,
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
              const SizedBox(height: 16.0),
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
              const SizedBox(height: 16.0),
              SizedBox(
                height: 54.0,
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
              const SizedBox(height: 16.0),
              SizedBox(
                height: 54.0,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.deactivateAccountButtonFillColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: Text(
                    'Deactivate account',
                    style: profileSettingsDeactivateAndDelete,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 54.0,
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
