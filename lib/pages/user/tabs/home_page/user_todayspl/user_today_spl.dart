import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/admin/tab/admin_home_page/admin_todayspl/today_special_details.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserTodaySpecialMain extends StatefulWidget {
  const UserTodaySpecialMain({super.key});

  @override
  State<UserTodaySpecialMain> createState() => _UserTodaySpecialMainState();
}

class _UserTodaySpecialMainState extends State<UserTodaySpecialMain> {
  late DocumentReference _todaySpecialReference;
  late Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _todaySpecialReference = FirebaseFirestore.instance
        .collection('today_special')
        .doc('today_special');
    _stream = _todaySpecialReference.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          final mediaQuery = MediaQuery.of(context);
          final screenWidth = mediaQuery.size.width;
          if (snapshot.hasData) {
            DocumentSnapshot recipeDocSnapShot = snapshot.data;
            Map recipeData = recipeDocSnapShot.data() as Map;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TodaySpecialDetails()));
                },
                child: Card(
                    color: AppTheme.colors.appWhiteColor,
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: (screenWidth < 600)
                                      ? screenWidth * 0.36
                                      : screenWidth * 0.17,
                                  child: Text(
                                    'Special Recipe today',
                                    maxLines: 2,
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppTheme.fonts.jost,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: (screenWidth < 600)
                                      ? screenWidth * 0.36
                                      : screenWidth * 0.17,
                                  child: Text(
                                    recipeData['name']!,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: AppTheme.fonts.jost),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.clock,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${recipeData['timeRequired']!}hr',
                                      style: TextStyle(
                                          fontFamily: AppTheme.fonts.jost),
                                    )
                                  ],
                                )
                              ],
                            ),
//foodphoto
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    recipeData['recipeImage']!,
                                    fit: BoxFit.fill,
                                    loadingBuilder:
                                        (context, child, loadingProgress) =>
                                            (loadingProgress == null)
                                                ? child
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppTheme
                                                                .colors
                                                                .appGreyColor)),
                                                    child: Center(
                                                      child: Icon(Icons.photo,
                                                          color: AppTheme.colors
                                                              .appGreyColor),
                                                    ),
                                                  ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
