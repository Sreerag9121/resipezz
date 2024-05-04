import 'package:flutter/material.dart';
import 'package:recipizz/pages/tabs/admintab/createrecipe/add_directions.dart';
import 'package:recipizz/pages/tabs/admintab/createrecipe/add_ingredients.dart';
import 'package:recipizz/pages/tabs/admintab/createrecipe/add_recipe_img.dart';
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

  final _recipenamecontoller = TextEditingController();
  final _servingcontoller = TextEditingController();
  final _durationcontoller = TextEditingController();
  final _categorycontoller = TextEditingController();
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
          icon: Icon(Icons.arrow_back,
          size: 25,
          color: AppTheme.colors.appWhiteColor,)
          
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              MyTextFieldWoutBrd(
                  controllers: _recipenamecontoller,
                  hintText: 'Enter the name of recipe',
                  labelText: 'Recipe name *'),
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
              const SizedBox(
                height: 30,
              ),
              MyTextFieldWoutBrd(
                  controllers: _categorycontoller,
                  hintText: 'Input Category Tag',
                  labelText: 'Category Tags *(Separate each tag with , )'),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.colors.maincolor,
                      foregroundColor: AppTheme.colors.appWhiteColor),
                  onPressed: () async {
                    await recipesCurdOp.addRecipeMethod(
                        _recipenamecontoller,
                        _servingcontoller,
                        _durationcontoller,
                        recipeImagePath,
                        ingreadientsController,
                        directionsController,
                        _categorycontoller);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  child: const Text('Create Recipe')),
            ],
          ),
        ),
      )),
    );
  }
}
