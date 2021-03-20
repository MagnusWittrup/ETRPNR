import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel with ChangeNotifier {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future addUser(
    String uid,
    String firstName,
    String lastName,
    // String company,
    // String gender,
    // DateTime dateOfBirth,
    // List<String> tags,
  ) {
    return users
        .add({
          'uid': uid,
          'firstName': firstName,
          'lastName': lastName,
          // 'company': company,
          // 'dateOfBirth': dateOfBirth,
          // 'gender': gender,
          // 'tags': tags,
        })
        .then((value) => print("User Info addded - Value $value"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
