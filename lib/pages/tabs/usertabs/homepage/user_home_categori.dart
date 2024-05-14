import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/user/usercategoryfilter/user_cat_filter_show.dart';
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

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                Map thisItem = items[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 200,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserCatFilterShow(
                                      categoryName: thisItem['name'],
                                    )));
                      },
                      child: Card(
                        color: AppTheme.colors.shadecolor,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Column(
                            children: [
                              Image.network(
                                thisItem['image'],
                                width: 150,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                              Center(
                                child: Text(
                                  thisItem['name'],
                                  style: TextStyle(
                                    color: AppTheme.colors.appWhiteColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

class MyItems {
  final String name;
  final String photoUrl;
  MyItems({required this.name, required this.photoUrl});
}
