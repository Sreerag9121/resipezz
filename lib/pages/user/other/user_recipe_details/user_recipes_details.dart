import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/services/database/hive/favorite/favorite_fn.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserRecipeDetail extends StatefulWidget {
  final String? recipeId;
  final String? recipename;
  final String? recipeImage;
  final String? duration;
  final String? serving;
  final bool favoriteIcon;
  const UserRecipeDetail(
      {super.key,
      required this.recipeId,
      required this.recipename,
      required this.recipeImage,
      required this.duration,
      required this.serving,
      required this.favoriteIcon});

  @override
  State<UserRecipeDetail> createState() => _UserRecipeDetailState();
}

class _UserRecipeDetailState extends State<UserRecipeDetail> {
  late String id;
  bool iconData=false;
  @override
  void initState() {
    id = widget.recipeId.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    FavoriteCrud favoriteCrud = FavoriteCrud();
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Image.network(
            widget.recipeImage.toString(),
            fit: BoxFit.fill,
            loadingBuilder: (context, child, loadingProgress) =>
                (loadingProgress == null)
                    ? child
                    : Center(
                        child: Icon(
                        Icons.photo,
                        color: AppTheme.colors.appGreyColor,
                      )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width:(screenWidth>600)? screenWidth*.4:screenWidth*.8,
                child: Text(
                  widget.recipename.toString(),
                  maxLines: 2,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: AppTheme.fonts.jost,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                child: (widget.favoriteIcon || iconData)
                    ? IconButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(seconds: 1),
                              backgroundColor: AppTheme.colors.appRedColor,
                              content: const Text('Already in favorite')));
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: AppTheme.colors.appRedColor,
                        ))
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            favoriteCrud.addFavorite(id: id);
                            iconData=true;
                          });
                          
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: const Duration(seconds: 1),
                              backgroundColor: AppTheme.colors.appGreenColor,
                              content: const Text('successfully added')));
                        },
                        icon: const Icon(Icons.favorite_outline)),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width:(screenWidth>600)? screenWidth/4:screenWidth*.5,
                child: Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.clock,
                      size: 17,
                    ),
                    Text(
                      ' Ready in ${widget.duration.toString()} hr',
                      style: TextStyle(
                          fontFamily: AppTheme.fonts.jost,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
              Text(
                'Serving:${widget.serving.toString()} People',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: AppTheme.fonts.jost,
                    fontWeight: FontWeight.w700),
              )
            ],
          ),
        ),
      ],
    );
  }
}
