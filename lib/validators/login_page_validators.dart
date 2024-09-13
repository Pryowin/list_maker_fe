import 'package:email_validator/email_validator.dart';

String? isPasswordValid(value) {
  if (value == null || value.isEmpty) {
    return "Password must be provided";
  }
  if (value.length < 8 || value.length > 20) {
    return "Password must be between 8 and 20 characters in length.";
  }
  return null;
}

String? isEmailValid(String? email) {
  if (email == null || email.isEmpty) {
    return "Email address must be provided.";
  }
  return EmailValidator.validate(email) ? null : "Invalid Email Address";
}
