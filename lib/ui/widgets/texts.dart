import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';

class Texts {
  static Text defaultText(
      {required String text,
      required double fontSize,
      Color? color,
      double? height,
      FontWeight? fontWeight}) {
    return Text(text,
        style: TextStyle(
            fontSize: fontSize,
            color: color ?? AppColors.greyishBrown,
            fontWeight: fontWeight ?? FontWeight.w500,
            height: height ?? 0.0));
  }
}
