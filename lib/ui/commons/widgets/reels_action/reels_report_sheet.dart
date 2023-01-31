import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReelsReportSheet extends StatelessWidget {
  const ReelsReportSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Texts.defaultText(
                  text: "신고하기", fontSize: 16, fontWeight: FontWeight.bold),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close),
                iconSize: 20,
              )
            ],
          ),
        ),
        ...([
          "주제에 맞지 않는 글",
          "과도한 욕설",
          "음란물",
          "폭력적인 내용",
          "불법광고",
          "기타",
        ].map((areaName) => TextButton(
            onPressed: () {
              Navigator.pop(context);
              Fluttertoast.showToast(
                  msg: "신고가 접수되었습니다", backgroundColor: AppColors.mediumPink);
            },
            child: Container(
              width: double.infinity,
              color: Colors.transparent,
              padding: const EdgeInsets.all(20),
              child: Text(
                areaName,
                style: TextStyle(fontSize: 14, color: AppColors.greyishBrown),
              ),
            )))),
      ],
    );
  }
}
