import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/user/recipesdetailspage/recipes_description.dart';
import 'package:recipizz/pages/other/user/recipesdetailspage/recipes_details.dart';
import 'package:recipizz/pages/other/user/recipesdetailspage/recipes_direction.dart';
import 'package:recipizz/pages/other/user/recipesdetailspage/recipes_ingredients.dart';
import 'package:recipizz/utils/app_theme.dart';

class RecipesMainPage extends StatefulWidget {
  final String? recipeId;
  const RecipesMainPage({super.key, this.recipeId});

  @override
  State<RecipesMainPage> createState() => _RecipesMainPageState();
}

class _RecipesMainPageState extends State<RecipesMainPage> {
  late DocumentReference _recipeReferance;
  late Future<DocumentSnapshot> _recipeFutureData;
  @override
  void initState() {
    _recipeReferance =
        FirebaseFirestore.instance.collection('recipes').doc(widget.recipeId);
    _recipeFutureData = _recipeReferance.get();
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
                      UserRecipeDet(
                        recipename: recipeData['name'],
                        recipeImage: recipeData['recipeImage'],
                        duration: recipeData['timeRequired'],
                        serving: recipeData['serving'],
                      ),
                      UserRecipesIngredients(
                          ingredientsItems: recipeData['ingredient']),
                      UserRecipeDirection(
                          recipesDirection: recipeData['directions'],
                          timeRequired: recipeData['timeRequired']),
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