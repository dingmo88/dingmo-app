import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/main/mypage/items/my_coupon_item.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../widgets/dash_line.dart';

class MyCouponItemWidget extends StatelessWidget {
  final MyCouponItem item;
  final void Function()? onPressed;
  const MyCouponItemWidget({Key? key, required this.item, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ??
          () {
            Fluttertoast.showToast(msg: "coming soon!");
          },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.all(30),
        decoration: const BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
                image: AssetImage("assets/mypage/maincoupon_icon.png"))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "${toMoneyNum(item.discount)}원 할인",
            style: const TextStyle(fontSize: 24, color: Color(0xFF1f1b1d)),
          ),
          const SizedBox(height: 20),
          Text(
            item.from,
            style: TextStyle(fontSize: 13, color: AppColors.greyishBrown),
          ),
          const SizedBox(height: 20),
          DashLine(color: AppColors.veryLightPink),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${item.dateUntil} 까지",
                style: TextStyle(fontSize: 12, color: AppColors.purpleGrey),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mediumPink),
                    borderRadius: BorderRadius.circular(13)),
                child: Text(
                  "D-${item.remainedDays}",
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.mediumPink,
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }

  String toMoneyNum(int discount) {
    return discount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}
