import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';

import '../items/user_point.dart';

class UserPointItemWidget extends StatelessWidget {
  final UserPointItem item;
  const UserPointItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.greyishBrown,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.dateEvented,
                      style: TextStyle(
                          fontSize: 12, color: AppColors.veryLightPink),
                    )
                  ],
                ),
                item.isGained
                    ? Text(
                        "+  ${item.point} P",
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.mediumPink,
                            fontWeight: FontWeight.bold),
                      )
                    : Text(
                        "-  ${item.point} P",
                        style: TextStyle(
                            fontSize: 14,
                            color: AppColors.greyishBrown,
                            fontWeight: FontWeight.bold),
                      )
              ]),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: AppColors.greyWhite,
        )
      ],
    );
  }
}
