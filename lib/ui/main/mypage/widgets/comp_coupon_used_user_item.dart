import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/main/mypage/items/comp_coupon_used_user_item.dart';
import 'package:flutter/material.dart';

class CompCouponUsedUserItemWidget extends StatelessWidget {
  final CompCouponUsedUserItem item;
  const CompCouponUsedUserItemWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                      color: AppColors.greyWhite,
                      child: CachedNetworkImage(
                        imageUrl: item.profileUrl,
                        width: 28,
                        height: 28,
                        errorWidget: (context, exception, stackTrace) {
                          return Container(
                            width: 28,
                            height: 28,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/dingmo.png",
                            ),
                          );
                        },
                      )),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nickname,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.greyishBrown,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.category,
                      style:
                          TextStyle(fontSize: 12, color: AppColors.purpleGrey),
                    )
                  ],
                )
              ],
            ),
            Text(
              item.dateUsed,
              style: TextStyle(fontSize: 12, color: AppColors.purpleGrey),
            )
          ]),
    );
  }
}
