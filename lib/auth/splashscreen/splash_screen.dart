import 'package:flutter/material.dart';
import 'package:recipizz/auth/onboarding/onboarding_main.dart';
import 'package:recipizz/pages/tabs/admintab/adminnavbar/adminnavbar.dart';
import 'package:recipizz/pages/tabs/usertabs/navigationbar/navigationbar.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/utils/constance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
String?token;
getData()async{
  SharedPreferences pref=await SharedPreferences.getInstance();
  token=pref.getString('token');
 
}

   @override
  void initState() {
    getData();
    Future.delayed(const Duration(milliseconds: 1),
    (){
      checkUserloggedin();
    }
    );

    super.initState();
  }

Future<void>checkUserloggedin()async{
  if(token==null){
      checkAdminLoggedIn();
  }else{
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const UserNavBar()));
  }
}
 Future<void>checkAdminLoggedIn()async{
 final sharedprefadmin = await SharedPreferences.getInstance();
  final logged = sharedprefadmin.getBool(saveKey);
    if(logged==null || logged == false){
      gotologin();
    }else{
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx)=>const AdminNavBar())
      );
    }
  }

  Future<void> gotologin() async {
    await Future.delayed(const Duration(seconds: 3));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const OnBoardingMain() ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 130,
              height: 130,
              child: Image.asset('assets/images/logo/logo-1.png')
            ),
            Text(
              style: TextStyle(
                fontFamily: AppTheme.fonts.mulish,
                fontWeight: FontWeight.w600,
              ),
              'Get started with '
              ),
              Text(
                style: TextStyle(
                  color: AppTheme.colors.appBlackColor,
                  fontFamily: AppTheme.fonts.mysteryQuest,
                  fontSize: 40.0,
                ),
                'ReciPizz'
              )
          ],
          ),
      ) 
      );
  }

}