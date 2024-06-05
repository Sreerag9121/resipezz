import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipizz/utils/app_theme.dart';

class OnBoardingPage2 extends StatelessWidget {
  const OnBoardingPage2({super.key});

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
            child: Image.asset('assets/images/onboardingimgs/learn.png'),
          ),
          Text(
            'LEARN',
            style: TextStyle(
                fontFamily: AppTheme.fonts.mulish,
                fontSize: 40,
                fontWeight: FontWeight.w900,
                letterSpacing: 10),
          ),
          Container(
            margin: const EdgeInsets.only(top: 90, bottom: 20),
            width: 350,
            child: Text(
                textAlign: TextAlign.center,
                'Unlock The art Of Cooking Through Hands-On Lessons And Guidance',
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
