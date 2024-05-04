import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class CategoriesHomePage extends StatefulWidget {
  const CategoriesHomePage({super.key});

  @override
  State<CategoriesHomePage> createState() => _CategoriesHomePageState();
}

class _CategoriesHomePageState extends State<CategoriesHomePage> {
  final List<MyItems> items = [
    MyItems(
      name: 'Veg',
      photoUrl: 'assets/images/Categories/veg-food.jpg',
    ),
    MyItems(
      name: 'Non-Veg',
      photoUrl: 'assets/images/Categories/non-veg.jpg',
    ),
    MyItems(
      name: 'Main-Dishes',
      photoUrl: 'assets/images/Categories/main-dishes.jpg',
    ),
    MyItems(
      name: 'Desserts',
      photoUrl: 'assets/images/Categories/desserts.jpg',
    ),
    MyItems(
      name: 'salads',
      photoUrl: 'assets/images/Categories/salads.jpeg',
    ),
    MyItems(
      name: 'Beverages',
      photoUrl: 'assets/images/Categories/beverages.jpeg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Text(
              'Categories',
              style: TextStyle(
                  fontFamily: AppTheme.fonts.jost,
                  fontSize: 16,
                  fontWeight: FontWeight.w900),
            ),
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: Card(
                      color: AppTheme.colors.shadecolor,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Column(
                          children: [
                            Image.asset(
                              items[index].photoUrl,
                              width: 100,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            Center(
                              child: Text(
                                items[index].name,
                                style:TextStyle(
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
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class MyItems {
  final String name;
  final String photoUrl;
  MyItems({required this.name, required this.photoUrl});
}
