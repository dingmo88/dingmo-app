import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class CheckExitRoomDialog extends StatelessWidget {
  final String nickname;
  final void Function() onExit;
  const CheckExitRoomDialog(
      {Key? key, required this.nickname, required this.onExit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
      child: Container(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Texts.defaultText(
                  text: "[$nickname] 나가기",
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              const SizedBox(height: 15),
              Texts.defaultText(
                  text: "채팅방을 나가시겠습니까? 채팅 기록은 영구 삭제 처리되며 복구하 수 없습니다.",
                  fontSize: 13,
                  fontWeight: FontWeight.normal),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Texts.defaultText(
                          text: "취소",
                          fontSize: 13,
                          color: AppColors.mediumPink)),
                  const SizedBox(width: 25),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        onExit();
                      },
                      child: Texts.defaultText(
                          text: "나가기",
                          fontSize: 13,
                          color: AppColors.mediumPink))
                ],
              )
            ],
          )),
    );
  }
}
