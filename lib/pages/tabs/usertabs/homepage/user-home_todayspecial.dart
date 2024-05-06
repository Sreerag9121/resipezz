import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserTodaySpecialCard extends StatefulWidget {
  const UserTodaySpecialCard({super.key});

  @override
  State<UserTodaySpecialCard> createState() => _UserTodaySpecialCardState();
}

class _UserTodaySpecialCardState extends State<UserTodaySpecialCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          color: AppTheme.colors.appWhiteColor,
          child: SizedBox(
            width: 330,
            height: 140,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Special Recipe',
                        style: TextStyle(
                            fontSize: 20, fontFamily: AppTheme.fonts.jost),
                      ),
                      Text(
                        'Today.',
                        style: TextStyle(
                            fontSize: 20, fontFamily: AppTheme.fonts.jost),
                      ),
                      Text(
                        'chicken teriyaki chow',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            fontFamily: AppTheme.fonts.jost),
                      ),
                      Row(
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.clock,
                            size: 18,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '2 hours',
                            style: TextStyle(
                                fontSize: 13, fontFamily: AppTheme.fonts.jost),
                          )
                        ],
                      )
                    ],
                  ),
      //foodphoto
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                            'assets/images/recipes/chicken theriyaki.jpg')),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
