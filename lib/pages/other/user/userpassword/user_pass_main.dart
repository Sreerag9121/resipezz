import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/user/userpassword/update_pass_body.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/my_text_field.dart';
import 'package:recipizz/widgets/text_field_without_border.dart';

class UserPassMain extends StatefulWidget {
  const UserPassMain({super.key});

  @override
  State<UserPassMain> createState() => _UserPassMainState();
}

class _UserPassMainState extends State<UserPassMain> {
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
