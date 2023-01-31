import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/account/widgets/signup_progress.dart';
import 'package:dingmo/ui/account/widgets/step_description.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/form.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'signup/form/signup_form.dart';

class VerificationPage extends StatefulWidget {
  const VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final SignUpForm _form = SignUpForm.instance();

  final FocusNode verifyCodeFocus = FocusNode();
  final TextEditingController verifyCodeController = TextEditingController();
  bool _isInProgress = false;

  String _verificationCode = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isInProgress;
      },
      child: IgnorePointer(
        ignoring: _isInProgress,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBars.defaultAppBar(context, closeEnabled: !_isInProgress),
          body: Stack(children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    const SignUpProgressWidget(progress: 90),
                    const SizedBox(height: 30),
                    StepDescriptionWidget(
                      title: "이메일 인증번호를 발송하였습니다.",
                      description: "인증번호를 입력해주세요 (${_form.email})",
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.17),
                    NumForm(
                        focusNode: verifyCodeFocus,
                        name: "인증번호",
                        controller: verifyCodeController,
                        onChanged: (text) => setState(
                              () => _verificationCode = text,
                            ),
                        hint: "123456"),
                    const Spacer(),
                    ElevatedButton(
                        onPressed: () async {
                          FocusScope.of(context).unfocus();

                          setStateInProgress(true);

                          await signUpWithLogin();

                          setStateInProgress(false);
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
                            "가입",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          )),
                        )),
                    const SizedBox(height: 55),
                  ],
                )),
            Visibility(
                visible: _isInProgress,
                child: Center(
                    child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.mediumPink,
                )))
          ]),
        ),
      ),
    );
  }

  Future<void> signUpWithLogin() async {
    final authResult =
        await getIt<AuthManager>().signUpWithLogin(_form, _verificationCode);

    if (authResult == AuthSignUpResult.failedVerify) {
      Fluttertoast.showToast(msg: "인증에 실패하였습니다");
    } else if (authResult == AuthSignUpResult.invaildVerifyCode) {
      Fluttertoast.showToast(msg: "인증번호가 올바르지 않습니다");
    } else {
      popUntilSignStartRoute();
      _form.clear();

      if (authResult == AuthSignUpResult.error) {
        Fluttertoast.showToast(msg: "가입에 실패하였습니다");
        goRoute(Routes.loginMain);
      } else {
        goRoute(Routes.signUpOk);
      }
    }
  }

  void popUntilSignStartRoute() {
    safePrint("debug! _form.startRouteName: ${_form.startRouteName}");
    Navigator.of(context)
        .popUntil(ModalRoute.withName(_form.startRouteName ?? Routes.start));
  }

  void goRoute(String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  void setStateInProgress(bool isInProgress) {
    setState(() {
      _isInProgress = isInProgress;
    });
  }

  double getSelectionCardWidth() {
    return (MediaQuery.of(context).size.width - (20 + 20 + 20)) / 2;
  }
}
