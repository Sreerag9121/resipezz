import 'package:flutter/material.dart';
import 'package:recipizz/auth/splash_screen/splash_screen_service.dart';
import 'package:recipizz/utils/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashScreenService _service;

  @override
  void initState() {
    super.initState();
    _service = SplashScreenService(context);
    _service.getData();
    Future.delayed(const Duration(milliseconds: 1), () {
      _service.checkUserloggedin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppTheme.colors.shadecolor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  style: TextStyle(
                    fontFamily: AppTheme.fonts.mulish,
                    fontWeight: FontWeight.w600,
                  ),
                  'Get started with '),
              SizedBox(
                  width: 90,
                  height: 90,
                  child: Image.asset('assets/images/logo/app_icon-removebg.png')),
              
            ],
          ),
        ));
  }
}
