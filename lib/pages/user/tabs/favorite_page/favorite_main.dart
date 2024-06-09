import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipizz/pages/user/other/user_recipe_details/user_recipe_details_layout/user_recipe_detail_desktop.dart';
import 'package:recipizz/pages/user/other/user_recipe_details/user_recipe_details_layout/user_recipe_detail_mobile.dart';
import 'package:recipizz/services/database/hive/favorite/favorite_fn.dart';
import 'package:recipizz/services/database/hive/favorite/favorite_model.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/layout_builder.dart';

class FavoritetPageMain extends StatelessWidget {
  const FavoritetPageMain({super.key});

  @override
  Widget build(BuildContext context) {
     final mediaQuery =MediaQuery.of(context);
     final screenWidth=mediaQuery.size.width;
    FavoriteCrud favoriteCrud=FavoriteCrud();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        automaticallyImplyLeading: false,
        title: Text('Favroite',
          style: TextStyle(
            color: AppTheme.colors.appWhiteColor,
            fontFamily: AppTheme.fonts.jost,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
          valueListenable: FavoriteBoxes.getFavData().listenable(),
          builder: (context, favoriteBox, _) {
            var recipes = favoriteBox.values.toList().cast<FavoriteModel>();
            return (recipes.isEmpty)
                ? Center(
                    child: Text('No Favroite Added',
                    style: TextStyle(
                        color: AppTheme.colors.appBlackColor,
                        fontFamily: AppTheme.fonts.jost),
                  ))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GridView.builder(
                        itemCount: recipes.length,
                        gridDelegate:
                             SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:(screenWidth>600)?3:2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                          childAspectRatio: 0.8,
                        ),
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                            Navigator.push(context, 
                            MaterialPageRoute(builder: ((context) =>MyLayoutBuilder(
                                mobileBody: UserRecipesDetailMobile(recipeId:recipes[index].id,), 
                                deskTopBody:UserRecipeDetailDesktop(recipeId:recipes[index].id,) ) )));
                            },
                            child: Card(
                              color: AppTheme.colors.appWhiteColor,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    content: Text(
                                                      'Are You Wanted to Remove This From Favorite',
                                                      style: TextStyle(fontFamily: AppTheme.fonts.jost),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            favoriteCrud.removeRecipe(index);
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text('Yes',
                                                            style: TextStyle(
                                                                fontFamily:AppTheme.fonts.jost,
                                                                color: AppTheme.colors.appBlackColor),
                                                          )),
                                                          TextButton(onPressed: (){
                                                            Navigator.pop(context);
                                                          },
                                                           child: Text('No',
                                                            style: TextStyle(
                                                                fontFamily:AppTheme.fonts.jost,
                                                                color: AppTheme.colors.appBlackColor),
                                                          ))
                                                    ],);
                                                },);
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: AppTheme.colors.appRedColor,
                                            ))),
                                    AspectRatio(
                                      aspectRatio: 1.7,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          recipes[index].imagePath,
                                          fit: BoxFit.cover,
                                          loadingBuilder:(context, child, loadingProgress) =>
                                          (loadingProgress == null)
                                              ? child
                                              : SizedBox(
                                                width: double.infinity,
                                                height: double.infinity,
                                                child: Center(
                                                    child: Icon(
                                                      Icons.photo,
                                                      color: AppTheme.colors.appGreyColor,
                                                    ),
                                                  ),
                                              ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      recipes[index].recipeName,
                                      maxLines: 2,
                                      style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontFamily: AppTheme.fonts.jost,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const FaIcon(
                                          FontAwesomeIcons.clock,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 8,),
                                        Text(
                                          recipes[index].duration,
                                          style: TextStyle(
                                              fontFamily: AppTheme.fonts.jost),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
                  );
          }),
    );
  }
}
