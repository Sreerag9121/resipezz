import 'package:flutter/material.dart';
import 'package:recipizz/services/database/hive/cart/cart_fn.dart';
import 'package:recipizz/services/database/hive/cart/cart_model.dart';
import 'package:recipizz/services/database/hive/hive_open_box.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserRecipesIngredients extends StatefulWidget {
  final List<dynamic> ingredientsItems;
  const UserRecipesIngredients({super.key, required this.ingredientsItems});

  @override
  State<UserRecipesIngredients> createState() => _UserRecipesIngredientsState();
}

class _UserRecipesIngredientsState extends State<UserRecipesIngredients> {
  CartCrud cartCrud = CartCrud();
  ValueNotifier<List<String>> iconListNotifier =
      ValueNotifier<List<String>>([]);
  List<String> iconList = [];
  var ingredients = cartBox.values.toList().cast<CartModel>();

  void getIconchange() {
    for (int i = 0; i < ingredients.length; i++) {
      iconList.add(ingredients[i].cartList.toString());
    }
    iconListNotifier.value = iconList;
  }

  @override
  void initState() {
    getIconchange();
    super.initState();
  }

  @override
  void dispose() {
    iconListNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: iconListNotifier,
        builder: (context, iconList, child) {
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
                          fontFamily: AppTheme.fonts.jost,
                          color: AppTheme.colors.appWhiteColor),
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
                      leading: (iconList
                              .contains(widget.ingredientsItems[index]))
                          ? IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: const Text(
                                    'Already in Shoping List',
                                  ),
                                  duration: const Duration(seconds: 1),
                                  backgroundColor: AppTheme.colors.appRedColor,
                                ));
                              },
                              icon: Icon(
                                Icons.check,
                                color: AppTheme.colors.appGreenColor,
                              ))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  iconListNotifier.value = List.from(iconList)
                                    ..add(widget.ingredientsItems[index]
                                        .toString());
                                  cartCrud.addCart(
                                      cartList: widget.ingredientsItems[index]
                                          .toString());
                                });
                              },
                              icon: const Icon(Icons.add)),
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
        });
  }
}
