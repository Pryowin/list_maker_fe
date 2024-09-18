import 'package:flutter/material.dart';

void showPasswordRequirements(BuildContext context) {
  showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Password Requirements'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Password must be between 8 and 20 characters.'),
                Text('At least one upper case letter.'),
                Text('At least one lower case letter.'),
                Text('At least one number.'),
                Text('At least one special character.'),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Understood'))
          ],
        );
      });
}
