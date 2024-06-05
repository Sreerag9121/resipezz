import 'package:flutter/material.dart';
import 'package:recipizz/pages/user/other/hiverecipeadd/myrecipes/my_recipe_show.dart';
import 'package:recipizz/pages/user/other/hiveupdaterecipe.dart/hiveupdateimage.dart';
import 'package:recipizz/pages/user/other/hiveupdaterecipe.dart/udatedirections.dart';
import 'package:recipizz/pages/user/other/hiveupdaterecipe.dart/updateingredients.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/add_description.dart';
import 'package:recipizz/services/database/hive/hive_open_box.dart';
import 'package:recipizz/services/database/hive/my_recipes/hive_recipe_fn.dart';
import 'package:recipizz/services/database/hive/my_recipes/my_recipe_model.dart';
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
  final _descriptioncontoller = TextEditingController();
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
    _descriptioncontoller.text=recipes.description;
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
                BorderlessTextFormField(
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
                BorderlessTextFormField(
                    controllers: _servingcontoller,
                    hintText: 'How many people can serve',
                    labelText: 'Serving *'),
                BorderlessTextFormField(
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
                    AddRecipeDescription(controllers: _descriptioncontoller),
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
                        userRecipeCrud.updateRecipeHive(
                          index:widget.index,
                          recipeNameController:_recipenamecontoller,
                          servingController:_servingcontoller,
                          timeRequiredController:_durationcontoller,
                          recipeImagePath:newImagePath.toString(),
                          recipeIngredients:_ingreadientsController
                              .map((controller) => controller.text)
                              .toList(),
                          recipeDirection:_directionsController
                              .map((controller) => controller.text)
                              .toList(),
                              descriptionController: _descriptioncontoller
                              
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HiveRecipeDetailsMain(
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
