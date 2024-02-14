import 'package:flutter/material.dart';

const Color bluishColor = Colors.blue;
const Color yellowClr = Color(0xffffb746);
const Color pinkClr = Color(0xffff4667);
const Color white = Color(0xffffffff);
const primaryClr = bluishColor;
const Color darkGreyClr = Color(0xff121212);
const Color darkHeaderClr = Color(0xff424242);

class Themes {
  static final light = ThemeData(
      primaryColor: primaryClr,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        background: white,
      ));
  static final dark = ThemeData(
      primaryColor: darkGreyClr,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        background: darkGreyClr,
      ));
}
