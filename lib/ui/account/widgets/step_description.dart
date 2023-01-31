import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';

class StepDescriptionWidget extends StatefulWidget {
  final String title;
  final String description;

  const StepDescriptionWidget(
      {Key? key, required this.title, required this.description})
      : super(key: key);

  @override
  State<StepDescriptionWidget> createState() => _StepDescriptionWidgetState();
}

class _StepDescriptionWidgetState extends State<StepDescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Text(
          widget.description,
          style: TextStyle(
              fontSize: 13,
              color: AppColors.purpleGrey,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
