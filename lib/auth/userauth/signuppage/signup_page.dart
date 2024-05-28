// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/auth/userauth/loginpage/login_page.dart';
import 'package:recipizz/auth/userauth/signuppage/show_dialog.dart';
import 'package:recipizz/auth/userauth/signuppage/user_image.dart';
import 'package:recipizz/pages/tabs/usertabs/navigationbar/navigationbar.dart';
import 'package:recipizz/services/functions/userfunctions/user_fire_auth_function.dart';
import 'package:recipizz/services/functions/userfunctions/user_model.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/my_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _usernamecontoller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _repasswordcontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  String? userImage;
  final _formKey = GlobalKey<FormState>();

  UserModel _userModel = UserModel();
  final AuthServices _authService = AuthServices();

  void _register() async {
    _userModel = UserModel(
      userImage: userImage,
      userName: _usernamecontoller.text,
      email: _emailcontroller.text,
      password: _passwordcontroller.text,
      createdAt: DateTime.now(),
    );
    try {
      await Future.delayed(const Duration(seconds: 2));
      final userdata = await _authService.registorUser(_userModel);
      if (userdata != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const UserNavBar()));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          content: Text('Account Successfully Created'),
        ));
      }
    } on FirebaseAuthException catch (e) {
      List error = e.toString().split(',');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error[1])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: true,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    //SignUp text
                    Text(
                      'Sign Up',
                      style: TextStyle(
                          fontFamily: AppTheme.fonts.jost,
                          fontSize: 45,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    const Text(
                      'Create Your Account',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //username
                   AddUserImage(
                    onImageSelectedResipe:(image){
                      setState(() {
                        userImage=image;
                      });
                    } 
                    ),
                    const SizedBox(height: 10,),
                    MyTextField(
                      controllers: _usernamecontoller,
                      hintText: 'Enter Username',
                      labelText: 'Username',
                      prefixIconData: Icons.account_circle_outlined,
                      keyboardType: TextInputType.text,
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    //Email

                    MyTextField(
                      controllers: _emailcontroller,
                      hintText: 'Enter Email',
                      labelText: 'Email',
                      prefixIconData: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    MyTextField(
                      controllers: _passwordcontroller,
                      hintText: 'Enter Password',
                      obscureText: true,
                      labelText: 'Password',
                      prefixIconData: Icons.lock_outline,
                      keyboardType: TextInputType.text,
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    MyTextField(
                      controllers: _repasswordcontroller,
                      hintText: 'Enter Password Again',
                      obscureText: true,
                      labelText: 'Password',
                      prefixIconData: Icons.lock_outline,
                      keyboardType: TextInputType.text,
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    //SignUp button
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(100.0, 50.0)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          AppTheme.colors.maincolor,
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_passwordcontroller.text ==
                              _repasswordcontroller.text) {
                            _register();
                          } else {
                            signOurtShowDialog(context);
                          }
                        }
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    //signup
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (ctx) => const LogInPage()));
                        },
                        child: const Text('Already have an Account? Log In')),
                    Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
