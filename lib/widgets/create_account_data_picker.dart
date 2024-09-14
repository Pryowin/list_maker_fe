import 'package:flutter/material.dart';
import 'package:list_maker/utils/text_fields_styles.dart';

class CreateAccountDatePicker extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;

  const CreateAccountDatePicker({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: 600,
        child: Row(children: [
          SizedBox(
              width: 200,
              child: Text(label, style: ThemeTextStyle.labelTextFieldStyle)),
          SizedBox(
            width: 400,
            child: TextFormField(
              readOnly: true,
              controller: controller,
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime(DateTime.now().year - 18,
                      DateTime.now().month, DateTime.now().day),
                  firstDate: DateTime(1900, 1, 1),
                  lastDate: DateTime(DateTime.now().year - 18,
                      DateTime.now().month, DateTime.now().day),
                );
                if (picked != null) {
                  controller.text = picked.toString().split(' ')[0];
                }
              },
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: ThemeTextStyle.loginTextFieldStyle,
                border: ThemeTextStyle.loginBorderFieldStyle,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
