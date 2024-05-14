import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/admin/filter/category_filter.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminCategoriHome extends StatefulWidget {
  const AdminCategoriHome({super.key});

  @override
  State<AdminCategoriHome> createState() => _AdminCategoriHomeState();
}

class _AdminCategoriHomeState extends State<AdminCategoriHome> {
  late Stream<QuerySnapshot> _stream;
  @override
  void initState() {
    CollectionReference categoriesCollection =
        FirebaseFirestore.instance.collection('categories');
    _stream = categoriesCollection.orderBy('datetime').snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Some error occurred ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: Text('No Categories',
                style: TextStyle(fontFamily: AppTheme.fonts.jost)),
          );
        }
        if (snapshot.hasData) {
          QuerySnapshot<Object?>? querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> documents = querySnapshot!.docs;
          List<Map> items = documents
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
                              builder: (context) => CategoryFilter(
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
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
