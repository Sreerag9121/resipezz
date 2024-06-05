import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class OnBoardingPage3 extends StatelessWidget {
  const OnBoardingPage3({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.colors.appWhiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center, 
              margin: const EdgeInsets.only(left: 20),        
              width: 250,
              height: 300,
              child: Image.asset('assets/images/onboardingimgs/serve.png'),
            ),

            Text(
              style: TextStyle(
                fontFamily: AppTheme.fonts.mulish,
                fontSize: 40,
                fontWeight: FontWeight.w900,
                letterSpacing: 10
              ),
              'SERVE'),
              Container(
            margin: const EdgeInsets.only(top: 90,bottom: 20),
            width: 350,
            child: Text(
              textAlign: TextAlign.center,
              'Delight guests with exquisite dishes served with finesse and flair.',
              style: TextStyle(
                  color: AppTheme.colors.appBlackColor,
                  fontFamily: AppTheme.fonts.jost),
            ),
          ),
          ],
        ),
    );
  }
}
// 