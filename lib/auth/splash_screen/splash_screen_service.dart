// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:recipizz/auth/onboarding/onboarding_main.dart';
import 'package:recipizz/pages/admin/tab/admin_navbar/adminnavbar.dart';
import 'package:recipizz/pages/user/tabs/navigationbar/navigationbar.dart';
import 'package:recipizz/utils/constance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenService {
  final BuildContext context;
  String? token;

  SplashScreenService(this.context);

  void getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    token = pref.getString('token');
  }

  void checkUserloggedin() async {
    if (token == null) {
      checkAdminLoggedIn();
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => const UserNavBar()));
    }
  }

  void checkAdminLoggedIn() async {
    final sharedprefadmin = await SharedPreferences.getInstance();
    final logged = sharedprefadmin.getBool(saveKey);
    if (logged == null || logged == false) {
      gotologin();
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => const AdminNavBar()));
    }
  }

  void gotologin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const OnBoardingMain()));
  }
}
