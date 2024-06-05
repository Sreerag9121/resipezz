import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/admin/tab/admin_home_page/admin_home_category/admin_category_list.dart';
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

          return AdminCatBody(items: items);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
