import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipizz/pages/user/tabs/my_recipe/my_recipe_add.dart';
import 'package:recipizz/pages/user/tabs/my_recipe/my_recipes_detail/my_recipe_detail_page.dart';
import 'package:recipizz/services/database/hive/my_recipes/hive_recipe_fn.dart';
import 'package:recipizz/services/database/hive/my_recipes/my_recipe_model.dart';
import 'package:recipizz/utils/app_theme.dart';

class HiveUserRecipeMain extends StatelessWidget {
  const HiveUserRecipeMain({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery =MediaQuery.of(context);
    final screenWidth=mediaQuery.size.width;
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
        automaticallyImplyLeading: false,
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
                       SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:(screenWidth>600)?3:2,
                        crossAxisSpacing: 4,
                        mainAxisSpacing: 4,
                        childAspectRatio: .9,
                      ),
                      itemCount: recipeBox.length,
                      itemBuilder: (context, index) {
                        var data = recipes[index];
                        return InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => MyRecipeDetailsPage(
                                index: index.toString(),
                              ),
                            ));
                          },
                          child: Card(
                            color: AppTheme.colors.appWhiteColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1.7,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.file(File(data.imagePath),fit: BoxFit.cover,),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    data.recipeName,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontFamily: AppTheme.fonts.jost,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.clock,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8,),
                                      Text(
                                        '${data.duration} hr',
                                        style: TextStyle(
                                            color:AppTheme.colors.appBlackColor,
                                            fontFamily: AppTheme.fonts.jost),
                                      ),
                                    ],
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
