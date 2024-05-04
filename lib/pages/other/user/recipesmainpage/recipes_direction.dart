import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class RecipeDirection extends StatefulWidget {
  const RecipeDirection({super.key});

  @override
  State<RecipeDirection> createState() => _RecipeDirectionState();
}

class _RecipeDirectionState extends State<RecipeDirection> {
  final directions = [
    'In a medium bowl, season the cubed chicken with salt and pepper. Add ¼ cup (of 60 ml) teriyaki sauce and mix until the chicken is well-coated. Cover with plastic wrap and marinate in the refrigerator for 30 minutes to 1 hour.',
    'In a wok or deep skillet over medium-high heat, heat 2 tablespoons of cooking oil, then add the par-cooked noodles. Cook for 1-2 minutes, allowing the noodles to crisp, then flip and cook for another 1-2 minutes. Transfer to a plate and set aside.',
    'In the same wok, heat 1 tablespoon of cooking oil, then add the chicken. Cook for 3-4 minutes, until browned on one side, then stir and cook for another 3-4 minutes, until fully cooked through. Set the chicken aside.',
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
                'Steps-${directions.length}',
                style: TextStyle(
                    fontFamily: AppTheme.fonts.jost, color: AppTheme.colors.appWhiteColor),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppTheme.colors.appGreyColor)
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    'Total time',
                    style: TextStyle(
                        fontFamily: AppTheme.fonts.jost,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '1hr 43 min',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Prep time',
                    style: TextStyle(
                        fontFamily: AppTheme.fonts.jost,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '25 min',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Cook time',
                    style: TextStyle(
                        fontFamily: AppTheme.fonts.jost,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    '18 min',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
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
                  directions[index],
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
            itemCount: directions.length)
      ],
    );
  }
}
