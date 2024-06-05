
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String?email;
  String?userName;
  String?password;
  DateTime?createdAt;
  String?uid;
  String?userImage;

  UserModel({this.uid,this.email,this.userName,this.password,this.createdAt,this.userImage});

  factory UserModel.fromJason(DocumentSnapshot data){
    return UserModel(
      email: data['email'],
      uid:data['uid'],
      userName: data['name'],
      createdAt: data['createdAt'],
      userImage: data['userImage']
    );
  }

  Map<String,dynamic>toJason(){
    return {
      'uid':uid,
      'name':userName,
      'email':email,
      'password':password,
      'createdAt':createdAt,
      'userImage':userImage
    };
  }
}