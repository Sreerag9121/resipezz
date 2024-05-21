import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipizz/services/functions/hive/hive_open_box.dart';
import 'package:recipizz/services/functions/hive/recipes_hive.dart';

class Boxes {
  static Box<RecipeModel> getData() => Hive.box<RecipeModel>('recipeBox');
}

class UserRecipeCrud {
  Future<void> addRecipeHive({
   required TextEditingController recipeNameController,
   required  TextEditingController servingController,
   required  TextEditingController timeRequiredController,
   required  TextEditingController descriptionController,
   required  String recipeImagePath,
   required  List<TextEditingController> recipeIngredients,
   required  List<TextEditingController> recipeDirection,
  }) async {
    List<String> recipeIngredientList = [];
    List<String> recipeDirectionList = [];
    String uniqueTime = DateTime.now().microsecondsSinceEpoch.toString();
    for (var controllers in recipeIngredients) {
      recipeIngredientList.add(controllers.text);
    }
    for (var controllers in recipeDirection) {
      recipeDirectionList.add(controllers.text);
    }
    recipeBox.put(
        uniqueTime,
        RecipeModel(
            recipeName: recipeNameController.text,
            serving: servingController.text,
            duration: timeRequiredController.text,
            imagePath: recipeImagePath,
            ingredients: recipeIngredientList,
            directions: recipeDirectionList,
            description: descriptionController.text
            ));
  }

  Future<void> updateRecipeHive({
   required String index,
   required TextEditingController recipeNameController,
   required TextEditingController servingController,
   required TextEditingController timeRequiredController,
   required TextEditingController descriptionController,
   required String recipeImagePath,
   required List<String> recipeIngredients,
   required List<String> recipeDirection,
  }) async {
    RecipeModel recipes = recipeBox.getAt(int.parse(index))!;
     recipes.recipeName=recipeNameController.text;
     recipes.serving=servingController.text;
     recipes.duration=timeRequiredController.text;
     recipes.imagePath=(recipeImagePath.isNotEmpty)?recipeImagePath:recipes.imagePath;
    recipes.ingredients=(recipeIngredients.isEmpty)?recipes.ingredients:recipeIngredients;
    recipes.directions=(recipeDirection.isEmpty)?recipes.directions:recipeDirection;
    recipes.description=descriptionController.text;
  }
}
