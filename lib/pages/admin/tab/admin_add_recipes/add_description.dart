import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class AddRecipeDescription extends StatelessWidget {
  final TextEditingController controllers;
  const AddRecipeDescription({super.key,required this.controllers});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllers,
      maxLines: null,
      decoration: InputDecoration(
          hintText: "Input Text Here",
          hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppTheme.colors.appGreyColor)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a Description';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
