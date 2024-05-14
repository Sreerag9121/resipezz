import 'package:flutter/material.dart';
import 'package:recipizz/auth/onboarding/onboarding_3.dart';
import 'package:recipizz/auth/onboarding/onboarding_1.dart';
import 'package:recipizz/auth/onboarding/onboarding_2.dart';
import 'package:recipizz/auth/userauth/loginpage/login_page.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingMain extends StatefulWidget {
  const OnBoardingMain({super.key});

  @override
  State<OnBoardingMain> createState() => _OnBoardingMainState();
}

class _OnBoardingMainState extends State<OnBoardingMain> {
  final controller =PageController();
  bool isLastPage=false;
  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller:controller ,
          onPageChanged: (index){
            setState(() {
              isLastPage=index==2;
            });
          },
          children: const [
            OnBoardingPage1(),
            OnBoardingPage2(),
            OnBoardingPage3(),
          ],       
        ),
      ),
      bottomSheet:isLastPage?
      Container(
        padding: const EdgeInsets.fromLTRB(60,15,60, 15),
        width: double.infinity,
        height: 80,
        color: AppTheme.colors.appWhiteColor,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppTheme.colors.maincolor,
          ),
          onPressed: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx)=>const LogInPage())
            );
          }, 
          child: Text(
            style: TextStyle(
              color: AppTheme.colors.appWhiteColor,
              fontFamily: AppTheme.fonts.jost,
            ),
           'GET STARTED' 
          )
          ),
      ):
       Container(
        color: AppTheme.colors.appWhiteColor,
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: (){
                controller.jumpToPage(2);
              },
               child:  Text('SKIP',
               style: TextStyle(
                color: AppTheme.colors.appBlackColor,
                fontFamily: AppTheme.fonts.jost
               ),
               ),
               ),
               Center(
                child: SmoothPageIndicator(
                  controller: controller, 
                  count: 3,
                  effect: WormEffect(
                    spacing: 16,
                    dotColor: AppTheme.colors.shadecolor,
                    activeDotColor: AppTheme.colors.maincolor
                  ),
                  onDotClicked: (index)=>controller.animateToPage
                  (index,
                   duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn
                    ),
                  ),
               ),
            TextButton(
              onPressed: (){
                controller.nextPage(
                  duration: const Duration(microseconds: 500),
                   curve: Curves.easeInOut);
              },
               child: Text('NEXT',
               style: TextStyle(
                color: AppTheme.colors.appBlackColor,
                fontFamily: AppTheme.fonts.jost
               ),
               ),
               )
          ],
        ),
      ),
    );
  }
}