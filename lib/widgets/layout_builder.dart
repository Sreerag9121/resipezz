import 'package:flutter/material.dart';

class MyLayoutBuilder extends StatelessWidget {
  final Widget mobileBody;
  final Widget deskTopBody;
  const MyLayoutBuilder({super.key,required this.mobileBody,required this.deskTopBody});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constrains){
        if(constrains.maxWidth<600){
          return mobileBody;
        }
        return deskTopBody;
      }
      );
  }
}