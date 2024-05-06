import 'package:flutter/material.dart';
import 'package:recipizz/pages/tabs/usertabs/favoritepage/favorite_grid.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/user_home_search.dart';
import 'package:recipizz/utils/app_theme.dart';

class FavroitePageMain extends StatelessWidget {
  const FavroitePageMain({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 40,),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Favorites',
              style: TextStyle(
                fontSize: 35,
                fontFamily: AppTheme.fonts.jost,
                color: AppTheme.colors.appWhiteColor,
              ),
            ),
          ),
          const SizedBox(height: 80,),
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
                  child: FavoriteGridView(),
                  ),
              )
              )
        ],
      )),
    );
  }
}
