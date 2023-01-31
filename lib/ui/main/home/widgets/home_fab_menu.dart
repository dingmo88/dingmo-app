import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class HomeFABMenuWidget extends StatelessWidget {
  final Widget icon;
  final String label;
  final void Function() onPressed;
  const HomeFABMenuWidget(
      {Key? key,
      required this.icon,
      required this.label,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(15),
        color: Colors.transparent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.greyishBrown,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
