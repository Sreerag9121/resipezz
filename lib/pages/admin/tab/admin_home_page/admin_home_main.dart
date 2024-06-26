import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/admin/tab/admin_home_page/admin_home_category/admin_category_main.dart';
import 'package:recipizz/pages/admin/tab/admin_home_page/admin_search_view/admin_seatrch_view.dart';
import 'package:recipizz/pages/admin/tab/admin_home_page/admin_time_filter/admin_time_filter.dart';
import 'package:recipizz/pages/admin/tab/admin_home_page/admin_todayspl/admin_today_spl_main.dart';
import 'package:recipizz/pages/admin/tab/admin_home_page/admin_carousel/admin_carousel.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final TextEditingController _searchController = TextEditingController();
  String recipeName = '';
  bool searchvisibility = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 170,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Column(
                children: [
                  Center(
                    child: Text('Home Page',
                      style: TextStyle(
                        fontSize: 35,
                        fontFamily: AppTheme.fonts.jost,
                        color: AppTheme.colors.background,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
//search bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: screenWidth * 0.6,
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: _searchController,
                          onTap: () {
                            setState(() {
                              searchvisibility = true;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              recipeName = value;
                            });
                          },
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: AppTheme.colors.appWhiteColor,
                              hintText: 'search...',
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searchvisibility = false;
                                      FocusScope.of(context).unfocus();
                                      _searchController.clear();
                                    });
                                  },
                                  icon: const Icon(Icons.clear)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
//time filter                    
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>
                                      const AdminTimeFilter()));
                        },
                        icon: FaIcon(
                          FontAwesomeIcons.clock,
                          color: AppTheme.colors.appWhiteColor,
                        ),
                      ),
                    ],)
                ],),
            ),
//home page content
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  color: AppTheme.colors.appWhiteColor,
                  child: SingleChildScrollView(
                    child: Stack(children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
// today special
                          AdminTodaySpecialMain(),
//recipes
                          AdminCarousel(),
//categories
                          AdminCategoryHome(),
                        ],
                      ),
//search visibity
                      Visibility(
                        visible: searchvisibility,
                        child: Container(
                          color: AppTheme.colors.appWhiteColor,
                          child: SizedBox(
                              width: double.infinity,
                              height: 600,
                              child: AdminSearchShow(searchData: recipeName)),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
