import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:list_maker/services/api_service.dart';
import 'package:list_maker/services/http_response_codes.dart';
import 'package:list_maker/utils/build_duplicate_error.dart';
import 'package:list_maker/utils/dialog_box.dart';
import 'package:list_maker/validators/common_validators.dart';
import 'package:list_maker/widgets/account_created_dialog.dart';
import 'package:list_maker/widgets/create_account_data_picker.dart';
import 'package:list_maker/widgets/create_account_textfield.dart';
import 'package:list_maker/widgets/show_password_requirements.dart';
import 'package:provider/provider.dart';

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

      final formData = {
        'user_name': userName,
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'date_of_birth': dateOfBirth,
        'password': password,
        'password_confirm': passwordRetyped
      };
      final apiService = Provider.of<ApiService>(context, listen: false);
      try {
        final response = await apiService.postRequest('/create_user',
            data: formData, expectedErrorStatusCode: ResponseCode.recordExists);
        if (context.mounted) {
          if (response.statusCode == ResponseCode.recordExists) {
            final errorMessage =
                "Account Not Created\n\n ${buildDuplicateError(response.data)}";
            showErrorDialog(context, errorMessage);

            if (kDebugMode) {
              print("Duplicate Data");
            }
          } else {
            accountCreatedDialog(context);
          }
        }
      } on DioException catch (de) {
        if (kDebugMode) {
          print('Account creation failed $de');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create Account'),
        ),
        body: Column(children: [accountCreationForm(context)]));
  }

  Form accountCreationForm(BuildContext context) {
    return Form(
        key: _formkey,
        child: Column(
          children: [
            CreateAccountTextfield(
              controller: userNameController,
              label: 'User Name:',
              hintText: 'Enter a user name for this app',
              validator: (value) {
                return validateTextField(
                    fieldName: 'User Name', textField: value, min: 3, max: 20);
              },
            ),
            CreateAccountTextfield(
              controller: firstNameController,
              label: 'First Name:',
              hintText: 'Enter your first name.',
              validator: (value) {
                return validateTextField(
                    fieldName: 'First Name', textField: value, min: 1, max: 20);
              },
            ),
            CreateAccountTextfield(
              controller: lastNameController,
              label: 'Last Name:',
              hintText: 'Enter your last name.',
              validator: (value) {
                return validateTextField(
                    fieldName: 'Last Name', textField: value, min: 1, max: 20);
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
                return validatePassword(value, passwordRetypedController.text);
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
                showPasswordRequirements(context);
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
        ));
  }
}
