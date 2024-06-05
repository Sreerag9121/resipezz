import 'package:flutter/material.dart';
import 'package:recipizz/pages/user/other/usercategoryfilter/user_cat_filter_show.dart';
import 'package:recipizz/utils/app_theme.dart';

class CategoriesBody extends StatelessWidget {
  const CategoriesBody({
    super.key,
    required this.items,
  });

  final List<Map> items;

  @override
  Widget build(BuildContext context) {
       final mediaQuery = MediaQuery.of(context);
       final screenWidth = mediaQuery.size.width;
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        Map thisItem = items[index];
    
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserCatFilterShow(
                            categoryName: thisItem['name'],
                          )));
            },
            child: Card(
              color: AppTheme.colors.shadecolor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      width: screenWidth*0.4,
                      child: Image.network(
                        thisItem['image'],
                        fit: BoxFit.cover,
                        loadingBuilder:
                            (context, child, loadingProgress) =>
                                (loadingProgress == null)
                                    ? child
                                    : Center(
                                      child: Icon(
                                        Icons.photo,
                                        color: AppTheme.colors.appGreyColor,
                                      ),
                                    ),
                      ),
                    ),
                    Positioned(
                      child: Text(
                        thisItem['name'],
                        style: TextStyle(
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
          ),
        );
      },
    );
  }
}