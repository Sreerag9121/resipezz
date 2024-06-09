import 'package:flutter/material.dart';
import 'package:recipizz/pages/admin/other/categories/category_filter/category_filter_page.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminCatBody extends StatelessWidget {
  const AdminCatBody({
    super.key,
    required this.items,
  });

  final List<Map> items;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight=mediaQuery.size.height;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        Map thisItem = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryFilterPage(
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
                        width: double.infinity,
                        height: screenHeight*0.2,
                        child: Image.network(
                          thisItem['image'],
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) =>
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
          ),
        );
      },
    );
  }
}
