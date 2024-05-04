import 'package:flutter/material.dart';
import 'package:recipizz/utils/colors/colors.dart';
import 'package:recipizz/utils/fonts/appfonts.dart';


@immutable
class AppTheme{
  static const colors=AppColors();
  static const fonts=AppFonts();
  const AppTheme._();
  static ThemeData define(){
    return ThemeData();
  }
}