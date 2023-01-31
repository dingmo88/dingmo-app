import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/main/mypage/widgets/my_coupon_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/description_text.dart';
import 'package:flutter/material.dart';

import 'items/my_coupon_item.dart';

class UseCouponPage extends StatelessWidget {
  const UseCouponPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "쿠폰 사용"),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "[스튜디오] 우리웨딩스튜디오",
              style: TextStyle(
                  fontSize: 16,
                  color: AppColors.greyishBrown,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "유효기간 2021.05.19",
              style: TextStyle(fontSize: 12, color: AppColors.purpleGrey),
            ),
            const SizedBox(height: 15),
            Container(
              height: 1,
              width: double.infinity,
              color: AppColors.white,
            ),
          ]),
        ),
        MyCouponItemWidget(
            item: MyCouponItem(
                discount: 30000,
                from: "우리웨딩스튜디오",
                dateUntil: "2021.05.19 까지",
                remainedDays: 5)),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "유의사항",
                style: TextStyle(fontSize: 13, color: AppColors.greyishBrown),
              ),
              const SizedBox(height: 15),
              DescriptionText(
                  description: "해당 쿠폰은 업체 자체 발행 쿠폰으로 오프라인에서 사용이 가능합니다.",
                  color: AppColors.purpleGrey),
              const SizedBox(height: 10),
              RichDescriptionText(
                  description: couponSuggestionRichText(),
                  color: AppColors.purpleGrey),
              const SizedBox(height: 10),
              DescriptionText(
                  description: "쿠폰 사용기간 초과 시 사용이 불가능 합니다.",
                  color: AppColors.purpleGrey),
              const SizedBox(height: 10),
              DescriptionText(
                  description: "그 외 문의사항이 있으신 경우, 딩모 1:1 문의하기에 남겨주세요.",
                  color: AppColors.purpleGrey),
            ],
          ),
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: AppColors.mediumPink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: const Center(
                    child: Text(
                  "쿠폰 사용하기",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )),
              )),
        ),
        const SizedBox(height: 55),
      ]),
    );
  }

  RichText couponSuggestionRichText() {
    return RichText(
        text: TextSpan(children: [
      TextSpan(
        text: "매장 방문 시 ",
        style: TextStyle(fontSize: 13, color: AppColors.purpleGrey),
      ),
      TextSpan(
        text: "쿠폰 화면을 반드시 제시",
        style: TextStyle(
            fontSize: 13,
            color: AppColors.greyishBrown,
            fontWeight: FontWeight.bold),
      ),
      TextSpan(
        text: "해 주셔야 합니다.",
        style: TextStyle(fontSize: 13, color: AppColors.purpleGrey),
      ),
    ]));
  }
}
