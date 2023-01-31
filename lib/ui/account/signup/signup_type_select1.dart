import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/account/widgets/signup_progress.dart';
import 'package:dingmo/ui/account/widgets/step_description.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:flutter/material.dart';

import '../widgets/signup_type_card.dart';
import '../../../constants/signup_type_enum.dart';
import 'form/signup_form.dart';

class SignUpTypeSelect1Page extends StatefulWidget {
  const SignUpTypeSelect1Page({Key? key}) : super(key: key);

  @override
  State<SignUpTypeSelect1Page> createState() => _SignUpTypeSelect1PageState();
}

class _SignUpTypeSelect1PageState extends State<SignUpTypeSelect1Page> {
  final SignUpForm form = SignUpForm.instance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const SignUpProgressWidget(progress: 20),
              const SizedBox(height: 30),
              const StepDescriptionWidget(
                  title: "가입 유형 선택1", description: "가입할 정보를 선택해주세요."),
              const SizedBox(height: 105),
              Column(
                children: [
                  // SignUpTypeCard(
                  //   name: "예비신랑신부",
                  //   description: "결혼을 생각중이신 예비 시랑 신부님",
                  //   isSelected: form.signUpType1 == SignUpType.user,
                  //   onSelected: (isSelected) => setState(() => isSelected
                  //       ? form.signUpType1 = SignUpType.user
                  //       : form.signUpType1 = null),
                  // ),
                  const SizedBox(height: 20),
                  SignUpTypeCard(
                    name: "웨딩업체/플래너",
                    description: "딩모와 함께하는 웨딩 업체 및 웨딩플래너",
                    isSelected: form.signUpTypeFirst == SignUpType.compOrPlan,
                    onSelected: (isSelected) => setState(() => isSelected
                        ? form.signUpTypeFirst = SignUpType.compOrPlan
                        : form.signUpTypeFirst = null),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: form.signUpTypeFirst != null
                      ? () {
                          FocusScope.of(context).unfocus();
                          if (form.signUpTypeFirst == SignUpType.compOrPlan) {
                            Navigator.pushNamed(
                                context, Routes.signupTypeSelect2);
                          }
                          if (form.signUpTypeFirst == SignUpType.user) {
                            Navigator.pushNamed(
                                context, Routes.signupUserNickname);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.mediumPink,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: const Center(
                        child: Text(
                      "다음",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    )),
                  )),
              const SizedBox(height: 55),
            ],
          )),
    );
  }
}
