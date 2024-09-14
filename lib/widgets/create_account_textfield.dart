import 'package:flutter/material.dart';
import 'package:list_maker/utils/text_fields_styles.dart';

class CreateAccountTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool hideText;

  const CreateAccountTextfield(
      {super.key,
      required this.controller,
      required this.label,
      required this.hintText,
      this.validator,
      this.hideText = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 600,
        child: Row(
          children: [
            SizedBox(
                width: 200,
                child: Text(label, style: ThemeTextStyle.labelTextFieldStyle)),
            SizedBox(
              width: 400,
              child: TextFormField(
                validator: (value) {
                  if (validator != null) return validator!(value);
                  return null;
                },
                controller: controller,
                obscureText: hideText,
                decoration: InputDecoration(
                  hintStyle: ThemeTextStyle.loginTextFieldStyle,
                  hintText: hintText,
                  border: ThemeTextStyle.loginBorderFieldStyle,
                  errorStyle: const TextStyle(
                    color: Colors.red,
                  ),
                  errorBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
