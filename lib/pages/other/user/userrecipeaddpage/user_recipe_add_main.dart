import 'package:flutter/material.dart';
import 'package:recipizz/pages/tabs/admintab/createrecipe/add_recipe_main.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserRecipeMain extends StatelessWidget {
  const UserRecipeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        centerTitle: true,
        title: Text('My Recipes',
        style: TextStyle(
          color: AppTheme.colors.appWhiteColor,
          fontFamily: AppTheme.fonts.jost
        ),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
           icon:  Icon(Icons.arrow_back,
           color: AppTheme.colors.appWhiteColor,
           )),
      ),
      body: Container(

      ),

      floatingActionButton: FloatingActionButton(
      backgroundColor: AppTheme.colors.shadecolor,
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>const CreateRecipeMain())
          );
        },
      child:Icon(
        Icons.add,color: 
      AppTheme.colors.appWhiteColor,
      )
        ),
    );
  }
}