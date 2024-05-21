import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/other/admin/recipedetail/recipe_detail_main.dart';
import 'package:recipizz/pages/tabs/admintab/createrecipe/add_recipe_main.dart';
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
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: .8,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  Map thisItem = items[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AdminRecipesMainPage(
                                recipeId: thisItem['id'],
                              )));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: AppTheme.colors.appWhiteColor,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 110,
                                width: 140,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    thisItem['image'],
                                    fit: BoxFit.cover,
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
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  width: 120,
                                  height: 40,
                                  child: Text(
                                    thisItem['name'],
                                    style: TextStyle(
                                        fontFamily: AppTheme.fonts.jost,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 19,
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      '${thisItem['time']}',
                                      style: TextStyle(
                                          fontFamily: AppTheme.fonts.jost),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
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
