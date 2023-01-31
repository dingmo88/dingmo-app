import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/profile/compOrPlan/items/alarm_item2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AlarmItem2Widget extends StatelessWidget {
  final AlarmItem2 item;
  const AlarmItem2Widget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.compAlarmLikes),
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: AppColors.mediumPink,
                  borderRadius: BorderRadius.circular(99)),
              child: SvgPicture.asset("assets/mypage/mall_icon.svg"),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40 - 40 - 15,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                            fontSize: 13,
                            color: AppColors.greyishBrown,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        item.dateOld,
                        style: TextStyle(
                            fontSize: 12, color: AppColors.veryLightPink),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 40 - 40 - 15 - 40,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    item.content,
                    style: TextStyle(fontSize: 12, color: AppColors.purpleGrey),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
