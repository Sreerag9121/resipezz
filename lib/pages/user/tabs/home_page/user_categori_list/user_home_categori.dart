import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/user/tabs/home_page/user_categori_list/categori_body.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserCategoryHome extends StatefulWidget {
  const UserCategoryHome({super.key});

  @override
  State<UserCategoryHome> createState() => _UserCategoryHomeState();
}

class _UserCategoryHomeState extends State<UserCategoryHome> {
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

            return Column(
               crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontFamily: AppTheme.fonts.jost,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
                UserCategoriesBody(items: items),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}



