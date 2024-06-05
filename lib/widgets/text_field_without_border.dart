import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class BorderlessTextFormField extends StatelessWidget {
  final TextEditingController controllers;
  final String? hintText;
  final String labelText;
  const BorderlessTextFormField(
      {super.key,
      required this.controllers,
      this.hintText,
      required this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextFormField(
          controller: controllers,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 5),
              labelText: labelText,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: (hintText==null)?labelText:hintText,
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppTheme.colors.appBlackColor)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $labelText';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
    );
  }
}
