import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/user/other/user_password/update_password_body.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserPasswordPage extends StatefulWidget {
  const UserPasswordPage({super.key});

  @override
  State<UserPasswordPage> createState() => _UserPasswordPageState();
}

class _UserPasswordPageState extends State<UserPasswordPage> {
  final user = FirebaseAuth.instance.currentUser;
  late DocumentReference _userReference;
  @override
  void initState() {
    _userReference =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        foregroundColor: AppTheme.colors.appWhiteColor,
        title: Text('Update Password',
            style: TextStyle(
                fontFamily: AppTheme.fonts.jost,
                fontWeight: FontWeight.w600,
                fontSize: 24)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 25,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: _userReference.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              DocumentSnapshot userDoc = snapshot.data!;
              Map<String, dynamic> userData =
                  userDoc.data() as Map<String, dynamic>;
              return SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      //body of Update Password
                      child: UpdatePassWordBody(
                        userData: userData, 
),
                    ),
                  ),
                ),
              );
            }
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          }),
    );
  }
}
