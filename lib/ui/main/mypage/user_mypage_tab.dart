import 'dart:math';

import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/main/mypage/widgets/mypage_buttons.dart';
import 'package:dingmo/ui/main/mypage/widgets/mypage_menu.dart';
import 'package:dingmo/ui/widgets/light_status_bar.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../profile/widgets/profile_image.dart';
import '../../widgets/texts.dart';

class UserMypageTab extends StatefulWidget {
  const UserMypageTab({Key? key}) : super(key: key);

  @override
  State<UserMypageTab> createState() => _UserMypageTabState();
}

class _UserMypageTabState extends State<UserMypageTab> {
  @override
  Widget build(BuildContext context) {
    return LightStatusBarWidget(
        child: Scaffold(
      body: SafeArea(
        child: Container(
            color: AppColors.greyWhite,
            child: Column(
              children: [
                Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "MY",
                          style: TextStyle(
                              fontSize: 16,
                              color: AppColors.greyishBrown,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            AlarmButton(
                                hasNewAlarms: false,
                                onPressed: () {
                                  Fluttertoast.showToast(msg: "coming soon!");
                                  // Navigator.pushNamed(
                                  //     context, Routes.compAlarms);
                                }),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.userMySettings);
                              },
                              child: SvgPicture.asset(
                                  "assets/mypage/setting_icon.svg"),
                            )
                          ],
                        )
                      ],
                    )),
                Expanded(
                  child: ScrollConfiguration(
                      behavior: NoGlowBehavior(),
                      child: SingleChildScrollView(
                        child: Column(children: [
                          Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  const SizedBox(height: 30),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.userMyInfo);
                                    },
                                    child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.16,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.16,
                                              child: Stack(children: [
                                                const ProfileImageWidget(
                                                    profileImgKey:
                                                        "https://picsum.photos/id/652/105/105"),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    width: 20,
                                                    height: 20,
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .greyWhite,
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    child: SvgPicture.asset(
                                                        "assets/profile/pencil_icon.svg"),
                                                  ),
                                                )
                                              ]),
                                            ),
                                            const SizedBox(height: 10),
                                            Texts.defaultText(
                                                text: "딩모웨딩",
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                            const SizedBox(height: 5),
                                            Texts.defaultText(
                                                color: AppColors.veryLightPink,
                                                text: "예비신랑신부",
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ],
                                        )),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(children: [
                                    Expanded(
                                        child: ProfileMenuButton(
                                      icon: SvgPicture.asset(
                                          "assets/mypage/bookmark_icon.svg"),
                                      name: "내 북마크",
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.myBookmarks);
                                      },
                                    )),
                                    Container(
                                      height: 40,
                                      width: 1,
                                      color: AppColors.white,
                                    ),
                                    Expanded(
                                        child: ProfileMenuButton(
                                      icon: SvgPicture.asset(
                                          "assets/mypage/chatt_icon.svg"),
                                      name: "문의 내역",
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Routes.userConsultRooms);
                                      },
                                    )),
                                  ]),
                                  const SizedBox(height: 25),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routes.userMyPoints);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1,
                                              color: AppColors.mediumPink)),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "포인트",
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: AppColors.greyishBrown,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              "1,000 P",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: AppColors.mediumPink,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ]),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              )),
                          const SizedBox(height: 10),
                          MyPageMenu(
                              name: "내 쿠폰",
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.userMyCoupons)),
                          const SizedBox(height: 1),
                          MyPageMenu(
                              name: "나의 게시물",
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.userProfile)),
                          const SizedBox(height: 1),
                          MyPageMenu(
                              name: "내가 남긴 업체 후기",
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.userMyReviews)),
                          const SizedBox(height: 1),
                          MyPageMenu(
                              name: "나의 관심업체",
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.userMyInterests)),
                          const SizedBox(height: 1),
                          MyPageMenu(
                              name: "내가 좋아요한 목록",
                              onPressed: () =>
                                  Fluttertoast.showToast(msg: "내가 좋아요한 목록")),
                        ]),
                      )),
                )
              ],
            )),
      ),
    ));
  }

  int randomNum(int min, int max) => min + Random().nextInt(max - min);
}
