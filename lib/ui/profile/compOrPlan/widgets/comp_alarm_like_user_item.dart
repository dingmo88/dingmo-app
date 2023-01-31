import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/profile/compOrPlan/items/alarm_like_user_item.dart';
import 'package:flutter/material.dart';

class CompAlarmLikeUserItemWidget extends StatelessWidget {
  final AlarmLikeUserItem item;
  const CompAlarmLikeUserItemWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              color: AppColors.greyWhite,
              child: CachedNetworkImage(
                imageUrl: item.profileUrl,
                width: 28,
                height: 28,
                fit: BoxFit.cover,
                errorWidget: (_, __, ___) {
                  return Container(
                    width: 28,
                    height: 28,
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/dingmo.png",
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            )),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.nickname,
              style: TextStyle(
                  fontSize: 14,
                  color: AppColors.greyishBrown,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              item.categoryName,
              style: TextStyle(fontSize: 12, color: AppColors.purpleGrey),
            )
          ],
        )
      ]),
    );
  }
}
