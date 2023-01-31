import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // this basically makes it so you can't instantiate this class

  static const int _black = 0xff262525;
  static const int _purpleGrey = 0xff71686c;
  static const int _greyishBrown = 0xff3f3f3f;
  static const int _pigPink = 0xffe58ea0;
  static const int _lightPink = 0xfff7f5f6;
  static const int _mediumPink = 0xffe1709d;
  static const int _greyishPink = 0xffff96c0;
  static const int _veryLightPink = 0xffd0d0d0;
  static const int _strawberry = 0xffe8343b;
  static const int _greyWhite = 0xfff8f8f8;
  static const int _white = 0xfff4f4f4;

  static Color get black => const Color(_black);
  static Color get purpleGrey => const Color(_purpleGrey);
  static Color get greyishBrown => const Color(_greyishBrown);
  static Color get pigPink => const Color(_pigPink);
  static Color get lightPink => const Color(_lightPink);
  static Color get mediumPink => const Color(_mediumPink);
  static Color get greyishPink => const Color(_greyishPink);
  static Color get veryLightPink => const Color(_veryLightPink);
  static Color get strawberry => const Color(_strawberry);
  static Color get greyWhite => const Color(_greyWhite);
  static Color get white => const Color(_white);
}
