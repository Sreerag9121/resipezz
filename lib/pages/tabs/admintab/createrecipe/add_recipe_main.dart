import 'package:flutter/material.dart';
import 'package:recipizz/pages/tabs/admintab/createrecipe/add_description.dart';
import 'package:recipizz/pages/tabs/admintab/createrecipe/add_directions.dart';
import 'package:recipizz/pages/tabs/admintab/createrecipe/add_ingredients.dart';
import 'package:recipizz/pages/tabs/admintab/createrecipe/add_recipe_img.dart';
import 'package:recipizz/pages/tabs/admintab/createrecipe/select_categories.dart';
import 'package:recipizz/services/functions/adminfunctions/recipes_crud_functions.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/text_field_without_border.dart';

class CreateRecipeMain extends StatefulWidget {
  const CreateRecipeMain({super.key});

  @override
  State<CreateRecipeMain> createState() => _CreateRecipeMainState();
}

class _CreateRecipeMainState extends State<CreateRecipeMain> {
  final RecipesCurdOp recipesCurdOp = RecipesCurdOp();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _recipenamecontoller = TextEditingController();
  final _servingcontoller = TextEditingController();
  final _durationcontoller = TextEditingController();
  final _descriptionController=TextEditingController();
  String category = '';
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
                MyTextFieldWoutBrd(
                    controllers: _recipenamecontoller,
                    hintText: 'Enter the name of recipe',
                    labelText: 'Recipe name *'),
                CategoryDropDown(selectedCategory: (selectCategory) {
                  setState(() {
                    category = selectCategory!;
                  });
                }),
                AddRecipeImg(onImageSelectedResipe: (image) {
                  setState(() {
                    recipeImagePath = image ?? '';
                  });
                }),
                MyTextFieldWoutBrd(
                    controllers: _servingcontoller,
                    hintText: 'How many people can serve',
                    labelText: 'Serving *'),
                MyTextFieldWoutBrd(
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
                AddRecipeDescription(controllers: _descriptionController,),
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
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                if (recipeImagePath.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please select an image',
                                        style: TextStyle(
                                            color:
                                                AppTheme.colors.appWhiteColor),
                                      ),
                                      backgroundColor:
                                          AppTheme.colors.appRedColor,
                                    ),
                                  );
                                }
                               else if (category.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please select an Category',
                                        style: TextStyle(
                                            color:
                                                AppTheme.colors.appWhiteColor),
                                      ),
                                      backgroundColor:
                                          AppTheme.colors.appRedColor,
                                    ),
                                  );
                                }
                                else{
                                setState(() {
                                  isLoading = true;
                                });
                                await recipesCurdOp.addRecipeMethod(
                                 recipeNameController:  _recipenamecontoller,
                                  servingController:_servingcontoller,
                                  timeRequiredController:_durationcontoller,
                                  descriptionController: _descriptionController,
                                  recipeImagePath:recipeImagePath,
                                  recipeIngredients:ingreadientsController,
                                  recipeDirection:directionsController,
                                  categoresTagController:category,
                                  context:context,
                                );
                                setState(() {
                                  isLoading = false;
                                });
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                              }
                              }
                            },
                      child: Text(
                        'Create Recipe',
                        style: TextStyle(fontFamily: AppTheme.fonts.jost),
                      ),
                    ),
                    if (isLoading) const Center(child: CircularProgressIndicator()),
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
