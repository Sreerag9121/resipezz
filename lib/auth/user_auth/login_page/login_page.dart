// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:recipizz/auth/admin_login/admin_login_screen.dart';
import 'package:recipizz/auth/user_auth/forgot_password/forgot_password_page.dart';
import 'package:recipizz/auth/user_auth/signup_page/signup_page.dart';
import 'package:recipizz/pages/user/tabs/navigationbar/navigationbar.dart';
import 'package:recipizz/services/database/firebase/user/user_details/user_fire_auth_function.dart';
import 'package:recipizz/services/database/firebase/user/user_details/user_model.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/my_text_field.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _emailContoller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  UserModel _userModel = UserModel();
  final AuthServices _authService = AuthServices();
  void _login()async {
    try{
      _userModel=UserModel(email: _emailContoller.text,password: _passwordcontroller.text);
      final data=await _authService.logInUser(_userModel);
      if(data!=null){
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const UserNavBar()));
      }
    }on FirebaseAuthException catch (e) {
      List error = e.toString().split(',');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error[1])));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                      height: 80,
                    ),
//logo
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: Image.asset('assets/images/logo/logo-1.png'),
                    ),
//wlcometext
                    Text('Welcome Back',
                      style: TextStyle(
                          fontFamily: AppTheme.fonts.jost,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    const Text('Enter your credential to log in.',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 40,),
//Email
                    MyTextField(
                      controllers: _emailContoller,
                      obscureText: false,
                      labelText: 'Email',
                      prefixIconData: Icons.account_circle_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(
                      height: 40,
                    ),
//password
                    MyTextField(
                      controllers: _passwordcontroller,
                      obscureText: true,
                      labelText: 'Password',
                      prefixIconData: Icons.lock_outline,
                    ),
                    const SizedBox(height: 40,),
//login button
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
                          _login();
                        }
                      },
                      child: Text('LOGIN',
                        style: TextStyle(fontSize: 20,
                        color: AppTheme.colors.appWhiteColor),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
//forgotpassword
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ForGotPasswordPage()));
                      },
                      child: Text('Forgot Password?',
                        style: TextStyle(
                            color: AppTheme.colors.appBlueColor,
                            fontFamily: AppTheme.fonts.jost,
                            fontWeight: FontWeight.w500),
                      ),
                    ),

                    const SizedBox(height: 30,),
//signup
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (ctx) => const SignUpPage()));
                      },
                      child: const Text('Don’t have an Account? SIGN UP'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (ctx) => const AdminLogInScreen()));
                        },
                        child: Text('LogIn As Admin',
                          style: TextStyle(
                              color: AppTheme.colors.appBlueColor, 
                              fontWeight: FontWeight.bold),
                        )),
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
