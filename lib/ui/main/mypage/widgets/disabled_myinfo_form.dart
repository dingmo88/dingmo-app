import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';

class DisabledMyInfoFormWidget extends StatelessWidget {
  final String name;
  final String content;
  const DisabledMyInfoFormWidget(
      {Key? key, required this.name, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          name,
          style: TextStyle(
              fontSize: 13,
              color: AppColors.greyishBrown,
              fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        Container(
            decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            child: Text(
              content,
              style: TextStyle(fontSize: 14, color: AppColors.greyishBrown),
            ))
      ],
    );
  }
}
