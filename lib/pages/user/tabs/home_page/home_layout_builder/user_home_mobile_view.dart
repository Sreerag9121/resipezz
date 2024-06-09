import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/user/tabs/home_page/user_carousel/user_carousel.dart';
import 'package:recipizz/pages/user/tabs/home_page/user_categori_list/user_home_categori.dart';
import 'package:recipizz/pages/user/tabs/home_page/user_time_filter/user_time_filter_main.dart';
import 'package:recipizz/pages/user/tabs/home_page/user_todayspl/user_today_spl.dart';
import 'package:recipizz/pages/user/tabs/home_page/home_layout_builder/user_search_home.dart';
import 'package:recipizz/pages/user/other/cart/user_cart_page.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserHomeMobile extends StatefulWidget {
  const UserHomeMobile({super.key});

  @override
  State<UserHomeMobile> createState() => _UserHomeMobileState();
}

class _UserHomeMobileState extends State<UserHomeMobile> {
  final TextEditingController _searchController = TextEditingController();
  String recipeName = '';
  bool searchvisibility = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight=mediaQuery.size.height;
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 130,
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Home Page',
                      style: TextStyle(
                        fontSize: 25,
                        fontFamily: AppTheme.fonts.jost,
                        color: AppTheme.colors.background,
                      ),
                    ),
                  ),
//search bar
                  Row(
                    children: [
                      Container(
                        width: screenWidth*0.7,
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
                      IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const UserCartPage()));
                        },
                         icon: Icon(Icons.shopping_cart_outlined,
                         color: AppTheme.colors.appWhiteColor,))
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
                        children: [
// today special
                          SizedBox(
                            height:(screenWidth<500)? screenHeight*0.22:screenHeight*0.34,
                            child: const UserTodaySpecialMain()
                            ),
//carousel
                          const UserCarousel(),
//category
                          const UserCategoryHome(),
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
