import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/user/hiverecipeadd/userrecipesdetails/user_recipes_details_main.dart';
import 'package:recipizz/pages/other/user/hiveupdaterecipe.dart/hiveupdateimage.dart';
import 'package:recipizz/pages/other/user/hiveupdaterecipe.dart/udatedirections.dart';
import 'package:recipizz/pages/other/user/hiveupdaterecipe.dart/updateingredients.dart';
import 'package:recipizz/services/functions/hive/hive_open_box.dart';
import 'package:recipizz/services/functions/hive/hive_recipe_fn.dart';
import 'package:recipizz/services/functions/hive/recipes_hive.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/text_field_without_border.dart';

class HiveUpdareRecipeMain extends StatefulWidget {
  final String index;
  const HiveUpdareRecipeMain({super.key, required this.index});

  @override
  State<HiveUpdareRecipeMain> createState() => _HiveUpdareRecipeMainState();
}

class _HiveUpdareRecipeMainState extends State<HiveUpdareRecipeMain> {
  late RecipeModel recipes;
  final UserRecipeCrud userRecipeCrud = UserRecipeCrud();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _recipenamecontoller = TextEditingController();
  final _servingcontoller = TextEditingController();
  final _durationcontoller = TextEditingController();
  List<TextEditingController> _ingreadientsController = [];
  List<TextEditingController> _directionsController = [];
  List<String> ingreadientList = [];
  String oldImagePath = '';
  String newImagePath='';
  late List<String> editingredientsList;
  late List<String> editDirectionList;

  @override
  void initState() {
    super.initState();
    recipes = recipeBox.getAt(int.parse(widget.index))!;
    _recipenamecontoller.text = recipes.recipeName;
    _servingcontoller.text = recipes.serving;
    _durationcontoller.text = recipes.duration;
    oldImagePath = recipes.imagePath;
    editingredientsList = recipes.ingredients;
    editDirectionList = recipes.directions;
  }

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
                UpdateHiveImage(
                  oldImages: oldImagePath,
                  onImageSelected: (image) {
                  setState(() {
                    newImagePath = image ??'';
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
                UpdateIngredients(
                    editList: editingredientsList,
                    onIngredientList: (ingredientController) {
                      setState(() {
                        _ingreadientsController = ingredientController;
                      });
                    }),
                UpdateDirections(
                    editList: editDirectionList,
                    onDirectionList: (directioncontroller) {
                      setState(() {
                        _directionsController = directioncontroller;
                      });
                    }),
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
                        userRecipeCrud.UpdateRecipeHive(
                          widget.index,
                          _recipenamecontoller,
                          _servingcontoller,
                          _durationcontoller,
                          newImagePath.toString(),
                          _ingreadientsController
                              .map((controller) => controller.text)
                              .toList(),
                          _directionsController
                              .map((controller) => controller.text)
                              .toList(),
                        );
                       
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserRecipeDetailsMain(
                                    index: widget.index)));
                      },
                      child: Text('Create Recipe',
                      style: TextStyle(
                        fontFamily: AppTheme.fonts.jost
                      ),
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
