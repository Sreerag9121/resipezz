import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class UserPassMain extends StatefulWidget {
  const UserPassMain({super.key});

  @override
  State<UserPassMain> createState() => _UserPassMainState();
}

class _UserPassMainState extends State<UserPassMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon:  Icon(
            Icons.arrow_back,
            size: 25,
            color: AppTheme.colors.appWhiteColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Text(
                    'Username & Password ',
                    style: TextStyle(
                        fontFamily: AppTheme.fonts.jost,
                        fontWeight: FontWeight.w600,
                        fontSize: 35,
                        color: AppTheme.colors.appWhiteColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CircleAvatar(
                    radius: 100,
                    backgroundImage:
                        AssetImage('assets/images/user/profile image.jpeg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      'sophia.johnson@gmail.com',
                      style: TextStyle(
                          fontFamily: AppTheme.fonts.jost,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppTheme.colors.appWhiteColor),
                    ),
                  ),
                  buildTextfield('UserName', 'SJ@1998'),
                  buildTextfield('Password', '*******'),
                  buildTextfield('New Password', ''),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                        ),
                        child:Text(
                          'CANCEL',
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: AppTheme.colors.appBlackColor),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.colors.maincolor,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                        ),
                        child:Text(
                          'SAVE',
                          style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 2,
                              color: AppTheme.colors.appBlackColor),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextfield(String labelText, String placeholder) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.colors.appBlackColor)),
      ),
    );
  }
}