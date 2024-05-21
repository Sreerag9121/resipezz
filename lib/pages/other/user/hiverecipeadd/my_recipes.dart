import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipizz/pages/other/user/hiverecipeadd/my_recipe_add.dart';
import 'package:recipizz/pages/other/user/hiverecipeadd/myrecipes/my_recipe_show.dart';
import 'package:recipizz/services/functions/hive/hive_recipe_fn.dart';
import 'package:recipizz/services/functions/hive/recipes_hive.dart';
import 'package:recipizz/utils/app_theme.dart';

class HiveUserRecipeMain extends StatelessWidget {
  const HiveUserRecipeMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        title: Text(
          'My Recipes',
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
      body: ValueListenableBuilder(
          valueListenable: Boxes.getData().listenable(),
          builder: (context, recipeBox, _) {
            var recipes = recipeBox.values.toList().cast<RecipeModel>();
            return (recipes.isEmpty)
                ? Center(
                    child: Text(
                    'Add Recipes',
                    style: TextStyle(
                        color: AppTheme.colors.appBlackColor,
                        fontFamily: AppTheme.fonts.jost),
                  ))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        childAspectRatio: .8,
                      ),
                      itemCount: recipeBox.length,
                      itemBuilder: (context, index) {
                        var data = recipes[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => HiveRecipeDetailsMain(
                                index: index.toString(),
                              ),
                            ));
                          },
                          child: Card(
                            color: AppTheme.colors.appWhiteColor,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 110,
                                    width: 140,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(File(data.imagePath),fit: BoxFit.fill,),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 120,
                                      height: 40,
                                      child: Text(
                                        data.recipeName,
                                        style: TextStyle(
                                          fontFamily: AppTheme.fonts.jost,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 25),
                                    child: Row(
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.clock,
                                          size: 19,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          data.duration,
                                          style: TextStyle(
                                              color:AppTheme.colors.appBlackColor,
                                              fontFamily: AppTheme.fonts.jost),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.colors.shadecolor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const HiveAddRecipeMain(),
          ));
        },
        child: Icon(
          Icons.add,
          color: AppTheme.colors.appWhiteColor,
        ),
      ),
    );
  }
}
