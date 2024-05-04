import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminRecipesIngredients extends StatefulWidget {
  final List<dynamic> ingredientsItems;
  const AdminRecipesIngredients({super.key, required this.ingredientsItems});

  @override
  State<AdminRecipesIngredients> createState() => _AdminRecipesIngredientsState();
}

class _AdminRecipesIngredientsState extends State<AdminRecipesIngredients> {
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          width: double.infinity,
          height: 70,
          color:AppTheme.colors.appRedColor,
          child: Row(
            children: [
               Icon(
                Icons.list,
                color: AppTheme.colors.appWhiteColor,
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
                'items ${widget.ingredientsItems.length}',
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
                  widget.ingredientsItems[index],
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
            itemCount: widget.ingredientsItems.length),
      ],
    );
  }
}
