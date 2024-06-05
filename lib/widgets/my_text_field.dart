import 'package:flutter/material.dart';
import 'package:recipizz/utils/app_theme.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controllers;
  final String? hintText;
  final bool obscureText;
  final String? labelText;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
  final TextInputType? keyboardType; 

  const MyTextField({
    super.key,
    required this.controllers,
    this.hintText,
    this.obscureText=false,
    this.labelText,
    this.keyboardType, 
    this.prefixIconData,
    this.suffixIconData,
  });

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  bool _passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controllers,
      obscureText: widget.obscureText && !_passwordVisibility,
      keyboardType: (widget.keyboardType==null)?TextInputType.text:widget.keyboardType, 
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        border:  const OutlineInputBorder(),
        labelText: (widget.labelText!=null)?widget.labelText:widget.hintText,
        labelStyle: TextStyle(color:AppTheme.colors.appBlackColor),
        hintText: (widget.hintText!=null)? widget.hintText:widget.labelText,
        hintStyle: const TextStyle(
          color: Colors.black12,
        ),
        prefixIcon: widget.prefixIconData != null ? Icon(widget.prefixIconData) : null,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisibility = !_passwordVisibility;
                  });
                },
                icon: (_passwordVisibility)? const Icon(Icons.visibility_off):const Icon(Icons.visibility),
              )
            : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a ${widget.labelText}';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
