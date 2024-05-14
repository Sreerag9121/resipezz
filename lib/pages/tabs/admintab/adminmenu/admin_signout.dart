import 'package:flutter/material.dart';
import 'package:recipizz/auth/userauth/loginpage/login_page.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AsignOutButton extends StatefulWidget {
  const AsignOutButton({super.key});

  @override
  State<AsignOutButton> createState() => _AsignOutButtonState();
}

class _AsignOutButtonState extends State<AsignOutButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      body: AlertDialog(
                  title:Text('Sign Out',
                  style: TextStyle(fontFamily:AppTheme.fonts.jost),),
                  content: const Text('Are you sure wanted to signout'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        return signout(context);
                      },
                      child: const Text('Yes'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('NO'),
                    ),
                  ],
                ),
    );
  }
}

void signout(BuildContext ctx) async {
  final sharedprefs = await SharedPreferences.getInstance();
  sharedprefs.clear();
  // ignore: use_build_context_synchronously
  Navigator.of(ctx).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (ctx1) => const LogInPage(),
      ),
      (route) => false);
}
