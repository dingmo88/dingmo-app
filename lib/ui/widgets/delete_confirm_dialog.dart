import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final void Function() onYes;
  const DeleteConfirmDialog({Key? key, required this.onYes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
      child: Container(
          padding: const EdgeInsets.only(left: 20, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Texts.defaultText(
                  text: "삭제", fontSize: 16, fontWeight: FontWeight.bold),
              const SizedBox(height: 15),
              Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: Texts.defaultText(
                      text: "삭제하시겠습니까?",
                      fontSize: 13,
                      fontWeight: FontWeight.normal)),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(20),
                        child: Texts.defaultText(
                            text: "아니오",
                            fontSize: 13,
                            color: AppColors.mediumPink),
                      )),
                  GestureDetector(
                      onTap: () {
                        onYes();
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(20),
                        child: Texts.defaultText(
                            text: "네",
                            fontSize: 13,
                            color: AppColors.mediumPink),
                      )),
                ],
              )
            ],
          )),
    );
  }
}
