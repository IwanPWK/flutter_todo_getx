import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Get.isDarkMode ? Colors.grey[400] : Colors.grey));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(textStyle: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Get.isDarkMode ? Colors.white : Colors.black));
}

TextStyle get biggerTitleStyle {
  return GoogleFonts.lato(fontSize: 26, color: Get.isDarkMode ? Colors.white : Colors.black);
}

TextStyle get biggerSubHeadingStyle {
  return GoogleFonts.lato(fontSize: 18, color: Get.isDarkMode ? Colors.grey[200] : Colors.grey);
}

TextStyle get titleStyle {
  return GoogleFonts.lato(fontSize: 18, color: Get.isDarkMode ? Colors.white : Colors.black);
}

TextStyle get subTitleStyle {
  return GoogleFonts.lato(fontSize: 16, color: Get.isDarkMode ? Colors.white : Colors.black);
}
