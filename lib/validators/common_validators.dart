import 'package:email_validator/email_validator.dart';

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return "Email address must be provided.";
  }
  return EmailValidator.validate(email) ? null : "Invalid Email Address";
}

String? validateTextField(
    {required String fieldName,
    String? textField,
    required int min,
    required int max}) {
  if (textField == null || textField.isEmpty) {
    return '$fieldName must be provided.';
  }
  if (textField.length < min || textField.length > max) {
    return '$fieldName must be between $min and $max characters in length.';
  }
  return null;
}

String? validatePassword(String? password, String? retypedPassword) {
  final regex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  if (password == null || password.isEmpty) {
    return "Password must be provided.";
  }
  if (password != retypedPassword) {
    return "Password and reentered password do not match.";
  }
  if (password.length < 8 || password.length > 20) {
    return "Password must be between 8 and 20 characters in length.";
  }
  if (regex.hasMatch(password)) {
    return null;
  } else {
    return "Password does not meet complexity rules";
  }
}
