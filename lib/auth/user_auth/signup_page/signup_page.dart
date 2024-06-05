// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/auth/user_auth/login_page/login_page.dart';
import 'package:recipizz/auth/user_auth/signup_page/signup_dialog_box.dart';
import 'package:recipizz/auth/user_auth/signup_page/signup_image_picker.dart';
import 'package:recipizz/pages/user/tabs/navigationbar/navigationbar.dart';
import 'package:recipizz/services/database/firebase/user/user_details/user_fire_auth_function.dart';
import 'package:recipizz/services/database/firebase/user/user_details/user_model.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/my_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _userNameContoller = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _emailController = TextEditingController();
  String? userImage;
  final _formKey = GlobalKey<FormState>();

  UserModel _userModel = UserModel();
  final AuthServices _authService = AuthServices();

  void _register() async {
    _userModel = UserModel(
      userImage: userImage,
      userName: _userNameContoller.text,
      email: _emailController.text,
      password: _passwordController.text,
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
                    Text('Sign Up',
                      style: TextStyle(
                          fontFamily: AppTheme.fonts.jost,
                          fontSize: 45,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                    ),
                    const Text('Create Your Account',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
//image picker
                   UserProfilePicture(
                    onImageSelectedResipe:(image){
                      setState(() {
                        userImage=image;
                      });
                    } 
                    ),
                    const SizedBox(height: 10,),
//username  
                    MyTextField(
                      controllers: _userNameContoller,
                      labelText: 'Username',
                      prefixIconData: Icons.account_circle_outlined,
                    ),
                    const SizedBox(height: 30,),
//Email
                    MyTextField(
                      controllers: _emailController,
                      labelText: 'Email',
                      prefixIconData: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 30,),
//password
                    MyTextField(
                      controllers: _passwordController,
                      obscureText: true,
                      labelText: 'Password',
                      prefixIconData: Icons.lock_outline,
                    ),
                    const SizedBox(height: 30,),
//re enter password            
                    MyTextField(
                      controllers: _rePasswordController,
                      obscureText: true,
                      labelText: 'confirm Password',
                      prefixIconData: Icons.lock_outline,
                    ),
                    const SizedBox(height: 40,),
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
                          if (_passwordController.text ==
                              _rePasswordController.text) {
                            _register();
                          } else {
                            signOurtShowDialog(context);
                          }
                        }
                      },
                      child: const Text('Sign Up',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 30,),
//Login page
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
