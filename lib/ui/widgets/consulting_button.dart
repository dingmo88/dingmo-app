import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConsultingButton extends StatelessWidget {
  const ConsultingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Fluttertoast.showToast(msg: "coming soon!");
        },
        style: ElevatedButton.styleFrom(
          primary: AppColors.mediumPink,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "채팅으로 문의하기",
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            const SizedBox(width: 5),
            SvgPicture.asset("assets/profile/message_icon.svg")
          ]),
        ));
  }
}
