import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/admin/recipedetail/recipe_description.dart';
import 'package:recipizz/pages/other/admin/recipedetail/recipe_direction.dart';
import 'package:recipizz/pages/other/admin/recipedetail/recipe_ingredients.dart';
import 'package:recipizz/pages/other/user/hiverecipeadd/my_recipes.dart';
import 'package:recipizz/pages/other/user/hiverecipeadd/myrecipes/my_recipes_details.dart';
import 'package:recipizz/services/functions/hive/hive_open_box.dart';
import 'package:recipizz/services/functions/hive/recipes_hive.dart';
import 'package:recipizz/utils/app_theme.dart';

class HiveRecipeDetailsMain extends StatefulWidget {
  final String index;
  const HiveRecipeDetailsMain({super.key, required this.index});

  @override
  State<HiveRecipeDetailsMain> createState() => _HiveRecipeDetailsMainState();
}

class _HiveRecipeDetailsMainState extends State<HiveRecipeDetailsMain> {
  late RecipeModel recipes;

  @override
  void initState() {
    super.initState();
    recipes = recipeBox.getAt(int.parse(widget.index))!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        title: Text(
          recipes.recipeName,
          style: TextStyle(
            color: AppTheme.colors.appWhiteColor,
            fontFamily: AppTheme.fonts.jost,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const HiveUserRecipeMain())),
            icon: Icon(
              Icons.arrow_back,
              size: 25,
              color: AppTheme.colors.appWhiteColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              HiveRecipeDetails(
                  recipename: recipes.recipeName,
                  recipeImage: recipes.imagePath,
                  duration: recipes.duration,
                  serving: recipes.serving),
              AdminRecipesIngredients(ingredientsItems: recipes.ingredients),
              AdminRecipeDirection(
                  recipesDirection: recipes.directions,
                  timeRequired: recipes.duration),
              RecipeDescription(description: recipes.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ConstrainedBox(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        recipeBox.deleteAt(int.parse(widget.index));
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: Text(
                        'Delete',
                        style: TextStyle(fontFamily: AppTheme.fonts.jost),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppTheme.colors.appRedColor),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppTheme.colors.appWhiteColor)),
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 100,
                      maxWidth: 200,
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.edit_outlined),
                      label: Text(
                        'Edit  ',
                        style: TextStyle(fontFamily: AppTheme.fonts.jost),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppTheme.colors.appGreyColor),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppTheme.colors.appWhiteColor)),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
