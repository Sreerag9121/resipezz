import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class RecipeDescription extends StatefulWidget {
  final String? description;
  const RecipeDescription({super.key, required this.description});

  @override
  State<RecipeDescription> createState() => _RecipeDescriptionState();
}

class _RecipeDescriptionState extends State<RecipeDescription> {
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
                Icons.description_outlined,
                color: AppTheme.colors.appWhiteColor,
              ),
              Text(
                ' Description',
                style: TextStyle(
                    fontFamily: AppTheme.fonts.jost,
                    fontSize: 18,
                    color: AppTheme.colors.appWhiteColor),
              ),
            ],
          ),
        ),
        ListTile(
          title: Text(
            widget.description.toString(),
            style: TextStyle(fontFamily: AppTheme.fonts.jost),
          ),
        ),
        Divider(
          color: AppTheme.colors.appGreyColor,
          height: 10,
          thickness: 1, 
          indent: 10, 
          endIndent: 10, 
        ),
      ],
    );
  }
}
