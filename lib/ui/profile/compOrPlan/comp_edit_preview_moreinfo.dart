import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/ui/commons/items/consulting_items.dart';
import 'package:dingmo/ui/profile/compOrPlan/widgets/profile_info.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../utils/time/time_utils.dart';
import 'forms/comp_edit_profile_form.dart';

class CompEditProfilePreviewMoreInfoPage extends StatefulWidget {
  final CompEditProfileForm form;
  const CompEditProfilePreviewMoreInfoPage({Key? key, required this.form})
      : super(key: key);

  @override
  State<CompEditProfilePreviewMoreInfoPage> createState() =>
      _CompEditProfilePreviewMoreInfoPageState();
}

class _CompEditProfilePreviewMoreInfoPageState
    extends State<CompEditProfilePreviewMoreInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "더보기"),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.horizontalPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      ProfileInfoWidget(
                        icon: SvgPicture.asset(
                          "assets/profile/ring_icon.svg",
                          color: AppColors.veryLightPink,
                        ),
                        name: "소개",
                        description: widget.form.intro?.isNotEmpty == true
                            ? widget.form.intro
                            : "-",
                      ),
                      const SizedBox(height: 20),
                      ProfileInfoWidget(
                        icon: SvgPicture.asset(
                          "assets/profile/ring_icon.svg",
                          color: AppColors.veryLightPink,
                        ),
                        name: "주소",
                        description: widget.form.addr != null
                            ? "${widget.form.addr} ${widget.form.addrDetails}"
                            : "-",
                      ),
                      // 개발 속도 상의 이유로 배제
                      // const SizedBox(height: 10),
                      // Container(
                      //     margin: EdgeInsets.only(
                      //         left: MediaQuery.of(context).size.width * 0.25),
                      //     child: Buttons.textButton(
                      //         text: "지도보기",
                      //         onTap: () {},
                      //         fontSize: 13,
                      //         color: AppColors.mediumPink,
                      //         // is empty, then veryLightPink.
                      //         width: 50)),
                      const SizedBox(height: 20),
                      ProfileInfoWidget(
                        icon: SvgPicture.asset(
                          "assets/profile/ring_icon.svg",
                          color: AppColors.veryLightPink,
                        ),
                        name: "영업시간",
                        description: widget.form.workTime ?? "-",
                      ),
                      const SizedBox(height: 20),
                      ProfileInfoWidget(
                        icon: SvgPicture.asset(
                          "assets/profile/ring_icon.svg",
                          color: AppColors.veryLightPink,
                        ),
                        name: "상담시간",
                        description: consultText(),
                      ),
                      const SizedBox(height: 25),
                    ]),
              )
            ],
          )),
          SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
              delegate: SliverChildBuilderDelegate(
                  childCount: 120,
                  (context, index) => Container(
                        color: AppColors.greyWhite,
                        child: const Center(child: Text("화보")),
                      ))),
        ],
      ),
    );
  }

  String consultText() {
    if (widget.form.consultAllow != true) {
      return "-";
    }

    if (widget.form.consultOpenTime == null ||
        widget.form.consultCloseTime == null) {
      return "-";
    }

    if (widget.form.consultDays.isEmpty) {
      return "-";
    }

    return "${widget.form.consultDays.map((e) => dayStrToDisplayStr(e)).join(", ")}\n"
        "${TimeUtils.toDisplayTime(widget.form.consultOpenTime)} ~ ${TimeUtils.toDisplayTime(widget.form.consultCloseTime)}";
  }

  TimeOfDay? toTimeOfDay(String? timeStr) {
    if (timeStr == null) {
      return null;
    }
    final timeUnits = timeStr.split(":");

    return TimeOfDay(
        hour: int.parse(timeUnits[0]), minute: int.parse(timeUnits[1]));
  }

  String getTime(TimeOfDay? start, TimeOfDay? end) {
    return start == null || end == null
        ? "-"
        : "${TimeUtils.getTime(start)}"
            " ~ ${TimeUtils.getTime(end)}";
  }
}
