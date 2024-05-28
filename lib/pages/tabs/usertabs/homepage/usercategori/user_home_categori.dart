import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/usercategori/categori_body.dart';
import 'package:recipizz/utils/app_theme.dart';

class CategoriesHomePage extends StatefulWidget {
  const CategoriesHomePage({super.key});

  @override
  State<CategoriesHomePage> createState() => _CategoriesHomePageState();
}

class _CategoriesHomePageState extends State<CategoriesHomePage> {
  late Stream<QuerySnapshot> _streams;
  @override
  void initState() {
    CollectionReference userCatCollection =
        FirebaseFirestore.instance.collection('categories');
    _streams = userCatCollection.orderBy('datetime').snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _streams,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Some error occurred ${snapshot.error}',
                style: TextStyle(fontFamily: AppTheme.fonts.jost),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No Categories',
                style: TextStyle(fontFamily: AppTheme.fonts.jost),
              ),
            );
          }
          if (snapshot.hasData) {
            QuerySnapshot<Object?>? querySnap = snapshot.data;
            List<QueryDocumentSnapshot> dataDoc = querySnap!.docs;
            List<Map> items = dataDoc
                .map((element) => {
                      'id': element.id,
                      'name': element['categoriesName'],
                      'image': element['image']
                    })
                .toList();

            return CategoriesBody(items: items);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}



