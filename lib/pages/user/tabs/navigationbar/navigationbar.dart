import 'package:flutter/material.dart';
import 'package:recipizz/pages/user/tabs/my_recipe/my_recipes_grid.dart';
import 'package:recipizz/pages/user/tabs/home_page/home_layout_builder/user_home_desktop_view.dart';
import 'package:recipizz/widgets/layout_builder.dart';
import 'package:recipizz/pages/user/tabs/menu/Menumain/menu_main.dart';
import 'package:recipizz/pages/user/tabs/favorite_page/favorite_main.dart';
import 'package:recipizz/pages/user/tabs/home_page/home_layout_builder/user_home_mobile_view.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserNavBar extends StatefulWidget {
  const UserNavBar({super.key});

  @override
  State<UserNavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<UserNavBar> {
  int index=0;
  final screens=[
    const MyLayoutBuilder(
      mobileBody: UserHomeMobile(), 
      deskTopBody: UserHomeDesktop(),
      ),
    const FavoritetPageMain(),
    const HiveUserRecipeMain(),
    const MenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[index],

      bottomNavigationBar: NavigationBarTheme(
        data:NavigationBarThemeData(
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
              icon: Icon(Icons.favorite_border),
              selectedIcon: Icon(Icons.favorite),
              label: 'Favorite',
              ), NavigationDestination(
              icon: Icon(Icons.local_dining_outlined),
              selectedIcon: Icon(Icons.local_dining),
              label: 'My Recipes',
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