import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:list_maker/validators/common_validators.dart';
import 'package:list_maker/widgets/create_account_data_picker.dart';
import 'package:list_maker/widgets/create_account_textfield.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});

  final _formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRetypedController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  Future<void> createUserAccount(BuildContext context) async {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      final userName = userNameController.text;
      final email = emailController.text;
      final firstName = firstNameController.text;
      final lastName = lastNameController.text;
      final password = passwordController.text;
      final dateOfBirth = dateOfBirthController.text;
      final passwordRetyped = passwordRetypedController.text;

      if (kDebugMode) {
        debugPrint("Creating User Account");
        debugPrint('User name = $userName');
        debugPrint('First name = $firstName');
        debugPrint('Last name = $lastName');
        debugPrint('Email = $email');
        debugPrint('DOB = $dateOfBirth');
        debugPrint('Password = $password');
        debugPrint('Password = $passwordRetyped');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Account'),
        ),
        body: Column(children: [
          Form(
              key: _formkey,
              child: Column(
                children: [
                  CreateAccountTextfield(
                    controller: userNameController,
                    label: 'User Name:',
                    hintText: 'Enter a user name for this app',
                    validator: (value) {
                      return validateTextField(
                          fieldName: 'User Name',
                          textField: value,
                          min: 3,
                          max: 20);
                    },
                  ),
                  CreateAccountTextfield(
                    controller: firstNameController,
                    label: 'First Name:',
                    hintText: 'Enter your first name.',
                    validator: (value) {
                      return validateTextField(
                          fieldName: 'First Name',
                          textField: value,
                          min: 1,
                          max: 20);
                    },
                  ),
                  CreateAccountTextfield(
                    controller: lastNameController,
                    label: 'Last Name:',
                    hintText: 'Enter your last name.',
                    validator: (value) {
                      return validateTextField(
                          fieldName: 'Last Name',
                          textField: value,
                          min: 1,
                          max: 20);
                    },
                  ),
                  CreateAccountDatePicker(
                    label: 'Date of Birth',
                    hintText: 'Enter Your Date of Birth',
                    controller: dateOfBirthController,
                  ),
                  CreateAccountTextfield(
                      controller: emailController,
                      label: 'Email:',
                      hintText: 'Enter your email address.',
                      validator: (value) {
                        return validateEmail(value);
                      }),
                  CreateAccountTextfield(
                    controller: passwordController,
                    label: 'Password:',
                    hintText: 'Enter the password you wish to use.',
                    hideText: true,
                    validator: (value) {
                      return validatePassword(
                          value, passwordRetypedController.text);
                    },
                  ),
                  CreateAccountTextfield(
                    controller: passwordRetypedController,
                    label: 'Reenter Password:',
                    hintText: 'Enter the password again.',
                    hideText: true,
                  ),
                  GestureDetector(
                    child: const Text(
                      'Password requirements',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
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
                                    Text(
                                        'Password must be between 8 and 20 characters.'),
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
                    },
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          await createUserAccount(context);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade50),
                        child: const Text('Create Account',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w300))),
                  ),
                ],
              ))
        ]));
  }
}
