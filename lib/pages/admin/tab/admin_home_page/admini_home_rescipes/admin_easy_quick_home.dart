import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/admin/other/recipedetail/recipe_detail_main.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminEasyAndQuick extends StatefulWidget {
  const AdminEasyAndQuick({super.key});

  @override
  State<AdminEasyAndQuick> createState() => _AdminEasyAndQuickState();
}

class _AdminEasyAndQuickState extends State<AdminEasyAndQuick> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    CollectionReference categoriesCollection =
        FirebaseFirestore.instance.collection('recipes');
    _stream = categoriesCollection.orderBy('dateTime').snapshots();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Text(
            'Easy & Quick',
            style: TextStyle(
              fontFamily: AppTheme.fonts.jost,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          StreamBuilder<QuerySnapshot>(
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
              if (!snapshot.hasData) {
                return Center(
                  child: Text('No Recipes',
                    style: TextStyle(fontFamily: AppTheme.fonts.jost),
                  ),
                );
              }
              if (snapshot.hasData) {
                QuerySnapshot<Object?>? querySnapshot =
                    snapshot.data;
                List<QueryDocumentSnapshot> documents = querySnapshot!.docs;
                List<Map> items = documents
                    .map((e) => {
                          'id': e.id,
                          'name': e['name'],
                          'image': e['recipeImage'],
                          'time': e['timeRequired'],
                        })
                    .toList();
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    Map thisItem = items[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminRecipesMainPage(
                            recipeId: thisItem['id'],
                          ),
                        ));
                      },
                      child: Card(
                        color: AppTheme.colors.appWhiteColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    thisItem['image'],
                                    fit: BoxFit.cover,
                                    width: 150,
                                    height: 100,
                                    loadingBuilder: (context, child, loadingProgress) =>
                                        (loadingProgress == null)
                                            ? child
                                            : SizedBox(
                                              width: double.infinity,
                                              height: double.infinity,
                                              child: Center(
                                                  child: Icon(
                                                    Icons.photo,
                                                    color: AppTheme.colors.appGreyColor,
                                                  ),
                                                ),
                                            ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                thisItem['name'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: AppTheme.fonts.jost,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const FaIcon(
                                    FontAwesomeIcons.clock,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${thisItem['time']}',
                                    style: TextStyle(fontFamily: AppTheme.fonts.jost),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
