import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/account/widgets/signup_progress.dart';
import 'package:dingmo/constants/signup_type_enum.dart';
import 'package:dingmo/ui/account/widgets/step_description.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:flutter/material.dart';

import '../widgets/signup_type_card.dart';
import 'form/signup_form.dart';

class SignUpTypeSelect2Page extends StatefulWidget {
  const SignUpTypeSelect2Page({Key? key}) : super(key: key);

  @override
  State<SignUpTypeSelect2Page> createState() => _SignUpTypeSelect2PageState();
}

class _SignUpTypeSelect2PageState extends State<SignUpTypeSelect2Page> {
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
              const SignUpProgressWidget(progress: 40),
              const SizedBox(height: 30),
              const StepDescriptionWidget(
                  title: "가입 유형 선택2", description: "웨딩업체와 플래너 중 선택해주세요."),
              const SizedBox(height: 105),
              Column(
                children: [
                  SignUpTypeCard(
                    name: "웨딩업체",
                    description: "웨딩홀, 스튜디오, 드레스, 메이크업, 혼수 등",
                    isSelected: form.signUpTypeSecond == SignUpType.company,
                    onSelected: (isSelected) => setState(() => isSelected
                        ? form.signUpTypeSecond = SignUpType.company
                        : form.signUpTypeSecond = null),
                  ),
                  const SizedBox(height: 20),
                  SignUpTypeCard(
                    name: "웨딩플래너",
                    description: "소속 또는 프리랜서 웨딩플래너",
                    isSelected: form.signUpTypeSecond == SignUpType.planner,
                    onSelected: (isSelected) => setState(() => isSelected
                        ? form.signUpTypeSecond = SignUpType.planner
                        : form.signUpTypeSecond = null),
                  ),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: form.signUpTypeSecond != null
                      ? () {
                          FocusScope.of(context).unfocus();
                          if (form.signUpTypeSecond == SignUpType.company) {
                            Navigator.pushNamed(
                                context, Routes.signupCompTypeSelect);
                          } else if (form.signUpTypeSecond ==
                              SignUpType.planner) {
                            Navigator.pushNamed(
                                context, Routes.plannerTakeninCheck);
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

  double getSelectionCardWidth() {
    return (MediaQuery.of(context).size.width - (20 + 20 + 20)) / 2;
  }
}
