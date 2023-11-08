// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/Models/userModel.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUserInFirestore(UserModel userModel) async {
    try {
      await _firestore.collection('users').doc(userModel.userId).set({
        'email': userModel.email,
        'username': userModel.username,
        'phonenumber': userModel.phoneNumber,
        "uid": userModel.userId,
        // Add more user data fields here as needed
      });
    } catch (e) {}
  }
}
