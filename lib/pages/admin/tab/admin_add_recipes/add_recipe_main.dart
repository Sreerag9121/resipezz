import 'package:flutter/material.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/add_description.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/add_directions.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/add_ingredients.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/add_recipe_img.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/add_time.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/select_categories.dart';
import 'package:recipizz/services/database/firebase/admin/recipes_crud_functions.dart';
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
   String _duration = '';
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
                BorderlessTextFormField(
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
                BorderlessTextFormField(
                    controllers: _servingcontoller,
                    hintText: 'How many people can serve',
                    labelText: 'Serving *'),
                    AddReqTime(onSetTimeValue:(time){
                      _duration=time;
                    } ,),
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
                                  timeRequiredController:_duration,
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
