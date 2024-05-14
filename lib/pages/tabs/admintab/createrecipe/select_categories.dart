import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/admin/categories/add_catogories_main.dart';
import 'package:recipizz/utils/app_theme.dart';

class CategoryDropDown extends StatefulWidget {
 final Function(String?) selectedCategory;
  const CategoryDropDown({super.key,required this.selectedCategory});

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  late Stream<QuerySnapshot> _stream;
  @override
  void initState() {
    CollectionReference categoriesCollection =
        FirebaseFirestore.instance.collection('categories');
    _stream = categoriesCollection.orderBy('datetime').snapshots();
    super.initState();
  }

  String? valueChoos;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Some error occurred ${snapshot.error}',
              style: TextStyle(fontFamily: AppTheme.fonts.jost),
            ),
          );
        }
        if (snapshot.hasData) {
          QuerySnapshot<Object?>? querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> documents = querySnapshot!.docs;
          List<String> listItem = [];
          for (var doc in documents) {
            listItem.add(doc['categoriesName']);
          }
          listItem =
              documents.map((doc) => doc['categoriesName'] as String).toList();

          return DropdownButton(
            hint: const Text('Select Category'),
            value: valueChoos,
            items: listItem.map((valueItem) {
              return DropdownMenuItem(
                value: valueItem,
                child: Text(valueItem),
              );
            }).toList(),
            onChanged: (String? newvalue) {
              setState(() {
                valueChoos = newvalue;
                widget.selectedCategory(valueChoos);
              });
            },
          );
        }

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.center,
            width: 200,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.colors.appGreyColor)),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddCategories()));
                },
                child: Text(
                  '*Add Categories',
                  style: TextStyle(
                      color: AppTheme.colors.appBlackColor,
                      fontFamily: AppTheme.fonts.jost),
                )),
          ),
        );
      },
    );
  }
}
