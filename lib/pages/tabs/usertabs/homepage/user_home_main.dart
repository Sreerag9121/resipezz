import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/usercategori/user_home_categori.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/user_home_easy_quick.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/usertimefilter/user_time_filter_main.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/usertodayspl/user_today_spl.dart';
import 'package:recipizz/pages/tabs/usertabs/homepage/user_search_home.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserHomePageMain extends StatefulWidget {
  const UserHomePageMain({super.key});

  @override
  State<UserHomePageMain> createState() => _UserHomePageMainState();
}

class _UserHomePageMainState extends State<UserHomePageMain> {
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
                    child: Text(
                      'Home Page',
                      style: TextStyle(
                        fontSize: 35,
                        fontFamily: AppTheme.fonts.jost,
                        color: AppTheme.colors.background,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //search bar
                  Row(
                    children: [
                      Container(
                        width: screenWidth*0.6,
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
                              fillColor: AppTheme.colors.background,
                              hintText: 'search...',
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      searchvisibility = false;
                                      _searchController.clear();
                                      FocusScope.of(context).unfocus();
                                    });
                                  },
                                  icon: const Icon(Icons.clear)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50))),
                        ),
                      ),
                       IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserTimeFilterMain()));
                        },
                        icon: FaIcon(FontAwesomeIcons.clock,
                        color: AppTheme.colors.appWhiteColor,),
                      ),
                    ],
                  )
                ],
              ),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const UserTodaySpecialMain(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            child: Text(
                              'Categories',
                              style: TextStyle(
                                fontFamily: AppTheme.fonts.jost,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 101, child: CategoriesHomePage()),
                          const UserEasyAndQuick()
                        ],
                      ),
                      Visibility(
                        visible: searchvisibility,
                        child: Container(
                          color: AppTheme.colors.appWhiteColor,
                          child: SizedBox(
                              width: double.infinity,
                              height: 600,
                              child: UserSearchShow(searchData: recipeName)),
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
