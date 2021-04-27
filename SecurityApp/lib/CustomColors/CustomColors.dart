import 'package:flutter/material.dart';
final ThemeData CompanyThemeData = new ThemeData(
    brightness: Brightness.light,

    primaryColor: CustomColors.actionbarcolor,
    primaryColorBrightness: Brightness.light,
    accentColor: CustomColors.RedPrimaryValue,
    accentColorBrightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

class CustomColors{
  CustomColors._();
  static const _blackPrimaryValue = 0xFF000000;
  static const orangecolor = Color.fromARGB(200,236, 142, 0);
  static const  RedPrimaryValue =  const Color(0xFFD11015);

  static const  greyBackground =  const Color(0xFFEAEAEA);

  static const  maintextcolor =  const Color(0xFFB4B5B7);
  static const  greyalpha50 =  const Color(0xD9FFFFFF);
  static const  greyedittextfield =  const Color(0xFFF7F7F7);

  static const  textnormalcolor =  const Color(0xFFD0D2D5);
  static const  actionbarcolor =  const Color(0xFF4C5564);
  static const homelistviewbackground = const Color(0xFFEAEAEA);


  static const textfieldbackground = const Color(0xFFF6F7FB);
static const sometextgreycolor = const Color(0xFFA3A4A8);
  static const MaterialColor black = const MaterialColor(
    _blackPrimaryValue,
    const <int, Color>{
      50:  const Color(0xFFe0e0e0),
      100: const Color(0xFFb3b3b3),
      200: const Color(0xFF808080),
      300: const Color(0xFF4d4d4d),
      400: const Color(0xFF262626),
      500: const Color(_blackPrimaryValue),
      600: const Color(0xFF000000),
      700: const Color(0xFF000000),
      800: const Color(0xFF000000),
      900: const Color(0xFF000000),
    },
  );






}