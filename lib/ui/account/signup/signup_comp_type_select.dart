import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/ui/account/widgets/signup_progress.dart';
import 'package:dingmo/ui/account/widgets/step_description.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:flutter/material.dart';

import '../widgets/signup_type_card.dart';
import 'form/signup_form.dart';

class SignUpCompTypeSelectPage extends StatefulWidget {
  const SignUpCompTypeSelectPage({Key? key}) : super(key: key);

  @override
  State<SignUpCompTypeSelectPage> createState() =>
      _SignUpCompTypeSelectPageState();
}

class _SignUpCompTypeSelectPageState extends State<SignUpCompTypeSelectPage> {
  final SignUpForm form = SignUpForm.instance();

  final Map<String, IdxTag> compTypes = {
    "웨딩홀": IdxTag.weddHole,
    "스튜디오": IdxTag.studio,
    "드레스": IdxTag.dress,
    "메이크업": IdxTag.makeup,
    "혼수": IdxTag.coma,
    "기타": IdxTag.etc,
  };

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
                  title: "웨딩업체 선택", description: "웨딩업체 종류를 선택해주세요."),
              const SizedBox(height: 40),
              Expanded(
                  child: ListView(
                shrinkWrap: true,
                children: compTypes
                    .map((name, type) => MapEntry(
                        name,
                        Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: SignUpTypeCard(
                            name: name,
                            isSelected: form.compSignUpType == type,
                            onSelected: (isSelected) => setState(() =>
                                isSelected
                                    ? form.compSignUpType = type
                                    : form.compSignUpType = null),
                          ),
                        )))
                    .values
                    .toList(),
              )),
              ElevatedButton(
                  onPressed: form.compSignUpType != null
                      ? () {
                          FocusScope.of(context).unfocus();

                          Navigator.pushNamed(context, Routes.compNumCheck);
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
