import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/pages/user/other/user_recipe_details/user_recipe_details_layout/user_recipe_detail_mobile.dart';
import 'package:recipizz/pages/user/tabs/home_page/user_firebase_recipes_grid/firebase_recipes_grid.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserCarousel extends StatefulWidget {
  const UserCarousel({super.key});

  @override
  State<UserCarousel> createState() => _UserCarouselState();
}

class _UserCarouselState extends State<UserCarousel> {
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    CollectionReference categoriesCollection =
        FirebaseFirestore.instance.collection('recipes');
    _stream = categoriesCollection.orderBy('dateTime').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FirebaseRecipesGridView()));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recipes',
                  style: TextStyle(
                    fontFamily: AppTheme.fonts.jost,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text('more',
                  style: TextStyle(
                    fontFamily: AppTheme.fonts.jost,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.colors.appBlueColor,
                    ),
                )
              ],
            ),
          ),
        ),
        StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              QuerySnapshot<Object?>? querySnapshot = snapshot.data;
              List<QueryDocumentSnapshot> documents = querySnapshot!.docs;
              List<Map<String, dynamic>> items = documents
                  .map((e) => {
                        'id': e.id,
                        'name': e['name'],
                        'image': e['recipeImage'],
                        'time': e['timeRequired'],
                      })
                  .toList();

              return CarouselSlider(
                items: items.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context,
                               MaterialPageRoute(builder: (context)=>
                                      UserRecipesDetailMobile(recipeId: item['id'],)));
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  item['image'],
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                          (context, child, loadingProgress) =>
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
                                                    )
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: TextStyle(
                                      fontFamily: AppTheme.fonts.jost,
                                      overflow:TextOverflow.ellipsis,
                                        color: AppTheme.colors.appWhiteColor,
                                        fontSize: 29.0,
                                        fontWeight: FontWeight.bold,
                                        shadows: const [
                                          Shadow(
                                            offset: Offset(1.5, 1),
                                            color: Colors.black,
                                          )
                                        ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      'Time : ${item['time']} hr',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: AppTheme.colors.appWhiteColor,
                                          shadows: const [
                                            Shadow(
                                              offset: Offset(1.5, 1.5),
                                              color: Colors.black,
                                            )
                                          ]),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  aspectRatio:16/5,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  viewportFraction: 0.8,
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ],
    );
  }
}