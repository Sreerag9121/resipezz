import 'package:flutter/material.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/home_categori.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/home_easy&quick.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/home_search.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/home_todayspecial.dart';
import 'package:recipizz/utils/app_theme.dart';

class HomePageMain extends StatefulWidget {
  const HomePageMain({super.key});

  @override
  State<HomePageMain> createState() => _HomePageMainState();
}

class _HomePageMainState extends State<HomePageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What are you',
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: AppTheme.fonts.jost,
                      color: AppTheme.colors.appWhiteColor,
                    ),
                  ),
                  Text(
                    'Cooking today?',
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: AppTheme.fonts.jost,
                        color: AppTheme.colors.appWhiteColor),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: Container(
                width: double.infinity,
                height: 70,
                color: AppTheme.colors.appWhiteColor,
                child: const SearchBarHome(),
              ),
            ),
            Expanded(
                child: Container(
              color: AppTheme.colors.appWhiteColor,
              child: const SingleChildScrollView(
                child: Column(
                  children: [
                    TodaySpecialCard(),
                    CategoriesHomePage(),
                    EasyAndQuick(),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
