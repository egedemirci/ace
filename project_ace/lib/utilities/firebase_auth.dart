import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      return uc.user;
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
      String email, String password) async {
    try {
      UserCredential uc = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return uc.user;
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
}
