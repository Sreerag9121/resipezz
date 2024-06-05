import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage('assets/images/user/profile image.jpeg'),
            ),
            Text(
              'Sophia Johnson',
              style: TextStyle(
                  fontFamily: AppTheme.fonts.jost,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.colors.appWhiteColor),
            ),
            Text(
              'sophia.johnson@gmail.com',
              style: TextStyle(
                  fontFamily: AppTheme.fonts.jost,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.colors.appWhiteColor),
            ),
          
          ],
        );
  }
}