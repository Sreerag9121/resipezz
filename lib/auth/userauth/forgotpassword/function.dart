import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthService {
  final TextEditingController emailController;
   TextEditingController? passwordController;

  FirebaseAuthService({
    required this.emailController,
    this.passwordController,
  });

   Future resetpass() async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
  }
}
