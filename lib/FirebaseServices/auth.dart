// ignore_for_file: empty_catches

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthservice {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      return null;
    }
  }

  Future<User?> signUp(
    String username,
    String phoneNumber,
    String email,
    String password,
  ) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } catch (e) {
      (e.toString());
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {}
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {}
  }
}
