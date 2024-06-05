import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/admin/tab/admin_home_page/admintodayspl/admin_today_spl_card.dart';

class AdminTodaySpecialMain extends StatefulWidget {
  const AdminTodaySpecialMain({super.key});

  @override
  State<AdminTodaySpecialMain> createState() => _AdminTodaySpecialMainState();
}

class _AdminTodaySpecialMainState extends State<AdminTodaySpecialMain> {
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
            return AdminTodaySplBody(todaySpecialId: recipeData['TodaySpecial']);
          }
          return const CircularProgressIndicator();
        });
  }
}
