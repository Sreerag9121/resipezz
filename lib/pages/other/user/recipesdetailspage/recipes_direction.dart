import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserRecipeDirection extends StatefulWidget {
  final List<dynamic> recipesDirection;
  final String? timeRequired;
  const UserRecipeDirection(
      {super.key, required this.recipesDirection, required this.timeRequired});

  @override
  State<UserRecipeDirection> createState() => _UserRecipeDirectionState();
}

class _UserRecipeDirectionState extends State<UserRecipeDirection> {
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
                Icons.directions_outlined,
                color: AppTheme.colors.appWhiteColor,
              ),
              Text(
                ' Direction to Prepare',
                style: TextStyle(
                    fontFamily: AppTheme.fonts.jost,
                    fontSize: 18,
                    color: AppTheme.colors.appWhiteColor),
              ),
              const SizedBox(
                width: 110,
              ),
              Text(
                'Steps-${widget.recipesDirection.length}',
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
                leading: Text('${index + 1}'),
                title: Text(
                  widget.recipesDirection[index],
                  style: TextStyle(fontFamily: AppTheme.fonts.jost),
                ),
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
            itemCount: widget.recipesDirection.length),
      ],
    );
  }
}
