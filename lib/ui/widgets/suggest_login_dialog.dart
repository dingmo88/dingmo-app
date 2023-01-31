import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/account/signup/form/signup_form.dart';
import 'package:flutter/material.dart';

import 'texts.dart';

void showSuggestLoginDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) => const SuggestLoginDialog());
}

class SuggestLoginDialog extends StatelessWidget {
  final void Function()? onYes;
  final void Function()? onNo;
  final void Function()? onFinished;
  const SuggestLoginDialog({Key? key, this.onYes, this.onNo, this.onFinished})
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
                  text: "회원 전용", fontSize: 16, fontWeight: FontWeight.bold),
              const SizedBox(height: 15),
              Texts.defaultText(
                  text: "회원 전용 서비스입니다. 로그인 하시겠습니까?",
                  fontSize: 13,
                  fontWeight: FontWeight.normal),
              const SizedBox(height: 30),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        if (onYes != null) {
                          onYes!();
                        }
                        Navigator.pop(context);

                        setCurrentRouteName(context);
                        Navigator.pushNamed(context, Routes.loginMain)
                            .then((_) {
                          if (onFinished != null) {
                            onFinished!();
                          }
                        });
                      },
                      child: Texts.defaultText(
                          text: "네",
                          fontSize: 13,
                          color: AppColors.mediumPink)),
                  const SizedBox(width: 25),
                  GestureDetector(
                      onTap: () {
                        if (onNo != null) {
                          onNo!();
                        }
                        Navigator.pop(context);

                        if (onFinished != null) {
                          onFinished!();
                        }
                      },
                      child: Texts.defaultText(
                          text: "아니요",
                          fontSize: 13,
                          color: AppColors.mediumPink))
                ],
              )
            ],
          )),
    );
  }

  void setCurrentRouteName(BuildContext context) {
    SignUpForm.instance().startRouteName =
        ModalRoute.of(context)?.settings.name;
  }
}
