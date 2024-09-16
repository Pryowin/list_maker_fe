import 'package:flutter/material.dart';

void accountCreatedDialog(BuildContext context) {
  showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Account Created'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('You can now sign in into the account.'),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: const Text('OK'))
          ],
        );
      });
}
