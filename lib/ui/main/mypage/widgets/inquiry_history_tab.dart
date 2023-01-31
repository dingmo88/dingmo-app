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
                "문의 내역이 없어요",
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
              title: "비밀번호 변경이 안됩니다.",
              content: '''비밀번호를 다 입력하고 변경 버튼을 눌렀는데 화면이 멈추고 동작하지 않습니다.''',
              dateCreated: "2022.04.23",
              imgUrls: [
                "https://picsum.photos/id/${337 + idx}/105/105",
                "https://picsum.photos/id/${337 + idx + 1}/105/105"
              ],
            ),
          );
        } else {
          notices.add(InquiryHistoryItem(
              title: "딩모 게시물 올리기에서 연결이 끊기는 문제가 발생하였습니다.",
              content:
                  '''딩모 게시물 올리기에서 연결이 끊기는 문제가 발생하여 문의 남깁니다. 사진 업로드까지는 되는데 업로드를 누르면 알 수 없는 문제가 발생한다고 창이 뜹니다.''',
              dateCreated: "2022.04.23",
              imgUrls: ["https://picsum.photos/id/${337 + idx}/105/105"],
              answer: '''안녕하세요. 김단 고객님 오류 발생에 대한 문의 답변 드립니다.

2022.04.22 업데이트로 인한 충돌이 발생하여 이용하시는데 어려움을 드려 죄송합니다.'''));
        }
      }

      return notices;
    });
  }

  int randomNum(int min, int max) => min + Random().nextInt(max - min);
}
