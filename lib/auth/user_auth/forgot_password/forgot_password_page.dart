import 'package:flutter/material.dart';
import 'package:recipizz/auth/user_auth/forgot_password/forgot_password_service.dart';
import 'package:recipizz/auth/user_auth/login_page/login_page.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/my_text_field.dart';

class ForGotPasswordPage extends StatefulWidget {
  const ForGotPasswordPage({super.key});

  @override
  State<ForGotPasswordPage> createState() => _ForGotPasswordPageState();
}

class _ForGotPasswordPageState extends State<ForGotPasswordPage> {
  final _emailContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                    const Text('Please Enter Your Email',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    //Email
                    MyTextField(
                      controllers: _emailContoller,
                      obscureText: false,
                      labelText: 'Username',
                      prefixIconData: Icons.account_circle_outlined,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all<Size>(
                            const Size(100.0, 50.0)),
                        backgroundColor: WidgetStateProperty.all<Color>(
                          AppTheme.colors.maincolor,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseAuthService authService = FirebaseAuthService(
                            emailController: _emailContoller,
                          );
                          authService.resetpass();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Password Reset Link Sent'),
                                content: const Text(
                                    'A password reset link has been sent to your email.'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>const LogInPage()));                        
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text(
                        'Send link',
                        style: TextStyle(fontSize: 20, color:AppTheme.colors.appWhiteColor),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
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
