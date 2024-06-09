import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/admin/other/recipe_detail/recipe_detail_main.dart';
import 'package:recipizz/utils/app_theme.dart';

class RecipeCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const RecipeCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        color: AppTheme.colors.appWhiteColor,
        child: Center(
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AdminRecipesDetailPage(recipeId: data['id']),
                ),
              );
            },
            title: Text(
              data['name'],
              style: TextStyle(
                fontFamily: AppTheme.fonts.jost,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data['image']),
              radius: 25,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.clock,
                    size: 15,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${data['time']} min',
                    style: TextStyle(fontFamily: AppTheme.fonts.jost),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}