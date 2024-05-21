import 'package:flutter/material.dart';
import 'package:recipizz/services/functions/hive/cart_fn.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserRecipesIngredients extends StatefulWidget {
  final List<dynamic> ingredientsItems;
  const UserRecipesIngredients({super.key, required this.ingredientsItems});

  @override
  State<UserRecipesIngredients> createState() => _UserRecipesIngredientsState();
}

class _UserRecipesIngredientsState extends State<UserRecipesIngredients> {
  CartCrud cartCrud=CartCrud();
  
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
                leading: IconButton(onPressed: () {
                  cartCrud.addCart(cartList:widget.ingredientsItems[index].toString());
                }, icon: const Icon(Icons.add)),
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
