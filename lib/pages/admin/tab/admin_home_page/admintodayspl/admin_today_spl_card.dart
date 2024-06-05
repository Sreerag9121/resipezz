import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminTodaySplBody extends StatefulWidget {
  final String todaySpecialId;
  const AdminTodaySplBody({super.key, required this.todaySpecialId});

  @override
  State<AdminTodaySplBody> createState() => _AdminTodaySplBodyState();
}

class _AdminTodaySplBodyState extends State<AdminTodaySplBody> {
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
          final mediaQuery = MediaQuery.of(context);
          final screenWidth = mediaQuery.size.width;
          final screenHeight = mediaQuery.size.height;
          if (snapshot.hasData) {
            DocumentSnapshot recipeDocSnapShot = snapshot.data;
            Map recipeData = recipeDocSnapShot.data() as Map;
            return Padding(
              padding: const EdgeInsets.all(8.0),
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
                                width: screenWidth*0.4,
                                child: Text(
                                  'Special Recipe today',
                                  maxLines: 2,
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 20,
                                      fontFamily: AppTheme.fonts.jost,
                                      ),
                                ),
                              ),
                             
                              SizedBox(
                                width: screenWidth*0.4,
                                child: Text(
                                  recipeData['name'],
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
                            width: screenWidth * 0.31,
                            height: screenHeight * 0.12,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  recipeData['recipeImage'],
                                  fit: BoxFit.fill,
                                  loadingBuilder:
                                      (context, child, loadingProgress) =>
                                          (loadingProgress == null)
                                              ? child
                                              : Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppTheme.colors
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
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
