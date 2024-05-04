import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/user/recipesmainpage/recipes_details.dart';
import 'package:recipizz/pages/other/user/recipesmainpage/recipes_direction.dart';
import 'package:recipizz/pages/other/user/recipesmainpage/recipes_ingredients.dart';
import 'package:recipizz/utils/app_theme.dart';

class RecipesMainPage extends StatelessWidget {
  const RecipesMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        title:Text('Chicken Teriyaki chow Mein',
        style: TextStyle(
          color: AppTheme.colors.appWhiteColor
        ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          icon:Icon(Icons.arrow_back,
          color: AppTheme.colors.appWhiteColor,
          )
        ),
      ),

      body: const Center(
        child: SingleChildScrollView(
          child: Column(
            children: [

              //recipepage photo and details
              RecipeDetails(),
              //Recipes Ingredints view
              RecipesIngredients(),
              //Recipe direction view
              RecipeDirection()
            ],
          ),
        ),
      ),
    );
  }
}
