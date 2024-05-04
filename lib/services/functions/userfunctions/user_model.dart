
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String?email;
  String?name;
  String?password;
  DateTime?createdAt;
  int?status;
  String?uid;

  UserModel({this.uid,this.email,this.name,this.password,this.createdAt,this.status});

  factory UserModel.fromJason(DocumentSnapshot data){
    return UserModel(
      email: data['email'],
      uid:data['uid'],
      name: data['name'],
      status: data['status'],
      createdAt: data['createdAt']
    );
  }

  Map<String,dynamic>toJason(){
    return {
      'uid':uid,
      'name':name,
      'email':email,
      'password':password,
      'status':status,
      'createdAt':createdAt
    };
  }
}