import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserRecipeDet extends StatelessWidget {
  final String? recipename;
  final String? recipeImage;
  final String? duration;
  final String? serving;
  const UserRecipeDet(
      {super.key,
      required this.recipename,
      required this.recipeImage,
      required this.duration,
      required this.serving});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: Image.network(
            recipeImage.toString(),
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) =>
                (loadingProgress == null)
                    ? child
                    : Center(child: Icon(Icons.photo,
                      color: AppTheme.colors.appGreyColor,
                    )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                recipename.toString(),
                style: TextStyle(
                  fontFamily: AppTheme.fonts.jost,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.clock,
                    size: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      'Ready in ${duration.toString()}',
                      style: TextStyle(
                          fontFamily: AppTheme.fonts.jost,
                          fontWeight: FontWeight.w700),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  'Serving:${serving.toString()} People',
                  style: TextStyle(
                      fontFamily: AppTheme.fonts.jost,
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
