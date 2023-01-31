import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/ui/account/signup/form/signup_form.dart';
import 'package:dingmo/ui/account/widgets/step_description.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/checkbox.dart';
import 'package:dingmo/ui/widgets/divider.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgreementsPage extends StatefulWidget {
  const AgreementsPage({Key? key}) : super(key: key);

  @override
  State<AgreementsPage> createState() => _AgreementsPageState();
}

class _AgreementsPageState extends State<AgreementsPage> {
  final form = SignUpForm.instance();

  bool isAggreed1 = false;
  bool isAggreed2 = false;
  bool isAggreed3 = false;
  bool isAggreed4 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context),
      body: SafeArea(
          child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimens.horizontalPadding),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const SizedBox(height: 50),
          const StepDescriptionWidget(
              title: "약관동의", description: "약관을 꼼꼼히 읽으신 후 동의해주세요."),
          const Spacer(),
          Chexkbox(
              isChecked: isAgreedAll(),
              name: "약관에 모두 동의",
              onChanged: (value) => setState(() => setAllAgreed(value))),
          const SizedBox(height: 20),
          const HorizontalDivider(),
          const SizedBox(height: 20),
          CheckItemWidget(
              isChecked: isAggreed1,
              name: "(필수) 서비스 이용약관에 동의",
              onChanged: (value) => setState(() => isAggreed1 = value),
              onTapDetailed: () => safePrint("(필수) 서비스 이용약관에 동의")),
          CheckItemWidget(
              isChecked: isAggreed2,
              name: "(필수) 개인정보 수집 및 이용에 대한 동의",
              onChanged: (value) => setState(() => isAggreed2 = value),
              onTapDetailed: () => safePrint("(필수) 개인정보 수집 및 이용에 대한 동의")),
          CheckItemWidget(
              isChecked: isAggreed3,
              name: "(필수) 개인정보 처리방침",
              onChanged: (value) => setState(() => isAggreed3 = value),
              onTapDetailed: () => safePrint("(필수) 개인정보 처리방침")),
          CheckItemWidget(
              isChecked: isAggreed4,
              name: "(선택) 혜택/정보 수신 동의",
              onChanged: (value) => setState(() => isAggreed4 = value),
              onTapDetailed: () => safePrint("(선택) 혜택/정보 수신 동의")),
          const SizedBox(height: 60),
          ElevatedButton(
              onPressed: isAllAgreedEssential()
                  ? () {
                      form.isAgreedEventNoti = isAggreed4;

                      form.socialSignUpType != null
                          ? Navigator.pushNamed(
                              context, Routes.signupTypeSelect1)
                          : Navigator.pushNamed(context, Routes.idPwForSignUp);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                primary: AppColors.mediumPink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  "내용을 확인했습니다.",
                  style: TextStyle(fontSize: 14),
                ),
              )),
          const SizedBox(height: 55)
        ]),
      )),
    );
  }

  void setAllAgreed(bool value) {
    isAggreed1 = value;
    isAggreed2 = value;
    isAggreed3 = value;
    isAggreed4 = value;
  }

  bool isAgreedAll() {
    return isAggreed1 && isAggreed2 && isAggreed3 && isAggreed4;
  }

  bool isAllAgreedEssential() {
    return isAggreed1 && isAggreed2 && isAggreed3;
  }
}

class CheckItemWidget extends StatefulWidget {
  final bool isChecked;
  final String name;
  final SetBoolFunc onChanged;
  final VoidFunc onTapDetailed;

  const CheckItemWidget(
      {Key? key,
      required this.isChecked,
      required this.name,
      required this.onChanged,
      required this.onTapDetailed})
      : super(key: key);

  @override
  State<CheckItemWidget> createState() => _CheckItemWidgetState();
}

class _CheckItemWidgetState extends State<CheckItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTapDetailed,
      child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              Chexkbox(
                  isChecked: widget.isChecked,
                  name: widget.name,
                  onChanged: widget.onChanged),
              const Spacer(),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(16),
                child: SvgPicture.asset(
                  "assets/sign/right_icon.svg",
                  width: 6,
                ),
              )
            ],
          )),
    );
  }
}
