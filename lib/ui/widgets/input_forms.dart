import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';

class InputForms {
  static TextFormField multiLineLimitTextForm(
      FocusNode focusNode,
      TextEditingController controller,
      SetStringFunc onChanged,
      int maxLines,
      int maxLength,
      {Widget? suffixIcon,
      String? hint}) {
    return TextFormField(
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
        maxLength: maxLength,
        autofocus: false,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.veryLightPink,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.mediumPink,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: hint ?? "",
            hintStyle:
                TextStyle(fontSize: 14, color: AppColors.veryLightPink)));
  }

  static TextFormField textInputForm(FocusNode focusNode,
      TextEditingController controller, SetStringFunc onChanged,
      {SetStringFunc? onSubmitted,
      Widget? suffixIcon,
      EdgeInsets? suffixPadding,
      String? hint,
      bool? isEnabled}) {
    return TextFormField(
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.text,
        autofocus: false,
        onFieldSubmitted: (text) {
          if (onSubmitted != null) {
            onSubmitted(text);
          }
        },
        decoration: InputDecoration(
            enabled: isEnabled ?? true,
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.veryLightPink,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.veryLightPink,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.mediumPink,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: hint ?? "",
            hintStyle:
                TextStyle(fontSize: 14, color: AppColors.veryLightPink)));
  }

  static TextFormField numInputForm(FocusNode focusNode,
      TextEditingController controller, SetStringFunc onChanged,
      {Widget? suffixIcon, String? hint, bool? isEnabled}) {
    return TextFormField(
        focusNode: focusNode,
        enabled: isEnabled ?? true,
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        autofocus: false,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.veryLightPink,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.mediumPink,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.mediumPink.withOpacity(0.6),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: hint ?? "",
            hintStyle:
                TextStyle(fontSize: 14, color: AppColors.veryLightPink)));
  }

  static TextFormField passInutForm(
    FocusNode focusNode,
    TextEditingController controller,
    SetStringFunc onChanged,
    bool obscureText, {
    Widget? suffixIcon,
    String? hint,
  }) {
    return TextFormField(
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
        obscureText: obscureText,
        autofocus: false,
        decoration: InputDecoration(
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints.tight(const Size(44, 44)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.veryLightPink,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.mediumPink,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            hintText: hint,
            hintStyle:
                TextStyle(fontSize: 14, color: AppColors.veryLightPink)));
  }
}
