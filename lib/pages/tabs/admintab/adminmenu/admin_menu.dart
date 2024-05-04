import 'package:flutter/material.dart';
import 'package:recipizz/pages/other/user/aboutus/about_us_main.dart';
import 'package:recipizz/pages/tabs/admintab/adminmenu/admin_signout.dart';
import 'package:recipizz/pages/tabs/admintab/adminmenu/adminprofile.dart';
import 'package:recipizz/utils/app_theme.dart';

class AdminMenu extends StatefulWidget {
  const AdminMenu({super.key});

  @override
  State<AdminMenu> createState() => _AdminMenuState();
}

class _AdminMenuState extends State<AdminMenu> {
final List<Menuitems>menuitems=[
  Menuitems(
    title: 'My Profile',
     icon:Icons.person_outline,
     mnuitmnav: const AdminProfile() ,
    ),
     Menuitems(
    title: 'About',
     icon:Icons.info_outline_rounded,
     mnuitmnav: const AboutUsMain(),
    ),
     Menuitems(
    title: 'Sign Out',
     icon:Icons.logout_outlined,
     mnuitmnav: const AsignOutButton(),
    ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      body:SafeArea(
        child: Column(
          children: [
            //user photo and details
            const AdminProfile(),

            //menu contents
            const SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                itemCount: menuitems.length,
                itemBuilder: (context,index){
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        title: Text(menuitems[index].title,
                        style: TextStyle(
                          fontFamily: AppTheme.fonts.jost,
                          fontSize: 20,
                          color: AppTheme.colors.appWhiteColor
                        ),
                        ),
                        leading: Icon(menuitems[index].icon,
                        color: AppTheme.colors.appWhiteColor,
                        size: 30,
                        ),
                        onTap: (){
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context)=>menuitems[index].mnuitmnav)
                          );
                        },
                      ),
                  );
                },
                )
            ),
          ],
        ),
      )
      );
  }
}

class Menuitems{
  final String title;
  final IconData icon;
  final Widget mnuitmnav;
  Menuitems({required this.title,required this.icon,required this.mnuitmnav});
}