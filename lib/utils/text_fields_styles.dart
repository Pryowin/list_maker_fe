import 'package:flutter/material.dart';

class ThemeTextStyle {
  static Color textColor = Colors.cyan;
  static double bigFont = 30;
  static double mediumFont = 20;
  static double smallFont = 12;

  static TextStyle loginTextFieldStyle = const TextStyle(color: Colors.green);
  static OutlineInputBorder loginBorderFieldStyle = const OutlineInputBorder();
  static TextStyle labelTextFieldStyle = TextStyle(
      color: textColor, fontSize: mediumFont, fontWeight: FontWeight.bold);
  static TextStyle headingOneTextStyle = TextStyle(
      color: textColor, fontSize: bigFont, fontWeight: FontWeight.bold);
  static TextStyle headingTwoTextStyle = TextStyle(
      color: textColor, fontSize: mediumFont, fontWeight: FontWeight.bold);
}
