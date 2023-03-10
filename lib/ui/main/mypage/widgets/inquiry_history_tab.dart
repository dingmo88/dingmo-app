import 'dart:math';

import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/main/mypage/items/inquiry_history_item.dart';
import 'package:dingmo/ui/main/mypage/widgets/inquiry_history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/scroll_behavior.dart';
import '../../../widgets/infinity_list.dart';
import '../../../widgets/loading.dart';

class InquiryHistoryTab extends StatefulWidget {
  const InquiryHistoryTab({Key? key}) : super(key: key);

  @override
  State<InquiryHistoryTab> createState() => _InquiryHistoryTabState();
}

class _InquiryHistoryTabState extends State<InquiryHistoryTab> {
  late final int selectedNum;

  @override
  void initState() {
    super.initState();

    selectedNum = randomNum(0, 2) % 2;
  }

  @override
  Widget build(BuildContext context) {
    return selectedNum != 0
        ? ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: InfinityListWidget<InquiryHistoryItem>(
              initLoadingBuilder: (context) => Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.only(top: 20),
                  child: const DingmoProgressIndicator(size: 40)),
              pageSize: 10,
              onLoad: getInquriyHistories,
              header: const SizedBox(height: 25),
              itemBuilder: (context, item, index) =>
                  InquiryHistoryItemWidget(item: item),
            ))
        : Container(
            margin: const EdgeInsets.only(top: 200),
            child: Column(children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
                decoration: BoxDecoration(
                    color: AppColors.greyWhite,
                    borderRadius: BorderRadius.circular(99)),
                child:
                    SvgPicture.asset("assets/mypage/mail_icon.svg", width: 26),
              ),
              const SizedBox(height: 15),
              Text(
                "?????? ????????? ?????????",
                style: TextStyle(fontSize: 12, color: AppColors.veryLightPink),
              )
            ]),
          );
  }

  Future<List<InquiryHistoryItem>> getInquriyHistories(
      int startIdx, int pageSize) {
    return Future.delayed(const Duration(seconds: 1), () {
      final List<InquiryHistoryItem> notices = [];

      for (int idx = startIdx; idx < startIdx + pageSize; idx++) {
        if (idx % 2 == 0) {
          notices.add(
            InquiryHistoryItem(
              title: "???????????? ????????? ????????????.",
              content: '''??????????????? ??? ???????????? ?????? ????????? ???????????? ????????? ????????? ???????????? ????????????.''',
              dateCreated: "2022.04.23",
              imgUrls: [
                "https://picsum.photos/id/${337 + idx}/105/105",
                "https://picsum.photos/id/${337 + idx + 1}/105/105"
              ],
            ),
          );
        } else {
          notices.add(InquiryHistoryItem(
              title: "?????? ????????? ??????????????? ????????? ????????? ????????? ?????????????????????.",
              content:
                  '''?????? ????????? ??????????????? ????????? ????????? ????????? ???????????? ?????? ????????????. ?????? ?????????????????? ????????? ???????????? ????????? ??? ??? ?????? ????????? ??????????????? ?????? ?????????.''',
              dateCreated: "2022.04.23",
              imgUrls: ["https://picsum.photos/id/${337 + idx}/105/105"],
              answer: '''???????????????. ?????? ????????? ?????? ????????? ?????? ?????? ?????? ????????????.

2022.04.22 ??????????????? ?????? ????????? ???????????? ?????????????????? ???????????? ?????? ???????????????.'''));
        }
      }

      return notices;
    });
  }

  int randomNum(int min, int max) => min + Random().nextInt(max - min);
}
