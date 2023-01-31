import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';

class DingmoProgressIndicator extends StatelessWidget {
  final double size;
  final EdgeInsets? margin;
  const DingmoProgressIndicator({Key? key, required this.size, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.only(),
      width: size,
      height: size,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppColors.mediumPink,
            strokeWidth: 2,
          ),
        ],
      ),
    );
  }
}
