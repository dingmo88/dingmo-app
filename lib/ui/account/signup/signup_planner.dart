import 'package:dingmo/api/api_third_party.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_certifications.dart';
import 'package:dingmo/third_party/aws_amplify.dart';
import 'package:dingmo/ui/account/widgets/signup_progress.dart';
import 'package:dingmo/ui/account/widgets/step_description.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/buttons.dart';
import 'package:dingmo/ui/widgets/form.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'form/signup_form.dart';

class PlannerTakeninCheckPage extends StatefulWidget {
  const PlannerTakeninCheckPage({Key? key}) : super(key: key);

  @override
  State<PlannerTakeninCheckPage> createState() =>
      _PlannerTakeninCheckPageState();
}

class SelfAuthPage extends StatefulWidget {
  const SelfAuthPage({Key? key}) : super(key: key);

  @override
  State<SelfAuthPage> createState() => _SelfAuthPageState();
}

class _PlannerTakeninCheckPageState extends State<PlannerTakeninCheckPage> {
  final SignUpForm _form = SignUpForm.instance();

  final FocusNode takeinCompNameFocus = FocusNode();
  final TextEditingController takeinCompNameController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    takeinCompNameController.text = _form.planInfoForm.takeinCompName ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBars.defaultAppBar(context),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const SignUpProgressWidget(progress: 60),
              const SizedBox(height: 30),
              const StepDescriptionWidget(
                title: "소속명 입력",
                description: "소속 되어있는 컨설팅 명을 입력해주세요.",
              ),
              const SizedBox(height: 110),
              TextForm(
                  focusNode: takeinCompNameFocus,
                  name: "컨설팅 소속명",
                  controller: takeinCompNameController,
                  onChanged: (text) => setState(
                        () => _form.planInfoForm.takeinCompName = text,
                      ),
                  hint: "딩모웨딩"),
              const Spacer(),
              ElevatedButton(
                  onPressed:
                      _form.planInfoForm.takeinCompName?.isNotEmpty == true
                          ? () {
                              FocusScope.of(context).unfocus();
                              goNextStep();
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
              const SizedBox(height: 20),
              Center(
                child: Buttons.textButton(
                    width: 80,
                    text: "다음에 할게요",
                    onTap: () {
                      takeinCompNameController.clear();
                      _form.planInfoForm.takeinCompName = null;
                      FocusScope.of(context).unfocus();
                      goNextStep();
                    }),
              ),
              const SizedBox(height: 55),
            ],
          )),
    );
  }

  double getSelectionCardWidth() {
    return (MediaQuery.of(context).size.width - (20 + 20 + 20)) / 2;
  }

  void goNextStep() {
    Navigator.pushNamed(context, Routes.selfAuth);
  }
}

class _SelfAuthPageState extends State<SelfAuthPage> {
  final _form = SignUpForm.instance();

  bool _isInCert = false;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: _isInCert,
      child: Scaffold(
        appBar: AppBars.defaultAppBar(context),
        body: Stack(children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const SignUpProgressWidget(progress: 80),
                  const SizedBox(height: 30),
                  const StepDescriptionWidget(
                    title: "본인인증",
                    description: "본인 확인을 위한 휴대폰 인증이 필요합니다.",
                  ),
                  const SizedBox(height: 120),
                  Center(
                      child:
                          SvgPicture.asset("assets/sign/big_unlock_icon.svg")),
                  const Spacer(),
                  ElevatedButton(
                      onPressed: () async {
                        setStateInCert(true);

                        Navigator.pushNamed(context, Routes.certifications,
                            arguments:
                                CertificationsArgs(onComplete: ((result) async {
                          if (result == null) {
                            setStateInCert(false);

                            Fluttertoast.showToast(msg: "본인인증에 실패했습니다");
                          } else {
                            _setDataToForm(result);

                            final sendResult = await getIt<AuthManager>()
                                .sendVerificationEmail(AuthCredentials(
                                    email: _form.email!,
                                    password: _form.password!));

                            if (sendResult == AmpResState.error) {
                              Fluttertoast.showToast(msg: "인증메일 전송 실패");
                            } else if (sendResult == AmpResState.limited) {
                              Fluttertoast.showToast(
                                  msg:
                                      "계정 접근 시도를 5회 초과하였습니다. 최대 1시간 후 다시 시도해주세요.");
                            } else {
                              goVerificationPage();
                            }

                            setStateInCert(false);
                          }
                        }))).then((isOk) => isOk != true
                            ? setStateInCert(false)
                            : {
                                /* 인증이 완수되면 자동으로 다음 화면으로 넘어가야 하기 때문에, 그 어떤 버튼도 눌리면 안돼서 로딩을 풀지 않는다. */
                              });
                      },
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
                          "휴대폰 인증하기",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )),
                      )),
                  const SizedBox(height: 55),
                ],
              )),
          Visibility(
              visible: _isInCert,
              child: Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.mediumPink,
              )))
        ]),
      ),
    );
  }

  void setStateInCert(bool isInProgress) {
    setState(() {
      _isInCert = isInProgress;
    });
  }

  void _setDataToForm(PostCertPersonResult result) {
    _form.planInfoForm.phone = result.phone;
    _form.planInfoForm.name = result.name;
    _form.planInfoForm.birthDay = result.birthDay;
  }

  void goVerificationPage() {
    Navigator.pushNamed(context, Routes.verification);
  }
}
