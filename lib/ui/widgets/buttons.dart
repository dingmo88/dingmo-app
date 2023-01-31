import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';

class Buttons {
  static ElevatedButton defaultButton(
      {required final String text, required final VoidFunc onPressed}) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: AppColors.mediumPink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
          ),
        ));
  }

  static GestureDetector textButton(
      {required final String text,
      required final VoidFunc? onTap,
      final Color? color,
      final double? fontSize,
      final FontWeight? fontWeight,
      final bool? isEnabled,
      final double? width}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 40,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontSize ?? 14,
              color: (color ?? AppColors.purpleGrey)
                  .withOpacity((isEnabled ?? true) ? 1 : 0.6),
              fontWeight: fontWeight ?? FontWeight.w700),
        ),
      ),
    );
  }
}
