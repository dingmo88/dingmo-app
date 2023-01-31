import 'dart:math';

import 'package:dingmo/api/api_profile_plan.dart';
import 'package:dingmo/api/commons/api_response.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/main/mypage/widgets/mypage_buttons.dart';
import 'package:dingmo/ui/main/mypage/widgets/mypage_menu.dart';
import 'package:dingmo/ui/widgets/light_status_bar.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../routes/arguments/arg_plan_profile.dart';
import '../../profile/widgets/profile_image.dart';
import '../../widgets/texts.dart';

class PlanMypageTab extends StatefulWidget {
  const PlanMypageTab({Key? key}) : super(key: key);

  @override
  State<PlanMypageTab> createState() => _PlanMypageTabState();
}

class _PlanMypageTabState extends State<PlanMypageTab> {
  late Future<ApiResponse<GetPlanMypageResult>> _getMypageFuture;
  @override
  void initState() {
    super.initState();
    _loadMypage();
  }

  void _loadMypage() {
    _getMypageFuture = getIt<ApiProfilePlan>().mypage();
  }

  void _reloadMypage() {
    setState(() {
      _getMypageFuture = getIt<ApiProfilePlan>().mypage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ApiResponse<GetPlanMypageResult>>(
      future: _getMypageFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PlanMypageTabContent(
            data: snapshot.data!.result,
            onProfileUpdated: _reloadMypage,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.mediumPink,
            ),
          );
        }
      },
    );
  }
}

class PlanMypageTabContent extends StatefulWidget {
  final GetPlanMypageResult data;
  final void Function() onProfileUpdated;
  const PlanMypageTabContent(
      {Key? key, required this.data, required this.onProfileUpdated})
      : super(key: key);

  @override
  State<PlanMypageTabContent> createState() => _PlanMypageTabContentState();
}

class _PlanMypageTabContentState extends State<PlanMypageTabContent> {
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
                                Navigator.pushNamed(context, Routes.mySettings);
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
                                              context, Routes.planEditProfile)
                                          .then((isOk) {
                                        if (isOk == true) {
                                          widget.onProfileUpdated();
                                        }
                                      });
                                    },
                                    child: Container(
                                        color: Colors.transparent,
                                        child: Column(
                                          children: [
                                            ProfileImageWidget(
                                                profileImgKey:
                                                    widget.data.profileImgKey),
                                            const SizedBox(height: 10),
                                            Texts.defaultText(
                                                text: widget.data.nickname,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                            const SizedBox(height: 5),
                                            Texts.defaultText(
                                                color: AppColors.veryLightPink,
                                                text: "웨딩플래너",
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal),
                                          ],
                                        )),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(children: [
                                    Expanded(
                                        child: ProfileMenuButton(
                                      enabled: true,
                                      icon: SvgPicture.asset(
                                          "assets/mypage/bookmark_icon.svg",
                                          color: AppColors.black),
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
                                      enabled: widget.data.consultAllow,
                                      icon: widget.data.consultAllow
                                          ? SvgPicture.asset(
                                              "assets/mypage/consult_icon.svg",
                                              width: 20,
                                            )
                                          : SvgPicture.asset(
                                              "assets/mypage/notconsult_icon.svg",
                                              width: 20,
                                            ),
                                      name: widget.data.consultAllow
                                          ? "상담 내역"
                                          : "고객상담 비활성화",
                                      onPressed: () {
                                        if (widget.data.consultAllow) {
                                          Fluttertoast.showToast(
                                              msg: "coming soon!");
                                          // Navigator.pushNamed(
                                          //     context, Routes.consultRooms);

                                        }
                                      },
                                    )),
                                  ]),
                                  const SizedBox(height: 35),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, Routes.planProfile,
                                              arguments: PlanProfileArgs(
                                                  profileId:
                                                      widget.data.profileId));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary: AppColors.mediumPink,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        child: Container(
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 20),
                                          child: const Center(
                                              child: Text(
                                            "내 계정 바로가기",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white),
                                          )),
                                        )),
                                  ),
                                  const SizedBox(height: 30),
                                ],
                              )),
                          const SizedBox(height: 10),
                          Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.white,
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 5),
                              child: Text("쿠폰 및 정보",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.veryLightPink))),
                          MyPageMenu(
                              name: "내 발행 쿠폰",
                              onPressed: () {
                                Fluttertoast.showToast(msg: "coming soon!");
                                // Navigator.pushNamed(context, Routes.myCoupons);
                              }),
                          MyPageMenu(
                              name: "내 정보",
                              onPressed: () => Navigator.pushNamed(
                                  context, Routes.planMyInfo)),
                          const SizedBox(height: 1),
                          Container(
                              alignment: Alignment.centerLeft,
                              color: Colors.white,
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20, bottom: 5),
                              child: Text("이용안내",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: AppColors.veryLightPink))),
                          MyPageMenu(
                              name: "1:1 문의",
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.inquiry)),
                          MyPageMenu(
                              name: "공지사항",
                              onPressed: () {
                                // Navigator.pushNamed(context, Routes.notice);
                                Fluttertoast.showToast(msg: "coming soon!");
                              }),
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
