import 'package:flutter/material.dart';
import 'package:recipizz/auth/user_auth/login_page/login_page.dart';
import 'package:recipizz/auth/admin_login/admin_login_service.dart';
import 'package:recipizz/utils/app_theme.dart';
import 'package:recipizz/widgets/my_text_field.dart';

class AdminLogInScreen extends StatefulWidget {
  const AdminLogInScreen({super.key});

  @override
  State<AdminLogInScreen> createState() => _AdminLogInScreenState();
}

class _AdminLogInScreenState extends State<AdminLogInScreen> {
  final _adminusernamecontoller = TextEditingController();
  final _adminpasswordcontroller = TextEditingController();
  final _adminformKey = GlobalKey<FormState>();

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
                key: _adminformKey,
                child: Column(
                  children: [
                    const SizedBox(height: 130,),
          //logo            
                    SizedBox(
                      width: 130,
                      height: 130,
                      child: Image.asset('assets/images/logo/app_icon-removebg.png'),
                    ),
          //wlcometext
                   const Text('Enter your credential to log in.',
                    style: TextStyle(
                      color:Colors.black, 
                      fontSize: 20
                    ),
                    ),
                    const SizedBox(height: 40,),
          //Emailname
                   MyTextField(controllers: _adminusernamecontoller,
                    hintText: 'Enter Email', 
                    labelText: 'Email',
                    prefixIconData: Icons.account_circle_outlined,
                    keyboardType: TextInputType.emailAddress,),
                        
                    const SizedBox(height: 40,),
          //password
                    MyTextField(controllers: _adminpasswordcontroller,
                     hintText: 'Enter Password', 
                     obscureText: true,
                     labelText: 'Password',
                     prefixIconData: Icons.lock_outline,
                     suffixIconData: Icons.visibility,
                     keyboardType: TextInputType.text,
                    ),   

                    const SizedBox(height: 40,),
          //login button
                     ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: WidgetStateProperty.all<Size>(
                          const Size(100.0, 50.0)),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        AppTheme.colors.maincolor,
                      ),
                    ),
                    onPressed: () {
                       if (_adminformKey.currentState!.validate()) {
                          AdminAuth adminAuth = AdminAuth(
                            adminUsernameController: _adminusernamecontoller,
                            adminPasswordController: _adminpasswordcontroller,
                            context: context,
                          );
                          adminAuth.adminCheckLogin();
                        }
                    },
                    child:Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppTheme.colors.appWhiteColor
                        ),
                    ),
                  ),
                  const SizedBox(height: 30,),
          //forgotpassword
                  
                  const SizedBox(height: 30,),
          //signup
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx)=>const LogInPage())
                      );
                   },
                    child:  Text('LogIn As User',
                    style: TextStyle(
                      color: AppTheme.colors.appBlueColor,
                      fontWeight: FontWeight.bold
                    ),
                    )
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom:MediaQuery.of(context).viewInsets.bottom 
                        )
                      )
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