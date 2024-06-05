import 'package:flutter/material.dart';
import 'package:recipizz/pages/admin/tab/admin_add_category/create_categories_main.dart';
import 'package:recipizz/pages/admin/tab/admin_home_page/admin_home_main.dart';
import 'package:recipizz/pages/admin/tab/admin_menu/admin_menu.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/recipes_main.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminNavBar extends StatefulWidget {
  const AdminNavBar({super.key});

  @override
  State<AdminNavBar> createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {
  int index=0;
  final screens=[
    const AdminHomePage(),
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