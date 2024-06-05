import 'package:flutter/material.dart';
import 'package:recipizz/pages/admin/tab/admin_navbar/adminnavbar.dart';
import 'package:recipizz/utils/constance.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminAuth {
  final TextEditingController _adminUsernameController;
  final TextEditingController _adminPasswordController;
  final _username = 'sreerag9121@gmail.com';
  final _password = '123456789';
  final BuildContext context;

  AdminAuth({
    required TextEditingController adminUsernameController,
    required TextEditingController adminPasswordController,
    required this.context,
  })  : _adminUsernameController = adminUsernameController,
        _adminPasswordController = adminPasswordController;

  Future<void> adminCheckLogin() async {
    final username = _adminUsernameController.text;
    final password = _adminPasswordController.text;

    if (username == _username && password == _password) {
      final sharedPrefsAdmin = await SharedPreferences.getInstance();
      await sharedPrefsAdmin.setBool(saveKey, true);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const AdminNavBar()),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Username or Password not match'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              )
            ],
          );
        },
      );
    }
  }
}
