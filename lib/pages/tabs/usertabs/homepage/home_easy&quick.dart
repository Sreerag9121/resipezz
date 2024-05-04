import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/other/user/recipesmainpage/recipes_main.dart';
import 'package:recipizz/utils/app_theme.dart';

class EasyAndQuick extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const EasyAndQuick({Key? key});

  @override
  State<EasyAndQuick> createState() => _EasyAndQuickState();
}

class _EasyAndQuickState extends State<EasyAndQuick> {
  final List<RecipeItems> items = [
    RecipeItems(
      name: 'chicken teriyaki chow',
      photoUrl: 'assets/images/recipes/chicken theriyaki.jpg',
      time: '2 hours'
    ),
    RecipeItems(
      name: 'chicken teriyaki chow',
      photoUrl: 'assets/images/recipes/chicken theriyaki.jpg',
      time: '2 hours'
    ),
    RecipeItems(
      name: 'chicken teriyaki chow',
      photoUrl: 'assets/images/recipes/chicken theriyaki.jpg',
      time: '2 hours'
    ),
    RecipeItems(
      name: 'chicken teriyaki chow',
      photoUrl: 'assets/images/recipes/chicken theriyaki.jpg',
      time: '2 hours'
    ),
    RecipeItems(
      name: 'chicken teriyaki chow',
      photoUrl: 'assets/images/recipes/chicken theriyaki.jpg',
      time: '2 hours'
    ),
    RecipeItems(
      name: 'chicken teriyaki chow',
      photoUrl: 'assets/images/recipes/chicken theriyaki.jpg',
      time: '2 hours'
    ),RecipeItems(
      name: 'chicken teriyaki chow',
      photoUrl: 'assets/images/recipes/chicken theriyaki.jpg',
      time: '2 hours'
    ),
  
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            child: Text(
              'Easy & Quick',
              style: TextStyle(
                fontFamily: AppTheme.fonts.jost,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          GridView.builder(
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
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context)=>const RecipesMainPage())
                  );
                },
                child: Card(
                  color:AppTheme.colors.appWhiteColor,
                  child:Column(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(right: 8,top: 3),
                        child: const Icon(Icons.favorite_outline)
                        ),
                      SizedBox(
                        height: 110,
                        width: 140,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(items[index].photoUrl,
                          fit:BoxFit.cover ,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 120,
                          height: 40,
                          child: Text(items[index].name,
                                    style: TextStyle(
                                      fontFamily: AppTheme.fonts.jost,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                    ),
                          ),
                          ),
                      ),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            const FaIcon(FontAwesomeIcons.clock,size: 19,),
                            const SizedBox(width: 8,),
                            Text(
                              items[index].time
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class RecipeItems {
  final String name;
  final String photoUrl;
  final String time;
  RecipeItems({required this.name, required this.photoUrl,required this.time});
}

