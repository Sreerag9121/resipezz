import 'package:flutter/material.dart';
import 'package:recipizz/pages/tabs/usertabs/menu/Menumain/menu_main.dart';
import 'package:recipizz/pages/tabs/usertabs/favoritepage/favorite_main.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/home_main.dart';
import 'package:recipizz/pages/tabs/usertabs/shopinglist/shopinglistmain.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserNavBar extends StatefulWidget {
  const UserNavBar({super.key});

  @override
  State<UserNavBar> createState() => _UserNavBarState();
}

class _UserNavBarState extends State<UserNavBar> {
  int index=0;
  final screens=[
    const HomePageMain(),
    const FavroitePageMain(),
    const ShopingList(),
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
              icon: Icon(Icons.shopping_bag_outlined),
              selectedIcon: Icon(Icons.shopping_bag),
              label: 'Shoping List',
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