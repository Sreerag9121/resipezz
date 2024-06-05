import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/admin/other/categories/add_categories/add_catogories_page.dart';
import 'package:recipizz/pages/admin/tab/admin_add_category/categories_details.dart';
import 'package:recipizz/utils/app_theme.dart';

class CategotiesMain extends StatefulWidget {
  const CategotiesMain({super.key});

  @override
  State<CategotiesMain> createState() => _CategotiesMainState();
}

class _CategotiesMainState extends State<CategotiesMain> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        centerTitle: true,
        title: Text(
          'Categories',
          style: TextStyle(
            color: AppTheme.colors.appWhiteColor,
            fontFamily: AppTheme.fonts.jost,
            fontSize: 26,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Some error occurred ${snapshot.error}',
              style: TextStyle(fontFamily: AppTheme.fonts.jost),),
            );
          }
          if (snapshot.hasData) {
            QuerySnapshot<Object?>? querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot!.docs;
            List<Map> items = documents
                .map((e) => {
                      'id': e.id,
                      'name': e['categoriesName'],
                      'image': e['image']
                    })
                .toList();

            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                Map thisItem = items[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>CategoriesDetails(catIdDetail: thisItem['id'],))
                      );
                    },
                    child: Card(
                      color: AppTheme.colors.shadecolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              Image.network(
                                thisItem['image'],
                                width: double.infinity,
                                height: 160,
                                fit: BoxFit.cover,
                              ),
                              Center(
                                child: Text(
                                thisItem['name'],
                                style: TextStyle(
                                  color: AppTheme.colors.appWhiteColor,
                                  fontSize: 25, 
                                  fontFamily: AppTheme.fonts.jost,
                                  fontWeight:FontWeight.w400,
                                  decorationColor: Colors.black
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

          return Center(child: Text('Add Items',
          style: TextStyle(fontFamily: AppTheme.fonts.jost),));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.colors.shadecolor,
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const AddCategoryPage()));
        },
        child: Icon(
          Icons.add,
          color: AppTheme.colors.appWhiteColor,
        ),
      ),
    );
  }
}
