import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/widgets/buttons.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'form/signup_form.dart';

class SignUpOkPage extends StatefulWidget {
  const SignUpOkPage({Key? key}) : super(key: key);

  @override
  State<SignUpOkPage> createState() => _SignUpOkPageState();
}

class _SignUpOkPageState extends State<SignUpOkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Texts.defaultText(
              text: "가입완료!", fontSize: 24, fontWeight: FontWeight.w700),
          const SizedBox(height: 65),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 75),
            child: SvgPicture.asset("assets/sign/congra_present_icon.svg"),
          ),
          const SizedBox(height: 30),
          Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(
                    text: "에브리웨딩홀  ",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.mediumPink,
                        fontWeight: FontWeight.w500,
                        height: 1.2)),
                TextSpan(
                    text: "님의\n",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.greyishBrown,
                        fontWeight: FontWeight.w500,
                        height: 1.2)),
                TextSpan(
                    text: "회원가입을 축하드립니다!\n\n",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.greyishBrown,
                        fontWeight: FontWeight.w500,
                        height: 1.2)),
                TextSpan(
                    text: "지금 바로 남은 프로필을\n",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.greyishBrown,
                        fontWeight: FontWeight.w500,
                        height: 1.2)),
                TextSpan(
                    text: "완성해 보시는 건 어떠세요?",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.greyishBrown,
                        fontWeight: FontWeight.w500,
                        height: 1.2))
              ])),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Buttons.defaultButton(
                  text: "프로필 작성하러 가기", onPressed: () => goNextStep()),
              const SizedBox(height: 24),
              Buttons.textButton(
                  text: "다음에 할게요",
                  onTap: () {
                    SignUpForm.instance().clear();
                    Navigator.pop(context);
                  })
            ],
          ),
          const SizedBox(height: 55),
        ],
      ),
    )));
  }

  void goNextStep() {
    getIt<MemberInfo>().memberType == MemberType.comp
        ? Navigator.pushNamed(context, Routes.compEditProfile).then((isOk) =>
            isOk == true ? Navigator.pushNamed(context, Routes.start) : {})
        : Navigator.pushNamed(context, Routes.planEditProfile).then((isOk) =>
            isOk == true ? Navigator.pushNamed(context, Routes.start) : {});
  }
}
