import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_ace/services/user_services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserServices _userServices = UserServices();

  User? _userFromFirebase(User? user) {
    return user;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future<dynamic> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential uc = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebase(uc.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        return e.message ?? 'Email/Password not found! Try registering :)';
      } else if (e.code == "wrong-password") {
        return e.message ?? 'Password is not correct!';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future signInWithFacebook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    UserCredential result = await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential);
    User? user = result.user;
    DocumentSnapshot ds = await _userServices.usersRef.doc(user!.uid).get();
    if (!ds.exists) {
      int idx = user.email!.indexOf('@');
      String username = user.email!.substring(0, idx);
      Random random = Random();
      while (true) {
        bool doesExist = await _userServices.doesUsernameExist(username);
        if (!doesExist) {
          break;
        } else {
          int randomNumber = random.nextInt(10);
          username += randomNumber.toString();
        }
      }
      await _userServices.addUser(
          username, user.displayName ?? "unknown", user.uid);
    }
    return _userFromFirebase(user);
  }

  Future<dynamic> registerWithEmailPassword(
      String email, String password, String userName, String fullName) async {
    try {
      UserCredential uc = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _userServices.addUser(userName, fullName, uc.user?.uid);
      return _userFromFirebase(uc.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return e.message ?? "This email is already in use!";
      } else if (e.code == "weak-password") {
        return e.message ?? "This password is weak to use!";
      }
    }
  }

  Future<void> signOutUser() async {
    await _auth.signOut();
  }

  Future<dynamic> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential result =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = result.user;
    DocumentSnapshot ds = await _userServices.usersRef.doc(user!.uid).get();
    if (!ds.exists) {
      int idx = user.email!.indexOf('@');
      String username = user.email!.substring(0, idx);
      Random random = Random();
      while (true) {
        bool doesExist = await _userServices.doesUsernameExist(username);
        if (!doesExist) {
          break;
        } else {
          int randomNumber = random.nextInt(10);
          username += randomNumber.toString();
        }
      }
      _userServices.addUser(
          username, googleUser?.displayName ?? "unknown", user.uid);
    }
    return _userFromFirebase(user);
  }

  Future<bool> changePassword(String currPass, String newPass) async {
    bool isSuccess = false;
    final user = _auth.currentUser;
    final credentials =
        EmailAuthProvider.credential(email: user!.email!, password: currPass);
    await user.reauthenticateWithCredential(credentials).then((value) async {
      await user.updatePassword(newPass).then((value) {
        isSuccess = true;
      }).catchError((error) {
        isSuccess = false;
      });
    }).catchError((error) {
      isSuccess = false;
    });
    return isSuccess;
  }

  Future<bool> deleteUser(String password) async {
    bool isSuccess = false;
    final user = _auth.currentUser;
    final credentials =
        EmailAuthProvider.credential(email: user!.email!, password: password);
    await user.reauthenticateWithCredential(credentials).then((value) async {
      await user.delete().then((value) {
        isSuccess = true;
        _auth.signOut();
      }).catchError((error) {
        isSuccess = false;
      });
    }).catchError((error) {
      isSuccess = false;
    });
    return isSuccess;
  }
}
