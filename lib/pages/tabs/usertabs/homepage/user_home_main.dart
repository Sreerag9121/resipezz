import 'package:flutter/material.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/user_home_categori.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/user_home_easy_quick.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/user_home_search.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/user-home_todayspecial.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserHomePageMain extends StatefulWidget {
  const UserHomePageMain({super.key});

  @override
  State<UserHomePageMain> createState() => _UserHomePageMainState();
}

class _UserHomePageMainState extends State<UserHomePageMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 30),
              child: Container(
                alignment: Alignment.centerLeft,
                width: 300,
                child: Text(
                  'What are you Cooking today?',
                  style: TextStyle(
                    fontSize: 35,
                    fontFamily: AppTheme.fonts.jost,
                    color: AppTheme.colors.background,
                  ),
                ),
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const UserTodaySpecialCard(),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                         child: Text(
                          'Categories',
                          style: TextStyle(
                            fontFamily: AppTheme.fonts.jost,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                                               ),
                       ),
                      const SizedBox(height: 101, child: CategoriesHomePage()),
                      const UserEasyAndQuick()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
