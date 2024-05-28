// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/user/myprofile/update_profile_image.dart';
import 'package:recipizz/services/functions/userfunctions/updateuserpofile/update_user_profile_fn.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/text_field_without_border.dart';

class MyProfileMain extends StatefulWidget {
  const MyProfileMain({super.key});

  @override
  State<MyProfileMain> createState() => _MyProfileMainState();
}

class _MyProfileMainState extends State<MyProfileMain> {
  late DocumentReference _userReference;
  TextEditingController updateUserName = TextEditingController();
  UpdateProfile updateProfile = UpdateProfile();
  final user = FirebaseAuth.instance.currentUser;
  String? imagePath ;
  String? _newImageUrl;

  @override
  void initState() {
    _userReference =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _userReference.snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot userDoc = snapshot.data!;
            Map<String, dynamic> userData =
                userDoc.data() as Map<String, dynamic>;
            return Scaffold(
              backgroundColor: AppTheme.colors.shadecolor,
              appBar: AppBar(
                backgroundColor: AppTheme.colors.shadecolor,
                foregroundColor: AppTheme.colors.appWhiteColor,
                title: Text('Profile',
                style: TextStyle(
                  fontFamily: AppTheme.fonts.jost,
                  fontWeight: FontWeight.w600,
                  fontSize: 24
                ),),
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
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                               Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              userData['email'],
                              style: TextStyle(
                                  fontFamily: AppTheme.fonts.jost,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: AppTheme.colors.appWhiteColor),
                            ),
                          ),
                          UpdateUserImage(
                            onImageSelectedResipe: (image) {
                              imagePath = image;
                            },
                            odlImage: userData['userImage'],
                          ),
                     
                          MyTextFieldWoutBrd(
                              controllers: updateUserName,
                              hintText: userData['userName'],
                              labelText: 'UserName'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40),
                                ),
                                child: Text('CANCEL',
                                  style: TextStyle(
                                      fontSize: 15,
                                      letterSpacing: 2,
                                      color: AppTheme.colors.appBlackColor),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if(imagePath!=null){
                                     _newImageUrl =await updateProfile.updateImageUrl(
                                          userData['userImage'].toString(),
                                          imagePath!);
                                  }
                                  await updateProfile.updateProfileFn(
                                      (updateUserName.text.isEmpty)?userData['userName']:updateUserName.text,
                                      (_newImageUrl==null)?userData['userImage']!:_newImageUrl,
                                      user!.uid);
                                  setState(() {});
                                  FocusScope.of(context).unfocus();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          duration: const Duration(seconds: 3),
                                          backgroundColor:AppTheme.colors.appGreenColor,
                                          content:const Text('Successfully Updated')));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.colors.maincolor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                ),
                                child: Text('SAVE',
                                  style: TextStyle(
                                      fontSize: 15,
                                      letterSpacing: 2,
                                      color: AppTheme.colors.appBlackColor),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        });
  }
}
