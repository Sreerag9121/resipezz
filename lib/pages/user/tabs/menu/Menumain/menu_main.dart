import 'package:flutter/material.dart';
import 'package:recipizz/pages/user/other/my_profile/update_profile_main.dart';
import 'package:recipizz/pages/user/other/rule/privacy_policy_page.dart';
import 'package:recipizz/pages/user/other/rule/terms_conditions_page.dart';
import 'package:recipizz/pages/user/other/user_password/user_password_page.dart';
import 'package:recipizz/pages/user/tabs/menu/Menumain/menu_signout.dart';
import 'package:recipizz/utils/app_theme.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {

final List<Menuitems>menuitems=[
  Menuitems(
    title: 'My Profile',
     icon:Icons.person_outline,
     mnuitmnav: const MyProfileMain(),
    ),
    Menuitems(
    title: 'Update Password',
     icon:Icons.lock_outline,
     mnuitmnav: const UserPasswordPage(),
    ),
    //  Menuitems(
    // title: 'About',
    //  icon:Icons.info_outline_rounded,
    //  mnuitmnav: const AboutAppPage(),
    // ),
    Menuitems(
    title: 'Privacy Policy',
     icon:Icons.privacy_tip_outlined,
     mnuitmnav: const PrivacyPolicys(),
    ),
   Menuitems(
    title: 'Terms And Conditions',
     icon:Icons.gavel_outlined,
     mnuitmnav: const TermsCondition(),
    ),
     Menuitems(
    title: 'Sign Out',
     icon:Icons.logout_outlined,
     mnuitmnav: const SignOutButton(),
    ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppTheme.colors.shadecolor,
      body:SafeArea(
        child: Column(
          children: [
            Text('Menu',
            style:TextStyle(
              fontFamily: AppTheme.fonts.jost,
              fontSize: 24,
              fontWeight: FontWeight.w600
            ),),
            //menu contents
            const SizedBox(height: 30,),
            Expanded(
              child: ListView.builder(
                itemCount: menuitems.length,
                itemBuilder: (context,index){
                  return  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: AppTheme.colors.shadecolor,
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
                    ),
                  );
                },
                )
            ),
            Text('Version',
            style: TextStyle(
              fontSize: 24,
              fontFamily: AppTheme.fonts.jost,
              fontWeight: FontWeight.w500,
              color: AppTheme.colors.appGreyColor
            ),),
            Text('1.0.0',
            style: TextStyle(
              fontSize: 17,
              fontFamily: AppTheme.fonts.jost,
              fontWeight: FontWeight.w500,
              color: AppTheme.colors.appGreyColor
            ),)
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
