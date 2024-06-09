import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/user/other/user_recipe_details/user_recipes_description.dart';
import 'package:recipizz/pages/user/other/user_recipe_details/user_recipes_details.dart';
import 'package:recipizz/pages/user/other/user_recipe_details/user_recipes_direction.dart';
import 'package:recipizz/pages/user/other/user_recipe_details/user_recipe_ingredients.dart';
import 'package:recipizz/services/database/hive/favorite/favorite_model.dart';
import 'package:recipizz/services/database/hive/hive_open_box.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserRecipesDetailMobile extends StatefulWidget {
  final String? recipeId;
  const UserRecipesDetailMobile({super.key, this.recipeId});

  @override
  State<UserRecipesDetailMobile> createState() => _UserRecipesDetailMobileState();
}

class _UserRecipesDetailMobileState extends State<UserRecipesDetailMobile> {
  ValueNotifier<List<String>> iconListNotifier = ValueNotifier<List<String>>([]);
  List<String> iconList = [];
  late DocumentReference _recipeReferance;
  late Future<DocumentSnapshot> _recipeFutureData;
  late bool favoriteIcon;
  var recipes = favoriteBox.values.toList().cast<FavoriteModel>();

    void getIconList() {
    for (int i = 0; i < recipes.length; i++) {
      iconList.add(recipes[i].id.toString());
    }
    iconListNotifier.value = iconList;
  }

  @override
  void initState() {
    getIconList();
    _recipeReferance =
        FirebaseFirestore.instance.collection('recipes').doc(widget.recipeId);
    _recipeFutureData = _recipeReferance.get();
    favoriteIcon=(iconList.contains(widget.recipeId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colors.shadecolor,
          foregroundColor: AppTheme.colors.appWhiteColor,
          title: Text('Recipes',
              style: TextStyle(fontFamily: AppTheme.fonts.jost)),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
              )),
        ),
        body: FutureBuilder(
            future: _recipeFutureData,
            builder: (BuildContext context, AsyncSnapshot snapShot) {
              if (snapShot.hasData) {
                DocumentSnapshot recipeDocSnapShot = snapShot.data;
                Map recipeData = recipeDocSnapShot.data() as Map;
                return SingleChildScrollView(
                  child: Column(
                    children: [
//recipe details
                      UserRecipeDetail(
                        recipeId: widget.recipeId,
                        recipename: recipeData['name'],
                        recipeImage: recipeData['recipeImage'],
                        duration: recipeData['timeRequired'],
                        serving: recipeData['serving'],
                        favoriteIcon: favoriteIcon,
                      ),
//ingredients                      
                      UserRecipesIngredients(
                          ingredientsItems: recipeData['ingredient']),
//directions
                      UserRecipeDirection(
                          recipesDirection: recipeData['directions'],
                          timeRequired: recipeData['timeRequired']),
//description
                      UserRecipeDescription(description: recipeData['description'])
                    ],
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
