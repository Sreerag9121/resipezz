import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/auth/userauth/loginpage/login_page.dart';
import 'package:recipizz/services/functions/userfunctions/user_fire_auth_function.dart';
import 'package:recipizz/utils/app_theme.dart';

class SignOutButton extends StatefulWidget {
  const SignOutButton({super.key});

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  final user = FirebaseAuth.instance.currentUser;
    final AuthServices _authService = AuthServices();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      body: AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure wanted to signout'),
        actions: [
          TextButton(
            onPressed: () async {
             await _authService.logOut();
             // ignore: use_build_context_synchronously
             Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context)=>const LogInPage()), (route) => false);
            },
            child: Text('Yes',
            style: TextStyle(fontFamily: AppTheme.fonts.jost),),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('NO',
            style: TextStyle(fontFamily: AppTheme.fonts.jost),),
          ),
        ],
      ),
    );
  }

}

