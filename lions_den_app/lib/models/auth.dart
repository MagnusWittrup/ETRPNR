import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthModel with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  User get currentUser => _auth.currentUser;
  String get currentUserUID => currentUser.uid;

  UserCredential _user;
  UserCredential get user => _user;

  Future<void> logout() async {
    await _auth.signOut();
    return;
  }

  // * Add email verification:
  // ? https://firebase.flutter.dev/docs/auth/usage#verifying-a-users-email
  // if (!user.emailVerified) {
  //   await user.sendEmailVerification();
  // }

  Future loginUser({
    String userEmail,
    String userPassword,
  }) async {
    try {
      UserCredential userCredentials = await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      print("$userCredentials");
      _user = userCredentials;
      notifyListeners();
      return userCredentials;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }

  Future registerUser({
    String userEmail,
    String userPassword,
  }) async {
    try {
      UserCredential userCredentials =
          await _auth.createUserWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
      print("$userCredentials");
      _user = userCredentials;
      notifyListeners();
      return userCredentials;
    } on FirebaseAuthException catch (e) {
      return e;
    }
  }
}
