import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_ace/services/user_services.dart';

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

  Future<dynamic> registerWithEmailPassword(
      String email, String password, String userName) async {
    try {
      UserCredential uc = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _userServices.addUser(userName, uc.user?.uid);
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
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
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
