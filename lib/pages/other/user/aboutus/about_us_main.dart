import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class AboutUsMain extends StatelessWidget {
  const AboutUsMain({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    return Scaffold(
      backgroundColor: AppTheme.colors.shadecolor,
      appBar: AppBar(
        backgroundColor: AppTheme.colors.shadecolor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon:Icon(
            Icons.arrow_back,
            size: 25,
            color: AppTheme.colors.appWhiteColor,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              'About Us',
              style: TextStyle(
                  fontFamily: AppTheme.fonts.jost,
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth*0.035,
                  color: AppTheme.colors.appWhiteColor),
            ),
             SizedBox(
              height: screenHeight*0.030,
            ),
            Card(
              color:AppTheme.colors.appWhiteColor,
              child: Container(
                width: screenWidth*.9,
                height:screenHeight*.75,
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 100,
                      backgroundImage:
                          AssetImage('assets/images/user/app-info-img.jpeg'),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('ReciPizz',
                      style: TextStyle(
                        fontFamily: AppTheme.fonts.mysteryQuest,
                        fontSize: screenHeight*0.032,
                        fontWeight: FontWeight.w800
                      ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text("Introducing Recipizz, your go-to recipe app designed to simplify your cooking experience and tantalize your taste buds. With an extensive collection of mouthwatering recipes from around the globe, Recipizz is your culinary companion for every occasion.",
                      style: TextStyle(
                        fontFamily: AppTheme.fonts.jost,
                        fontSize: 16,
                        
                      ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
