import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admincat/admin_categori_main.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admin_easy_quick_home.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admin_seatrch_show.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admin_time_filter.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admintodayspl/admin_today_spl_main.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminHomePageMain extends StatefulWidget {
  const AdminHomePageMain({super.key});

  @override
  State<AdminHomePageMain> createState() => _AdminHomePageMainState();
}

class _AdminHomePageMainState extends State<AdminHomePageMain> {
 final TextEditingController _searchController=TextEditingController();
 String recipeName='';
  bool searchvisibility = false;
  @override
  Widget build(BuildContext context) {
          final mediaQuery = MediaQuery.of(context);
          final screenWidth = mediaQuery.size.width;
          final screenHeight = mediaQuery.size.height;
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
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                              onChanged: (value){
                                setState(() {
                                  recipeName=value;
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
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AdminTimeFilter()));
                            },
                            icon: FaIcon(FontAwesomeIcons.clock,
                            color: AppTheme.colors.appWhiteColor,),
                          ),
                        ],
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // today special
                          const AdminTodaySpecialMain(),
                          Padding(
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
                        //categories
                          const SizedBox(
                              height: 101, child: AdminCategoriHome()),
                        //easy and quick
                          const AdminEasyAndQuick()
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