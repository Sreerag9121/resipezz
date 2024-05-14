// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:recipizz/utils/app_theme.dart';

// class RecipeDetails extends StatelessWidget {
//   const RecipeDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//        SizedBox(
//               width: double.infinity,
//               height: 300,
//               child: Image.asset(
//                 'assets/images/recipes/chicken theriyaki.jpg',
//                 fit: BoxFit.cover,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Chicken Teriyaki chow Mein',
//                     style: TextStyle(
//                       fontFamily: AppTheme.fonts.jost,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   IconButton(
//                       onPressed: () {},
//                       icon: Icon(
//                         Icons.favorite,
//                         color: AppTheme.colors.appRedColor,
//                       ))
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8,bottom: 8),
//               child: Row(
//                 children: [
//                   const FaIcon(
//                     FontAwesomeIcons.clock,
//                     size: 18,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 8),
//                     child: Text(
//                       'Ready in under 1 hr 43 min',
//                       style: TextStyle(
//                           fontFamily: AppTheme.fonts.jost,
//                           fontWeight: FontWeight.w700),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//       ],
//     );
//   }
// }
