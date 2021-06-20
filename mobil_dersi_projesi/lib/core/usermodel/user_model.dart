import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserModel{
  final String userID;
  String email;
  String userName;
  String profilURL;
  DateTime createdAt;
  int seviye;

  UserModel({@required this.userID, @required this.email});

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'email': email,
      'userName':
      userName ?? email.substring(0, email.indexOf('@')) + randomSayiUret(),
      'profilURL': profilURL ??
          'https://i.picsum.photos/id/904/200/200.jpg?hmac=QegM9tS4hRwLbLWCb2W91mYYovO_itG2JmSQiz0PnrM',
      'createdAt': createdAt ?? FieldValue.serverTimestamp(),
      'seviye': seviye ?? 1,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : userID = map['userID'],
        email = map['email'],
        userName = map['userName'],
        profilURL = map['profilURL'],
        createdAt = (map['createdAt'] as Timestamp).toDate(),
        seviye = map['seviye'];


  @override
  String toString() {
    return 'UserModel{userID: $userID, email: $email, userName: $userName, profilURL: $profilURL, createdAt: $createdAt, seviye: $seviye}';
  }

  String randomSayiUret() {
    int rastgeleSayi = Random().nextInt(999999);
    return rastgeleSayi.toString();
  }



}