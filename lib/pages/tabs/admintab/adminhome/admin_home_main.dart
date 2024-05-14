import 'package:flutter/material.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admin_categori_home.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admin_easy_quick_home.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admin_seatrch_show.dart';
import 'package:recipizz/pages/tabs/admintab/adminhome/admin_today_spl.dart';
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
                      Padding(
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
                          const AdminTodaySpl(),
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
                          const SizedBox(
                              height: 101, child: AdminCategoriHome()),
                          const AdminEasyAndQuick()
                        ],
                      ),
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
