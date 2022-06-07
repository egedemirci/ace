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
        // Send them to the register screen
      } else if (e.code == "wrong-password") {
        return e.message ?? 'Password is not correct!';
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
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
        return e.message ?? "This password is weak is to use!";
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

  Future<bool> changePassword(String crrPass, String newPass) async {
    bool isSuccess = false;
    final user = _auth.currentUser;
    final credentials =
        EmailAuthProvider.credential(email: user!.email!, password: crrPass);
    await user.reauthenticateWithCredential(credentials).then((value) async {
      await user.updatePassword(newPass).then((value) {
        isSuccess = true;
      }).catchError((error) {
        isSuccess = false;
      });
    }).catchError((error) {
      isSuccess = false;
    }); // end of catch
    return isSuccess;
  } // at the end of the change password

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

/*
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  User? _userFromFirebase(User? user) {
    return user ?? null;
  }

  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  Future signInAnon(StackTrace stackTrace) async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebase(user);
    } catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        stackTrace,
        reason: e.toString(),
      );
      print(e.toString());
      return null;
    }
  }

  Future getUserCredentials() async {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    try {
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return [credential, googleUser!.email];
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future signInWithGoogle() async {
    try {
      final credential = await getUserCredentials();
      return await FirebaseAuth.instance.signInWithCredential(credential[0]);
    } on FirebaseAuthException catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      //googleSignIn.disconnect();
      return e.message;
    } catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      //googleSignIn.disconnect();
    }
  }

  Future signupWithMailAndPass(String mail, String pass, String name,
      String surname, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: mail, password: pass);
      User user = result.user!;
      DBService dbService = DBService();
      String userToken = await user.uid;
      dbService.addUser(name, surname, mail, userToken, username, pass);

      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      //FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      return e.code.toString();
    } catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      //FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      print(e.toString());
      String message = e.toString();
      return message;
    }
  }

  Future loginWithMailAndPass(String mail, String pass) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      User user = result.user!;
      return _userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      return e.code.toString();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
        await googleSignIn.signOut();
      }
      return await _auth.signOut();
    } catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      print(e.toString());
      return null;
    }
  }

  Future deleteAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        StackTrace.current,
        reason: e.toString(),
      );
      FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
      if (e.code == 'requires-recent-login') {
        print(
            'The user must re-authenticate before this operation can be executed.');
      }
    }
  }
}
 */
