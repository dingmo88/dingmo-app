import 'dart:math';

import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';
import '../../widgets/loading.dart';
import 'items/my_coupon_item.dart';
import 'widgets/my_coupon_item.dart';

class UserMyCouponsPage extends StatefulWidget {
  const UserMyCouponsPage({Key? key}) : super(key: key);

  @override
  State<UserMyCouponsPage> createState() => _CompMyCouponsPageState();
}

class _CompMyCouponsPageState extends State<UserMyCouponsPage>
    with SingleTickerProviderStateMixin {
  late final Future<void> loadCouponListFuture;
  final List<MyCouponItem> couponList = [];

  @override
  void initState() {
    super.initState();

    loadCouponListFuture = loadCouponList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "내 쿠폰"),
      backgroundColor: AppColors.greyWhite,
      body: FutureBuilder(
        future: loadCouponListFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Container(
              padding: const EdgeInsets.only(top: 20),
              child: const Center(child: DingmoProgressIndicator(size: 40)),
            );
          } else {
            if (randomNum(0, 5) % 2 == 0) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 150),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(99),
                        color: AppColors.greyWhite,
                      ),
                      child: SvgPicture.asset(
                          "assets/mypage/empty_coupon_icon.svg"),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "사용 가능한 쿠폰이 없어요",
                      style: TextStyle(
                          fontSize: 12, color: AppColors.veryLightPink),
                    )
                  ],
                ),
              );
            }

            return ScrollConfiguration(
                behavior: NoGlowBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(left: 30, top: 35),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: "사용 가능한 쿠폰이",
                                style: TextStyle(
                                    fontSize: 13, color: AppColors.purpleGrey)),
                            TextSpan(
                                text: " 5장 ",
                                style: TextStyle(
                                    fontSize: 13, color: AppColors.mediumPink)),
                            TextSpan(
                                text: "있습니다.",
                                style: TextStyle(
                                    fontSize: 13, color: AppColors.purpleGrey)),
                          ]))),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: couponList.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                                padding: EdgeInsets.only(
                                    top: index == 0 ? 20 : 0,
                                    bottom: index >= couponList.length - 1
                                        ? 80
                                        : 0),
                                child: MyCouponItemWidget(
                                  onPressed: () => Navigator.pushNamed(
                                      context, Routes.useCoupon),
                                  item: couponList[index],
                                ),
                              ))
                    ],
                  ),
                ));
          }
        },
      ),
    );
  }

  Future<void> loadCouponList() {
    return Future.delayed(const Duration(seconds: 1), () {
      for (int idx = 0; idx < 5; idx++) {
        couponList.add(MyCouponItem(
            discount: 30000 + idx,
            dateUntil: DateFormat('yyyy.MM.dd').format(DateTime.now()
              ..add(
                const Duration(days: 5),
              )),
            from: "우리웨딩스튜디오",
            remainedDays: 5));
      }
    });
  }

  int randomNum(int min, int max) => min + Random().nextInt(max - min);
}
