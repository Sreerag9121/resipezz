import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class OnBoardingPage1 extends StatelessWidget {
  const OnBoardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.colors.appWhiteColor,
       width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            Container(
              alignment: Alignment.center, 
              margin: const EdgeInsets.only(left: 20),        
              width: 250,
              height: 300,
              child: Image.asset('assets/images/onboardingimgs/cook.png'),
            ),
            const SizedBox(
              height: 55,
            ),
            Text(
              style: TextStyle(
                fontFamily: AppTheme.fonts.mulish,
                fontSize: 40,
                fontWeight: FontWeight.w900,
                letterSpacing: 10
              ),
              'COOK'),
              const SizedBox(
                height: 40,
              ),
              const SizedBox(
                width: 350,
                child: Text(
                  textAlign: TextAlign.center,
                  'Crafting Flavors, Creating Memories, Cooking Nourishment For The Soul.'
                ),
              ),
          ],
        ),
    );
  }
}