import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class RecipesIngredients extends StatefulWidget {
  const RecipesIngredients({super.key});

  @override
  State<RecipesIngredients> createState() => _RecipesIngredientsState();
}

class _RecipesIngredientsState extends State<RecipesIngredients> {
  final List<String> ingredientsItems = [
    '1 cub chicken breast, cubed',
    'salt,to taste',
    'pepper,to taste',
    '1/2cup teriyaki sauce,divided',
    'chow mein noodle(180 g), hong kong style pan fried noodles, par cooked according to package instructions',
    '3/4 cup onion,sliced',
    '1/2 cup carrot,julienned',
    '1 cup broccoli floret',
    'sesame seeds,for garnish'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          height: 70,
          color: AppTheme.colors.appRedColor,
          child: Row(
            children: [
               Icon(
                Icons.list,
                color:AppTheme.colors.appWhiteColor ,
              ),
              Text(
                ' Ingredients Required',
                style: TextStyle(
                    fontFamily: AppTheme.fonts.jost,
                    fontSize: 18,
                    color: AppTheme.colors.appWhiteColor),
              ),
              const SizedBox(
                width: 110,
              ),
              Text(
                'items ${ingredientsItems.length}',
                style: TextStyle(
                    fontFamily: AppTheme.fonts.jost, color: AppTheme.colors.appWhiteColor),
              )
            ],
          ),
        ),
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  ingredientsItems[index],
                  style: TextStyle(fontFamily: AppTheme.fonts.jost),
                ),
                leading: IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(
                  color: AppTheme.colors.appGreyColor,
                  thickness: 1.0,
                  height: 0.0,
                ),
              );
            },
            itemCount: ingredientsItems.length),
      ],
    );
  }
}
