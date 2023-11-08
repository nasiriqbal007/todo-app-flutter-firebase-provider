// ignore_for_file: prefer_const_constructors, empty_catches, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/Models/userModel.dart';
import 'package:todo_app/FirebaseServices/firestore_service.dart';
import 'package:todo_app/Utils/toast_message.dart';
import 'package:todo_app/Utils/user_status.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final ToastService toastService = ToastService();
  User? _currentUser; // Store the current user

  User? get currentUser => _currentUser;

  Future<User?> signIn(String email, String password) async {
    try {
      final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResult.user != null) {
        await UserStatusChecker.storeUserId(authResult.user!.uid);
      }

      notifyListeners();
      return _currentUser = authResult.user;
    } on FirebaseAuthException catch (e) {
      toastService.showToast(
          e.message.toString(), Duration(seconds: 2), ToastGravity.TOP);
    }
    return null;
  }

  Future<User?> signUp(
    String username,
    String phoneNumber,
    String email,
    String password,
  ) async {
    try {
      final UserCredential authResult =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final userModel = UserModel(
          userId: authResult.user!.uid,
          username: username,
          phoneNumber: phoneNumber,
          email: email);

      _currentUser = authResult.user; // Store the current user

      // Store user data in Firestore
      await FirestoreService().createUserInFirestore(userModel);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      toastService.showToast(
          e.message.toString(), Duration(seconds: 2), ToastGravity.TOP);
    }
    return null;
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {}
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _currentUser = null;
      notifyListeners();
    } catch (e) {
      print("Error during sign-out: $e");
    }
  }
}
