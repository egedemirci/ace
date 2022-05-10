import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/colors.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);
  static const String routeName = '/profile_settings';

  void changePassword() {

  }

  void editBio(){

  }

  void changeProfilePicture(){

  }

  void deleteAccount(){

  }

  void deactivateAccount(){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Text(
        'Profile Settings',
        style: TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.bold,
          color: AppColors.profileScreenTextColor,
          ),
        ),
        backgroundColor: AppColors.profileScreenBackgroundColor,
        centerTitle: true,
        elevation: 0.0,
        toolbarHeight: 120.0,
        leading: GestureDetector(
          child: const Padding(
            padding: EdgeInsets.all(24.0),
            child: Icon(
              Icons.arrow_back_ios,
              size: 36.0,
              color: AppColors.profileScreenTextColor),
          ),
            onTap: (){
              Navigator.pop(context);
            },
        ),
      ),
      backgroundColor: AppColors.profileScreenBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(48.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 54.0,
                child: ElevatedButton(
                  onPressed: changePassword,
                  child: const Text(
                    'Change password',
                    style: TextStyle(
                        color: AppColors.profileScreenTextColor,
                        fontSize: 24.0
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.metaGoogleConnectButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
              ),

              const SizedBox(height: 16.0),
              SizedBox(
                height: 54.0,
                child: ElevatedButton(
                  onPressed: editBio,
                  child: const Text(
                    'Edit bio',
                    style: TextStyle(
                        color: AppColors.profileScreenTextColor,
                        fontSize: 24.0
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.metaGoogleConnectButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 54.0,
                child: ElevatedButton(
                  onPressed: changeProfilePicture,
                  child: const Text(
                      'Change profile picture',
                    style: TextStyle(
                      color: AppColors.profileScreenTextColor,
                      fontSize: 24.0
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.metaGoogleConnectButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 54.0,
                child: ElevatedButton(
                  onPressed: deactivateAccount,
                  child: const Text(
                      'Deactivate account',
                    style: TextStyle(
                        fontSize: 24.0
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.deactivateAccountButtonFillColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                height: 54.0,
                child: ElevatedButton(
                  onPressed: deleteAccount,
                  child: const Text(
                      'Delete account',
                    style: TextStyle(
                        fontSize: 24.0
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: AppColors.deleteAccountButtonFillColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      )
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
