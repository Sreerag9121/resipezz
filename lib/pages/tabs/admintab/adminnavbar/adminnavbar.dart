import 'package:flutter/material.dart';
import 'package:recipizz/pages/tabs/admintab/createcategories/create_categories_main.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admin_home_main.dart';
import 'package:recipizz/pages/tabs/admintab/adminmenu/admin_menu.dart';
import 'package:recipizz/pages/tabs/admintab/createrecipe/recipes_main.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminNavBar extends StatefulWidget {
  const AdminNavBar({super.key});

  @override
  State<AdminNavBar> createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {
  int index=0;
  final screens=[
    const AdminHomePageMain(),
    const RecipesMain(),
    const CategotiesMain(),
    const AdminMenu(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: AppTheme.colors.appWhiteColor
        ),
        child: NavigationBar(
          backgroundColor: AppTheme.colors.shadecolor,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          height: 60,
          animationDuration: const Duration(seconds: 2),
          selectedIndex: index,

          onDestinationSelected: (index)=>
          setState(() {
            this.index=index;
          }),

          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon:Icon(Icons.home) ,
              label: 'Home',
              ),
               NavigationDestination(
              icon: Icon(Icons.add),
              selectedIcon: Icon(Icons.add),
              label: 'Create recipes',
              ), NavigationDestination(
              icon: Icon(Icons.apps_outlined),
              selectedIcon: Icon(Icons.apps_rounded),
              label: 'Add Categories',
              ), NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Menu',
              )
          ]
          ),
      ),
    );
  }
}