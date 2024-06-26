import 'package:flutter/material.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/add_description.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/add_directions.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/add_ingredients.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/add_recipe_img.dart';
import 'package:recipizz/services/database/hive/my_recipes/hive_recipe_fn.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/text_field_without_border.dart';

class HiveAddRecipeMain extends StatefulWidget {
  const HiveAddRecipeMain({super.key});

  @override
  State<HiveAddRecipeMain> createState() => _HiveAddRecipeMainState();
}

class _HiveAddRecipeMainState extends State<HiveAddRecipeMain> {
  final UserRecipeCrud userRecipeCrud = UserRecipeCrud();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _recipenamecontoller = TextEditingController();
  final _servingcontoller = TextEditingController();
  final _durationcontoller = TextEditingController();
  final _descriptionController=TextEditingController();
  List<TextEditingController> ingreadientsController = [];
  List<TextEditingController> directionsController = [];
  List<String> ingreadientList = [];
  String recipeImagePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        title: Text(
          'Create Recipes',
          style: TextStyle(
            color: AppTheme.colors.appWhiteColor,
            fontFamily: AppTheme.fonts.jost,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              size: 25,
              color: AppTheme.colors.appWhiteColor,
            )),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                BorderlessTextFormField(
                    controllers: _recipenamecontoller,
                    hintText: 'Enter the name of recipe',
                    labelText: 'Recipe name *'),
                AddRecipeImg(onImageSelectedResipe: (image) {
                  setState(() {
                    recipeImagePath = image ?? '';
                  });
                }),
                BorderlessTextFormField(
                    controllers: _servingcontoller,
                    hintText: 'How many people can serve',
                    labelText: 'Serving *'),
                BorderlessTextFormField(
                    controllers: _durationcontoller,
                    hintText: 'Time required',
                    labelText: 'Duration *'),
                AddIngredients(onIngredientList: (ingredientController) {
                  setState(() {
                    ingreadientsController = ingredientController;
                  });
                }),
                AddDirections(onDirectionList: (directioncontroller) {
                  setState(() {
                    directionsController = directioncontroller;
                  });
                }),
                AddRecipeDescription(
                  controllers: _descriptionController
                  ),
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.colors.maincolor,
                        foregroundColor: AppTheme.colors.appWhiteColor,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (recipeImagePath.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Please select an image',
                                  style: TextStyle(
                                      color: AppTheme.colors.appWhiteColor),
                                ),
                                backgroundColor: AppTheme.colors.appRedColor,
                              ),
                            );
                          } else {
                            userRecipeCrud.addRecipeHive(
                              recipeNameController:_recipenamecontoller,
                              servingController:_servingcontoller,
                              timeRequiredController:_durationcontoller,
                              recipeImagePath:recipeImagePath,
                              recipeIngredients:ingreadientsController,
                              recipeDirection:directionsController,
                              descriptionController: _descriptionController
                            );
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Text(
                        'Create Recipe',
                        style: TextStyle(fontFamily: AppTheme.fonts.jost),
                      ),
                    ),
                    if (isLoading) const CircularProgressIndicator(),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
