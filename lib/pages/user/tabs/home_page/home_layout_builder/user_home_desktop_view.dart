import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/user/tabs/home_page/user_carousel/user_carousel.dart';
import 'package:recipizz/pages/user/tabs/home_page/user_categori_list/user_home_categori.dart';
import 'package:recipizz/pages/user/tabs/home_page/user_time_filter/user_time_filter_main.dart';
import 'package:recipizz/pages/user/tabs/home_page/user_todayspl/user_today_spl.dart';
import 'package:recipizz/pages/user/tabs/home_page/home_layout_builder/user_search_home.dart';
import 'package:recipizz/pages/user/other/cart/user_cart_page.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserHomeDesktop extends StatefulWidget {
  const UserHomeDesktop({super.key});

  @override
  State<UserHomeDesktop> createState() => _UserHomeDesktopState();
}

class _UserHomeDesktopState extends State<UserHomeDesktop> {
  final TextEditingController _searchController = TextEditingController();
  String recipeName = '';
  bool searchvisibility = false;
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight=mediaQuery.size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: AppTheme.colors.shadecolor,
        centerTitle: true,
      ),
      backgroundColor: AppTheme.colors.shadecolor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
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
//home page content
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                child: Container(
                  color: AppTheme.colors.appWhiteColor,
                  child: Stack(children: [
                    Row(
                      children: [
                         SingleChildScrollView(
                           child: Column(
                            children: [
// today special
                              SizedBox(
                                width: screenWidth*0.5,
                                height:screenHeight*0.3 ,
                                child: const UserTodaySpecialMain()
                                ),
//recipes
                              SizedBox(
                                width:screenWidth*.5,
                                child: const UserCarousel()
                                ),
                            ],
                                                   ),
                         ),
                         SingleChildScrollView(
                           child: SizedBox(
                            width: screenWidth*0.49,
                            child: const UserCategoryHome()),
                         ),
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
          ],
        ),
      ),
    );
  }
}
