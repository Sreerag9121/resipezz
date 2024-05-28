import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdatePassWord {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> updatePasswordFn(
       String currentPassword, String newPassword,BuildContext context) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
            email: user.email!, password: currentPassword);
        await user.reauthenticateWithCredential(credential);

        await user.updatePassword(newPassword);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error:${e}'),));
      }
    }
  }
}
