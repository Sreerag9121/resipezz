import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/admin/other/recipe_detail/recipe_detail_main.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminSearchShow extends StatefulWidget {
  final String searchData;
  const AdminSearchShow({super.key, required this.searchData});

  @override
  State<AdminSearchShow> createState() => _AdminSearchShowState();
}

class _AdminSearchShowState extends State<AdminSearchShow> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('recipes').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text('No data available'),
            );
          }

          QuerySnapshot<Map<String, dynamic>> querySnapshot = snapshot.data!;
          List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
              querySnapshot.docs;
          List<Map<String, dynamic>> items = documents
              .map((e) => {
                    'id': e.id,
                    'name': e['name'],
                    'image': e['recipeImage'],
                    'time': e['timeRequired'],
                  })
              .toList();

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> thisItem = items[index];
            
                  if (widget.searchData.isEmpty ||
                      thisItem['name'].toString().toLowerCase()
                      .contains(widget.searchData.toLowerCase()) ||
                      (double.tryParse(widget.searchData) != null &&
                          double.tryParse(thisItem['time']) != null &&
                          double.parse(thisItem['time']) <=
                              double.parse(widget.searchData))) {
                    return myCard(thisItem);
                  }
                  return Container();
                }),
          );
        });
  }

  SizedBox myCard(Map<String, dynamic> data) {
    return SizedBox(
      height: 100,
      child: Card(
        color: AppTheme.colors.appWhiteColor,
        child: Center(
          child: ListTile(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AdminRecipesDetailPage(recipeId: data['id'])));
            },
            title: Text(
              data['name'],
              style: TextStyle(
                  fontFamily: AppTheme.fonts.jost,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            leading: SizedBox(
              height: 50,
              width: 50,
              child: CircleAvatar(
                backgroundImage: NetworkImage(data['image']),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.clock,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '${data['time']}',
                    style: TextStyle(fontFamily: AppTheme.fonts.jost),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
