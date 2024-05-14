import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recipizz/utils/app_theme.dart';

class OnBoardingPage1 extends StatelessWidget {
  const OnBoardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.colors.appWhiteColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20),
            width: 250,
            height: 300,
            child: Image.asset('assets/images/onboardingimgs/cook.png'),
          ),
          Text(
            'COOK',
              style: TextStyle(
                  fontFamily: AppTheme.fonts.mulish,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 10),
              ),
          Container(
            margin: const EdgeInsets.only(top: 90,bottom: 20),
            width: 350,
            child: Text(
              textAlign: TextAlign.center,
              'Crafting Flavors, Creating Memories, Cooking Nourishment For The Soul.',
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
