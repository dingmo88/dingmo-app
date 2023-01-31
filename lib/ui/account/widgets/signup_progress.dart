import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SignUpProgressWidget extends StatefulWidget {
  final int progress;
  const SignUpProgressWidget({required this.progress, Key? key})
      : super(key: key);

  @override
  State<SignUpProgressWidget> createState() => _SignUpProgressWidgetState();
}

class _SignUpProgressWidgetState extends State<SignUpProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      animation: true,
      lineHeight: 8.0,
      animationDuration: 250,
      percent: widget.progress / 100,
      barRadius: const Radius.circular(4),
      backgroundColor: AppColors.greyWhite,
      progressColor: AppColors.mediumPink,
    );
  }
}
