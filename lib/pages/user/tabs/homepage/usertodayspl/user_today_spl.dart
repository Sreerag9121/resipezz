import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/user/tabs/homepage/usertodayspl/user_today_spl_body.dart';


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
        .collection('today_special').doc('todaySpecialId');
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
            return UserTodaySpl(todaySpecialId: recipeData['TodaySpecial']);
          }
          return const CircularProgressIndicator();
        });
  }
}
