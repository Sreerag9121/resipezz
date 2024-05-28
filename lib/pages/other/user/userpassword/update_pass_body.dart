// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:recipizz/services/functions/userfunctions/updatepassword/update_password_fn.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/my_text_field.dart';

class UpdatePassWordBody extends StatefulWidget {
  const UpdatePassWordBody({
    super.key,
    required this.userData,
  });

  final Map<String, dynamic> userData;

  @override
  State<UpdatePassWordBody> createState() => _UpdatePassWordBodyState();
}

class _UpdatePassWordBodyState extends State<UpdatePassWordBody> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UpdatePassWord updatePassWord = UpdatePassWord();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.colors.appGreyColor)),
            child: Image.network(
              widget.userData['userImage'],
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              widget.userData['email'],
              style: TextStyle(
                  fontFamily: AppTheme.fonts.jost,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppTheme.colors.appWhiteColor),
            ),
          ),
          MyTextField(
              controllers: _currentPasswordController,
              hintText: 'Old Password',
              obscureText: true,
              keyboardType: TextInputType.name),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
              controllers: _passwordController,
              hintText: 'New Password',
              obscureText: true,
              keyboardType: TextInputType.name),
          const SizedBox(
            height: 10,
          ),
          MyTextField(
              controllers: _rePasswordController,
              hintText: 'Confirm Password',
              obscureText: true,
              keyboardType: TextInputType.name),
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
                child: Text(
                  'CANCEL',
                  style: TextStyle(
                      fontSize: 15,
                      letterSpacing: 2,
                      color: AppTheme.colors.appBlackColor),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (_passwordController.text ==
                        _rePasswordController.text) {
                      await updatePassWord.updatePasswordFn(
                          _currentPasswordController.text,
                          _passwordController.text,
                          context);
                      FocusScope.of(context).unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: AppTheme.colors.appGreenColor,
                        content: const Text('succsessfully Updated'),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Password Missmatch'),
                      ));
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.colors.maincolor,
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                ),
                child: Text(
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
    );
  }
}
