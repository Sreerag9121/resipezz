  import 'package:flutter/material.dart';

  void signOurtShowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Password Mismatch'),
          content: const Text(
              'The entered passwords do not match. Please make sure they are the same.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); 
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }