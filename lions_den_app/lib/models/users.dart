import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UsersModel with ChangeNotifier {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String uid;
  String lastName;
  String firstName;
  DateTime dateOfBirth;
  String gender;
  String company;

  String tagError = '';

  //todo: Add more tags
  List<String> tags = [
    'New Entrepreneur',
    'Webshop',
    'Programming',
    'Admin help',
  ];
  List<String> activeTags = [];

  void updateValue({
    @required String variable,
    @required dynamic value,
  }) {
    switch (variable) {
      case 'uid':
        uid = value as String;
        break;
      case 'firstName':
        firstName = value as String;
        break;
      case 'lastName':
        lastName = value as String;
        break;
      case 'dateOfBirth':
        dateOfBirth = value as DateTime;
        break;
      case 'gender':
        gender = value as String;
        break;
      case 'company':
        company = value as String;
        break;
      case 'tagError':
        tagError = value as String;
        break;
      case 'tags':
        tags = value as List<String>;
        break;
      case 'activeTags':
        activeTags = value as List<String>;
        break;
      default:
        debugPrint("Variable: $variable not recognized");
        break;
    }
    notifyListeners();
  }

  Future addUser() {
    // SetOptions options = SetOptions();
    DocumentReference user = users.doc(uid);
    return user
        .set(
          {
            'uid': uid,
            'firstName': firstName,
            'lastName': lastName,
            'dateOfBirth': dateOfBirth,
            'gender': gender,
            'company': company,
            'tags': activeTags,
          },
        )
        .then((value) => debugPrint('SUCCESS.'))
        .catchError((error) => debugPrint('Failed to add user: $error'));
    // return users
    //     .add({
    //       'uid': uid,
    //       'firstName': firstName,
    //       'lastName': lastName,
    //       'dateOfBirth': dateOfBirth,
    //       'gender': gender,
    //       'company': company,
    //       'tags': activeTags,
    //     })
    // .then((value) => debugPrint("User Info addded - Value $value"))
    // .catchError((error) => debugPrint("Failed to add user: $error"));
  }
}
