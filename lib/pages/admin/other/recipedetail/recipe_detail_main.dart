import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/admin/other/recipedetail/recipe_description.dart';
import 'package:recipizz/pages/admin/other/recipedetail/recipe_details.dart';
import 'package:recipizz/pages/admin/other/recipedetail/recipe_direction.dart';
import 'package:recipizz/pages/admin/other/recipedetail/recipe_ingredients.dart';
import 'package:recipizz/pages/admin/tab/admin_navbar/adminnavbar.dart';
import 'package:recipizz/services/database/firebase/admin/categories_crud_functions.dart';
import 'package:recipizz/services/database/firebase/admin/recipes_crud_functions.dart';
import 'package:recipizz/services/database/firebase/admin/today_special_fn.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminRecipesMainPage extends StatefulWidget {
  final String? recipeId;
  const AdminRecipesMainPage({super.key, this.recipeId});

  @override
  State<AdminRecipesMainPage> createState() => _AdminRecipesMainPageState();
}

class _AdminRecipesMainPageState extends State<AdminRecipesMainPage> {
  final RecipesCurdOp recipesCurdOp = RecipesCurdOp();
  final CategoriesCrud categoriesCRUD = CategoriesCrud();
  final TodaySpecialCurd todaySpecialCurd = TodaySpecialCurd();
  late DocumentReference _recipeReferance;
  late Future<DocumentSnapshot> _recipeFutureData;
  @override
  void initState() {
    super.initState();
    _recipeReferance =
        FirebaseFirestore.instance.collection('recipes').doc(widget.recipeId);
    _recipeFutureData = _recipeReferance.get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        foregroundColor: AppTheme.colors.appWhiteColor,
        title: Text(
          'Recipes',
          style: TextStyle(fontFamily: AppTheme.fonts.jost),
        ),
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
                    AdminRecipeDetails(
                      recipename: recipeData['name'],
                      recipeImage: recipeData['recipeImage'],
                      duration: recipeData['timeRequired'],
                      serving: recipeData['serving'],
                    ),
                    AdminRecipesIngredients(
                        ingredientsItems: recipeData['ingredient']),
                    AdminRecipeDirection(
                        recipesDirection: recipeData['directions'],
                        timeRequired: recipeData['timeRequired']),
                    RecipeDescription(description: recipeData['description']),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await recipesCurdOp.deleteRcipes(widget.recipeId!);
                        await recipesCurdOp
                            .deleteRecipeImage(recipeData['recipeImage']);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.delete_outline),
                      label: Text(
                        ' Delete ',
                        style: TextStyle(fontFamily: AppTheme.fonts.jost),
                      ),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppTheme.colors.appRedColor),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppTheme.colors.appWhiteColor)),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                          await todaySpecialCurd.updateTodaySpecial(
                            recipeId: widget.recipeId!);
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(context, 
                        MaterialPageRoute(builder: (context)=>const AdminNavBar()));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppTheme.colors.shadecolor),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              AppTheme.colors.appWhiteColor)),
                      child: Text(
                        'Make Today Special',
                        style: TextStyle(fontFamily: AppTheme.fonts.jost),
                      ),
                    )
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
