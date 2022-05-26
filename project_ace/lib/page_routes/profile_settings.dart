import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:project_ace/services/analytics.dart';
import 'package:project_ace/utilities/colors.dart';
import 'package:project_ace/utilities/screen_sizes.dart';
import 'package:project_ace/utilities/styles.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key, required this.analytics}) : super(key: key);

  final FirebaseAnalytics analytics;
  static const String routeName = '/profile_settings';

  void changePassword() {}

  void editBio() {}

  void changeProfilePicture() {}

  void deleteAccount() {}

  void deactivateAccount() {}

  @override
  Widget build(BuildContext context) {
    setCurrentScreen(analytics, "Profile Settings View", "profileSettingsView");
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
              SizedBox(
                height: 54.0,
                child: ElevatedButton(
                  onPressed: changePassword,
                  child: Text(
                    'Change password',
                    style: profileSettingsChangeButton,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.metaGoogleConnectButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 54.0,
                child: ElevatedButton(
                  onPressed: editBio,
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
                  onPressed: changeProfilePicture,
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
                  onPressed: deactivateAccount,
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
                  onPressed: deleteAccount,
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
