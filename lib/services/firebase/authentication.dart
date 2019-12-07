import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<bool> isEmailVerified();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  // some email verification functions
  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  //Sign Up & Sign In Functions
  Future<String> signUp(String email, String password) async {
    AuthResult res;
    try {
      res = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (err) {
      return "No User Found";
    }
    FirebaseUser user = res.user;
    return user.uid;
  }

  Future<String> signIn(String email, String password) async {
    AuthResult res;
    try {
      res = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (err) {
      return "No User Found";
    }
    FirebaseUser user = res.user;
    return user.uid;
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
