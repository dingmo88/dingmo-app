import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';

class PWSecurityLevelWidget extends StatefulWidget {
  final int securityLevel;

  const PWSecurityLevelWidget({required this.securityLevel, Key? key})
      : super(key: key);

  @override
  State<PWSecurityLevelWidget> createState() => _PWSecurityLevelWidgetState();
}

class _PWSecurityLevelWidgetState extends State<PWSecurityLevelWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        widget.securityLevel >= 4 ? "안전" : "약함",
        style: TextStyle(fontSize: 12, color: AppColors.mediumPink),
      ),
      const SizedBox(width: 5),
      Container(
        width: 20,
        height: 4,
        decoration: BoxDecoration(
          color: 1 <= widget.securityLevel
              ? AppColors.mediumPink
              : AppColors.veryLightPink,
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      const SizedBox(width: 5),
      Container(
        width: 20,
        height: 4,
        decoration: BoxDecoration(
          color: 3 <= widget.securityLevel
              ? AppColors.mediumPink
              : AppColors.veryLightPink,
          borderRadius: BorderRadius.circular(2.0),
        ),
      ),
      const SizedBox(width: 5),
      Container(
        width: 20,
        height: 4,
        decoration: BoxDecoration(
          color: 4 <= widget.securityLevel
              ? AppColors.mediumPink
              : AppColors.veryLightPink,
          borderRadius: BorderRadius.circular(2.0),
        ),
      )
    ]);
  }
}
