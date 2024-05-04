import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminProfile extends StatelessWidget {
  const AdminProfile({super.key});

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
                  AssetImage('assets/images/user/admin-img.jpg'),
            ),
            Text(
              'Sreerag P',
              style: TextStyle(
                  fontFamily: AppTheme.fonts.jost,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.colors.appWhiteColor),
            ),
            Text(
              'Sreerag9121@gmail.com',
              style: TextStyle(
                  fontFamily: AppTheme.fonts.jost,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.colors.appWhiteColor),
            ),
          
          ],
        );
  }
}