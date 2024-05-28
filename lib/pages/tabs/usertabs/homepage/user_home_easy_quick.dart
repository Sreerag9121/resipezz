import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/other/user/recipesdetailspage/recipes_main.dart';
import 'package:recipizz/services/functions/hive/favorite_fn.dart';
import 'package:recipizz/services/functions/hive/favorite_model.dart';
import 'package:recipizz/services/functions/hive/hive_open_box.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserEasyAndQuick extends StatefulWidget {
  const UserEasyAndQuick({super.key});

  @override
  State<UserEasyAndQuick> createState() => _UserEasyAndQuickState();
}

class _UserEasyAndQuickState extends State<UserEasyAndQuick> {
  late Stream<QuerySnapshot> _stream;
  ValueNotifier<List<String>> iconListNotifier = ValueNotifier<List<String>>([]);
  List<String> iconList = [];
  var recipes = favoriteBox.values.toList().cast<FavoriteModel>();

  void getIconList() {
    for (int i = 0; i < recipes.length; i++) {
      iconList.add(recipes[i].id.toString());
    }
    iconListNotifier.value = iconList;
  }

  @override
  void initState() {
    getIconList();
    CollectionReference categoriesCollection =
        FirebaseFirestore.instance.collection('recipes');
    _stream = categoriesCollection.orderBy('dateTime').snapshots();
    super.initState();
  }

  @override
  void dispose() {
    iconListNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FavoriteCrud favoriteCrud = FavoriteCrud();
    return ValueListenableBuilder<List<String>>(
      valueListenable: iconListNotifier,
      builder: (context, iconList, child) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Easy & Quick',
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
                      child: Text('Some error occurred ${snapshot.error}',
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
                    QuerySnapshot<Object?>? querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> documents = querySnapshot!.docs;
                    List<Map> items = documents.map((element) => {
                              'id': element.id,
                              'name': element['name'],
                              'image': element['recipeImage'],
                              'time': element['timeRequired'],
                              'serving': element['serving'],
                              'ingredient': element['ingredient'],
                              'directions': element['directions'],
                              'description': element['description'],
                            }).toList();
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
                                builder: (context) => RecipesMainPage(
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
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: (iconList.contains(thisItem['id']))
                                        ? InkWell(
                                            onTap: () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      backgroundColor: AppTheme
                                                          .colors.appRedColor,
                                                      content: Text('Already Added',
                                                          style: TextStyle(
                                                              fontFamily: AppTheme.fonts.jost))));
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              color: AppTheme.colors.appRedColor,
                                            ))
                                        : InkWell(
                                            onTap: () {
                                              setState(() {
                                                iconListNotifier.value = List.from(iconList)
                                                  ..add(thisItem['id']);
                                                favoriteCrud.addFavorite(
                                                    id: thisItem['id'],
                                                    recipeName: thisItem['name'],
                                                    serving: thisItem['serving'],
                                                    timeRequired: thisItem['time'],
                                                    description: thisItem['description'],
                                                    imagePath: thisItem['image'],
                                                    ingredient: thisItem['ingredient']
                                                        .whereType<String>().toList(),
                                                    directions: thisItem['directions']
                                                        .whereType<String>().toList());
                                              });
                                            },
                                            child: const Icon(Icons.favorite_outline)),
                                  ),
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        thisItem['image'],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        loadingBuilder:(context, child, loadingProgress) =>
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
                                    style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
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
                                      )
                                    ],)
                                ],),),
                          ),);
                      },);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
