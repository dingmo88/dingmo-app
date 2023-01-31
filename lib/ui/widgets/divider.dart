import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';

class HorizontalDivider extends StatefulWidget {
  const HorizontalDivider({Key? key}) : super(key: key);

  @override
  State<HorizontalDivider> createState() => _HorizontalDividerState();
}

class _HorizontalDividerState extends State<HorizontalDivider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      color: AppColors.veryLightPink,
    );
  }
}
