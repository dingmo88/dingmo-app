import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/main/mypage/widgets/user_point.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/infinity_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'items/user_point.dart';
import 'widgets/point_guide.dart';

class UserMyPointsPage extends StatefulWidget {
  const UserMyPointsPage({Key? key}) : super(key: key);

  @override
  State<UserMyPointsPage> createState() => _UserMyPointsPageState();
}

class _UserMyPointsPageState extends State<UserMyPointsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "포인트"),
      body: InfinityListWidget<UserPointItem>(
          header: Column(children: [
            Container(
              color: AppColors.mediumPink,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "[김단] 님의 포인트",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "1,000 P",
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      color: Colors.white,
                      height: 1,
                      width: double.infinity,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "이번달 소멸 예정 포인트",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                        Text(
                          "0 P",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    )
                  ]),
            ),
            GestureDetector(
              onTap: showPointGuideDialog,
              child: Container(
                color: AppColors.greyWhite,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(children: [
                  Text(
                    "포인트 안내",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.greyishBrown,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 5),
                  SvgPicture.asset("assets/mypage/info_icon.svg")
                ]),
              ),
            )
          ]),
          itemBuilder: (context, item, index) =>
              UserPointItemWidget(item: item),
          onLoad: getUserPoints,
          pageSize: 8),
    );
  }

  void showPointGuideDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const PointGuideDialog();
        });
  }

  Future<List<UserPointItem>> getUserPoints(int startIdx, int pageSize) {
    return Future.delayed(const Duration(seconds: 1), () {
      final List<UserPointItem> items = [];

      items.add(UserPointItem(
        name: "사진 게시물 등록",
        dateEvented: "2022.04.23",
        point: 50,
        isGained: true,
      ));
      items.add(UserPointItem(
        name: "딩모숏 등록",
        dateEvented: "2022.04.23",
        point: 50 + 1,
        isGained: true,
      ));
      items.add(UserPointItem(
        name: "딩모숏 조회",
        dateEvented: "2022.04.23",
        point: 50 + 2,
        isGained: true,
      ));
      items.add(UserPointItem(
        name: "친구초대",
        dateEvented: "2022.04.23",
        point: 50 + 3,
        isGained: true,
      ));
      items.add(UserPointItem(
        name: "댓글 답글 등록",
        dateEvented: "2022.04.23",
        point: 50 + 4,
        isGained: true,
      ));
      items.add(UserPointItem(
        name: "업체 후기 등록",
        dateEvented: "2022.04.23",
        point: 50 + 5,
        isGained: true,
      ));
      items.add(UserPointItem(
        name: "회원가입",
        dateEvented: "2022.04.23",
        point: 50 + 6,
        isGained: true,
      ));
      items.add(UserPointItem(
        name: "LG 가전 사용",
        dateEvented: "2022.04.23",
        point: 50 + 7,
        isGained: false,
      ));
      return items;
    });
  }
}
