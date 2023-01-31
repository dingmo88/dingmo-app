import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class CheckReplyCancelDialog extends StatelessWidget {
  final void Function() onCancel;
  const CheckReplyCancelDialog({Key? key, required this.onCancel})
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
                  text: "답글 삭제", fontSize: 16, fontWeight: FontWeight.bold),
              const SizedBox(height: 15),
              Texts.defaultText(
                  text: "작성 중인 답글을 삭제하시겠습니까?",
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
                          text: "계속 작성",
                          fontSize: 13,
                          color: AppColors.mediumPink)),
                  const SizedBox(width: 25),
                  GestureDetector(
                      onTap: () {
                        onCancel();
                        Navigator.pop(context);
                      },
                      child: Texts.defaultText(
                          text: "삭제",
                          fontSize: 13,
                          color: AppColors.mediumPink))
                ],
              )
            ],
          )),
    );
  }
}
