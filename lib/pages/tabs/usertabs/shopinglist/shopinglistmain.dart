import 'package:flutter/material.dart';
import 'package:recipizz/pages/tabs/usertabs/shopinglist/shopinglistview.dart';
import 'package:recipizz/utils/app_theme.dart';

class ShopingList extends StatelessWidget {
  const ShopingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        title: Text('Shopping List',
        style: TextStyle(
          color: AppTheme.colors.appWhiteColor,
          fontFamily: AppTheme.fonts.jost,
          fontSize: 26,
        ),
        ),
        centerTitle: true,
        leading:Icon(Icons.arrow_back,
        size: 25,
        color: AppTheme.colors.appWhiteColor,
        ),
      ),

      body: const ShopingListView(),
    );
  }
}