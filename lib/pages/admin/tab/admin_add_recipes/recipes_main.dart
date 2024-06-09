import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/admin/other/recipe_detail/recipe_detail_main.dart';
import 'package:recipizz/pages/admin/tab/admin_add_recipes/add_recipe_main.dart';
import 'package:recipizz/utils/app_theme.dart';

class RecipesMain extends StatefulWidget {
  const RecipesMain({super.key});

  @override
  State<RecipesMain> createState() => _RecipesMainState();
}

class _RecipesMainState extends State<RecipesMain> {
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        centerTitle: true,
        title: Text(
          'Recipies',
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
              child: Text(
                'Some error occurred ${snapshot.error}',
                style: TextStyle(fontFamily: AppTheme.fonts.jost),
              ),
            );
          }
          if (!snapshot.hasData) {
            return Center(
                child: Text(
              'Add Recipes',
              style: TextStyle(fontFamily: AppTheme.fonts.jost),
            ));
          }
          if (snapshot.hasData) {
            QuerySnapshot<Object?>? querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot> documents = querySnapshot!.docs;
            List<Map> items = documents
                .map((e) => {
                      'id': e.id,
                      'name': e['name'],
                      'image': e['recipeImage'],
                      'time': e['timeRequired'],
                    })
                .toList();

            return SingleChildScrollView(
              child: GridView.builder(
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
                          builder: (context) => AdminRecipesDetailPage(
                                recipeId: thisItem['id'],
                              )));
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
                                  width: double.infinity,
                                  height: double.infinity,
                                  loadingBuilder: (context, child,loadingProgress) =>
                                  (loadingProgress == null)
                                      ? child
                                      : Center(
                                          child: Icon(
                                          Icons.photo,
                                          color: AppTheme.colors.appGreyColor,
                                        )),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              thisItem['name'],
                              maxLines: 2,
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: AppTheme.fonts.jost,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const FaIcon(
                                  FontAwesomeIcons.clock,
                                  size: 16,
                                ),
                                const SizedBox(width: 8,),
                                Text(
                                  '${thisItem['time']} hr',
                                  style: TextStyle(
                                      fontFamily: AppTheme.fonts.jost),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.colors.shadecolor,
        foregroundColor: AppTheme.colors.appWhiteColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateRecipeMain()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
