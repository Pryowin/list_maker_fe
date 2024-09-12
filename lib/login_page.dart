import 'package:flutter/material.dart';
import 'package:list_maker/services/auth_service.dart';
import 'package:list_maker/widgets/login_textfield.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formkey = GlobalKey<FormState>();
  // TODO Change print statements to Debug
  Future<void> loginUser(BuildContext context) async {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      print(emailController.text);
      print(passwordController.text);

      //TODO Add call to API to validate login.
      await context
          .read<AuthService>()
          .loginUser(emailController.text, "JWT", "REFRESH");

      //TODO fix issue with context
      Navigator.pushReplacementNamed(context, '/lists',
          arguments: emailController.text);
      print('login successful');
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
          const Text('Let\'s Sign You In',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5)),
          const Text(
            'Welcome Back! \nYou\'ve been missed',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.brown,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5),
          ),
          Image.asset(
            'assets/images/list.jpg',
            height: 200,
          ),
          //TODO Implement email validation
          Form(
              key: _formkey,
              child: Column(children: [
                LoginTextfield(
                  controller: emailController,
                  hintText: 'Enter your email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email must be provided";
                    }
                    if (value.length < 6) {
                      return "Invalid email";
                    }
                    return null;
                  },
                ),
                LoginTextfield(
                  controller: passwordController,
                  hintText: "Enter your password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password must be provided";
                    }
                    if (value.length < 8 || value.length > 20) {
                      return "Password must be between 8 and 20 characters in length.";
                    }
                    return null;
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
