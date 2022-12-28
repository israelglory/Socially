// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String fullName;
  final String userName;
  final String avatar;
  final String email;
  final String uid;
  UserModel({
    required this.fullName,
    required this.userName,
    required this.avatar,
    required this.email,
    required this.uid,
  });

  factory UserModel.fromFirestore(DocumentSnapshot map) {
    return UserModel(
      avatar: map['avatar'],
      email: map['email'],
      fullName: map['fullName'],
      uid: map['uid'],
      userName: map['userName'],
    );
  }
}
