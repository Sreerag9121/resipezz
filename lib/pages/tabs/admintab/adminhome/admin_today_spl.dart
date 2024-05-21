import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/utils/app_theme.dart';

class TodaySpeciaMain extends StatefulWidget {
  const TodaySpeciaMain({super.key});

  @override
  State<TodaySpeciaMain> createState() => _TodaySpeciaMainState();
}

class _TodaySpeciaMainState extends State<TodaySpeciaMain> {
  late DocumentReference _todaySpecialReference;
  late Stream<DocumentSnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _todaySpecialReference = FirebaseFirestore.instance
        .collection('today_special')
        .doc('todaySpecialId');
    _stream = _todaySpecialReference.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot recipeDocSnapShot = snapshot.data;
            Map recipeData = recipeDocSnapShot.data() as Map;
            return AdminTodaySpl(todaySpecialId: recipeData['TodaySpecial']);
          }
          return const CircularProgressIndicator();
        });
  }
}

class AdminTodaySpl extends StatefulWidget {
  final String todaySpecialId;
  const AdminTodaySpl({super.key, required this.todaySpecialId});

  @override
  State<AdminTodaySpl> createState() => _AdminTodaySplState();
}

class _AdminTodaySplState extends State<AdminTodaySpl> {
  late DocumentReference _recipeReferance;
  late Stream<DocumentSnapshot> _stream;
  @override
  void initState() {
    super.initState();
    _recipeReferance = FirebaseFirestore.instance
        .collection('recipes')
        .doc(widget.todaySpecialId);
    _stream = _recipeReferance.snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot recipeDocSnapShot = snapshot.data;
            Map recipeData = recipeDocSnapShot.data() as Map;
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
                                    fontSize: 20,
                                    fontFamily: AppTheme.fonts.jost),
                              ),
                              Text(
                                'Today.',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: AppTheme.fonts.jost),
                              ),
                              Text(
                                recipeData['name'],
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
                                    recipeData['timeRequired'],
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: AppTheme.fonts.jost),
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
                                child: Image.network(
                                  recipeData['recipeImage'],
                                  fit: BoxFit.fill,
                                  loadingBuilder: (context, child,
                                          loadingProgress) =>
                                      (loadingProgress == null)
                                          ? child
                                          : Center(
                                              child: Icon(
                                              Icons.photo,
                                              color:
                                                  AppTheme.colors.appGreyColor,
                                            )),
                                )),
                          )
                        ],
                      ),
                    ),
                  )),
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
