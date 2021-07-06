import 'package:flutter/material.dart';

class AppColors {
  static const Color error = Colors.red;
  static const Color background = Colors.transparent;
  static const MaterialColor orange =
      MaterialColor(_orangePrimaryValue, <int, Color>{
    50: Color(0xFFFCEEEA),
    100: Color(0xFFF8D4CB),
    200: Color(0xFFF3B7A8),
    300: Color(0xFFEE9A85),
    400: Color(0xFFEB856B),
    500: Color(_orangePrimaryValue),
    600: Color(0xFFE4674A),
    700: Color(0xFFE05C40),
    800: Color(0xFFDD5237),
    900: Color(0xFFD74027),
  });
  static const int _orangePrimaryValue = 0xFFE76F51;

  static const MaterialColor gray =
      MaterialColor(_grayPrimaryValue, <int, Color>{
    50: Color(0xFFF0F0F0),
    100: Color(0xFFD9D9D9),
    200: Color(0xFFC0C0C0),
    300: Color(0xFFA6A6A6),
    400: Color(0xFF939393),
    500: Color(_grayPrimaryValue),
    600: Color(0xFF787878),
    700: Color(0xFF6D6D6D),
    800: Color(0xFF636363),
    900: Color(0xFF505050),
  });
  static const int _grayPrimaryValue = 0xFF808080;

  static const MaterialColor input =
      MaterialColor(_inputPrimaryValue, <int, Color>{
    50: Color(0xFFF1E6E3),
    100: Color(0xFFDDBFB8),
    200: Color(0xFFC69589),
    300: Color(0xFFAF6B5A),
    400: Color(0xFF9D4B36),
    500: Color(_inputPrimaryValue),
    600: Color(0xFF842611),
    700: Color(0xFF79200E),
    800: Color(0xFF6F1A0B),
    900: Color(0xFF5C1006),
  });
  static const int _inputPrimaryValue = 0xFF8C2B13;

  static const MaterialColor lightgray =
      MaterialColor(_lightgrayPrimaryValue, <int, Color>{
    50: Color(0xFFFEFEFE),
    100: Color(0xFFFCFCFC),
    200: Color(0xFFFAFAFA),
    300: Color(0xFFF8F8F8),
    400: Color(0xFFF7F7F7),
    500: Color(_lightgrayPrimaryValue),
    600: Color(0xFFF4F4F4),
    700: Color(0xFFF2F2F2),
    800: Color(0xFFF0F0F0),
    900: Color(0xFFEEEEEE),
  });
  static const int _lightgrayPrimaryValue = 0xFFF5F5F5;
}
