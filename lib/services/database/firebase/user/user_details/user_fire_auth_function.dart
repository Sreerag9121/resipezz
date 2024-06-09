// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipizz/services/database/firebase/user/user_details/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _usercollection =
    FirebaseFirestore.instance.collection('users');
//signUp
  Future<UserCredential?> registorUser(UserModel user) async {
    UserCredential userData = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: user.email.toString(), password: user.password.toString());

    if (userData != null) {
      addUserData(user, userData.user!.uid,);
      return userData;
    }
    return null;
  }
  Future<void>addUserData(UserModel user,String uid)async{
      String uniqueTime = DateTime.now().microsecondsSinceEpoch.toString();
    Reference userImageRef = FirebaseStorage.instance.ref();
    Reference userImage = userImageRef.child('user_por_pick');
    Reference referenceImageUpload = userImage.child(uniqueTime);
    await referenceImageUpload.putFile(File(user.userImage!));
    String imageUrl = await referenceImageUpload.getDownloadURL();
    _usercollection.doc(uid).set({
      'uid':uid,
      'email':user.email,
      'userName':user.userName,
      'userImage':imageUrl,
    });
  }

//login
  Future<DocumentSnapshot?> logInUser(UserModel user) async {
    DocumentSnapshot? snap;

    SharedPreferences pref = await SharedPreferences.getInstance();
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: user.email.toString(), password: user.password.toString());
    String? token = await userCredential.user!.getIdToken();

    if (userCredential != null) {
      snap = await _usercollection.doc(userCredential.user!.uid).get();
      await pref.setString('token', token!);
      return snap;
    }
    return null;
  }

//signout
  Future<void> logOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear();
    await _auth.signOut();
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }
}
