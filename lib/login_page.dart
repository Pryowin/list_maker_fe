import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:list_maker/create_account.dart';
import 'package:list_maker/services/api_service.dart';
import 'package:list_maker/services/auth_service.dart';
import 'package:list_maker/services/http_response_codes.dart';
import 'package:list_maker/utils/dialog_box.dart';
import 'package:list_maker/utils/text_fields_styles.dart';
import 'package:list_maker/validators/common_validators.dart';
import 'package:list_maker/widgets/login_textfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formkey = GlobalKey<FormState>();

  Future<void> loginUser(BuildContext context) async {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      final email = emailController.text;
      final password = passwordController.text;

      final formData = {'email': email, 'password': password};

      final apiService = Provider.of<ApiService>(context, listen: false);
      try {
        final response = await apiService.postRequest('/get_token',
            data: formData, expectedErrorStatusCode: ResponseCode.unauthorized);
        if (response.statusCode == ResponseCode.unauthorized) {
          showErrorDialog(
              // ignore: use_build_context_synchronously
              context,
              "Login failed: Bad Password or email address.");
        } else {
          if (context.mounted) {
            await context.read<AuthService>().loginUser(emailController.text);
          }

          if (context.mounted) {
            Navigator.pushReplacementNamed(context, '/lists',
                arguments: emailController.text);
            if (kDebugMode) {
              print('login successful');
            }
            emailController.clear();
            passwordController.clear();
          }
        }
      } on DioException catch (de) {
        showErrorDialog(
            // ignore: use_build_context_synchronously
            context,
            "Login failed $de. Please try again later.");
      }
    }
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Welcome to List Maker',
              style: ThemeTextStyle.headingOneTextStyle),
          Text(
            'Log In or click link below to create an account',
            textAlign: TextAlign.center,
            style: ThemeTextStyle.headingTwoTextStyle,
          ),
          const SizedBox(height: 10),
          GestureDetector(
            child: Text(
              'Create an Account',
              style: TextStyle(
                color: Colors.blue,
                fontSize: ThemeTextStyle.mediumFont,
                decoration: TextDecoration.underline,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateAccount()),
              );
            },
          ),
          const SizedBox(height: 10),
          Image.asset(
            'assets/images/list.jpg',
            height: 200,
          ),
          Form(
              key: _formkey,
              child: Column(children: [
                LoginTextfield(
                    controller: emailController,
                    hintText: 'Enter your email',
                    validator: (value) {
                      return validateEmail(value);
                    }),
                LoginTextfield(
                  controller: passwordController,
                  hintText: "Enter your password",
                  validator: (value) {
                    return validateTextField(
                        fieldName: 'Password',
                        textField: value,
                        min: 8,
                        max: 20);
                  },
                  hideText: true,
                ),
                ElevatedButton(
                    onPressed: () async {
                      await loginUser(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade50),
                    child: const Text('Login',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w300))),
              ]))
        ])));
  }
}
