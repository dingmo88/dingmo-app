import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../commons/widgets/reels_action/reels_report_sheet.dart';

class ReportOrBanSheet extends StatelessWidget {
  const ReportOrBanSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
        padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Texts.defaultText(
                    text: "신고/차단", fontSize: 16, fontWeight: FontWeight.bold),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                  iconSize: 20,
                )
              ],
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  showReportSheet(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Texts.defaultText(
                      text: "신고하기",
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                )),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: "차단 완료", backgroundColor: AppColors.mediumPink);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Texts.defaultText(
                      text: "계정 차단하기",
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ))
          ],
        ),
      ),
    );
  }

  void showReportSheet(BuildContext context) {
    showModalBottomSheet<void>(
        backgroundColor: Colors.white,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        isScrollControlled: true,
        builder: (BuildContext context) => const ReelsReportSheet());
  }
}
