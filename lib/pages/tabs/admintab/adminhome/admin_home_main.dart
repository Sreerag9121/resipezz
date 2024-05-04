import 'package:flutter/material.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admin_categori_home.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admin_easy_quick_home.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admin_search_home.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admin_today_spl.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminHomePageMain extends StatefulWidget {
  const AdminHomePageMain({super.key});

  @override
  State<AdminHomePageMain> createState() => _AdminHomePageMainState();
}

class _AdminHomePageMainState extends State<AdminHomePageMain> {
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
              padding: const EdgeInsets.fromLTRB(10, 40, 10, 30),
              child: Center(
                child: Text(
                  'Home Page',
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
                child: const AdminSearch(),
              ),
            ),
            Expanded(
              child: Container(
                color: AppTheme.colors.appWhiteColor,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const AdminTodaySpl(),
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
                      const SizedBox(height: 101, child: AdminCategoriHome()),
                      const AdminEasyAndQuick()
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
