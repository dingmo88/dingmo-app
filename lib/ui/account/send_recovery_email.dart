import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/constants/social_type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_recovery_pass.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/form.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SendRecoveryMailPage extends StatefulWidget {
  const SendRecoveryMailPage({Key? key}) : super(key: key);

  @override
  State<SendRecoveryMailPage> createState() => _SendRecoveryMailPageState();
}

class _SendRecoveryMailPageState extends State<SendRecoveryMailPage> {
  String _email = "";
  bool? _sendCompleted;

  bool isLoading = false;

  final FocusNode emailFocus = FocusNode();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => !isLoading,
        child: IgnorePointer(
          ignoring: isLoading,
          child: Stack(children: [
            Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBars.defaultAppBar(context,
                  title: "비밀번호 찾기", closeEnabled: !isLoading),
              body: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.horizontalPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 120),
                      TextForm(
                          focusNode: emailFocus,
                          name: "가입한 이메일 주소를 입력해주세요.",
                          controller: emailController,
                          onChanged: (text) => setState(() => _email = text)),
                      const SizedBox(height: 10),
                      Visibility(
                        visible: _sendCompleted == null,
                        child: Text(
                          "새로운 비밀번호 설정이 가능한 링크를 이메일로 보내드립니다.",
                          style: TextStyle(
                              color: AppColors.purpleGrey,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Visibility(
                          visible: _sendCompleted == false,
                          child: Text(
                            "존재하지 않는 계정입니다.",
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.strawberry,
                                fontWeight: FontWeight.w500),
                          )),
                      const Spacer(),
                      Visibility(
                          visible:
                              MediaQuery.of(context).viewInsets.bottom == 0,
                          child: Container(
                            color: AppColors.greyWhite,
                            padding: const EdgeInsets.all(20),
                            child: Column(children: [
                              Texts.defaultText(
                                  text: "이메일이 기억나지 않으실 경우\n"
                                      "1:1 문의하기로 별도 문의해 주시기 바랍니다.",
                                  fontSize: 12,
                                  height: 2)
                            ]),
                          )),
                      const SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: _email.isNotEmpty
                              ? () async {
                                  setStateLoding(true);

                                  final existsResult =
                                      await getIt<AuthManager>()
                                          .existsEmail(_email);
                                  if (existsResult == null) {
                                    setStateLoding(false);
                                    Fluttertoast.showToast(msg: "문제가 발생하였습니다");
                                    return;
                                  }
                                  if (valueToSocialType(
                                          existsResult.socialType) !=
                                      SocialType.email) {
                                    setStateLoding(false);
                                    Fluttertoast.showToast(
                                        msg: "소셜 가입 이메일은 인증메일을 발송할 수 없습니다");
                                    return;
                                  }

                                  final sendResult = await getIt<AuthManager>()
                                      .sendRecoveryEmail(_email);
                                  setStateLoding(false);

                                  handleSendRecovResult(sendResult);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.mediumPink,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: const Text(
                              "이메일로 인증코드 받기",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          )),
                      const SizedBox(height: 55),
                    ]),
              ),
            ),
            Visibility(
                visible: isLoading,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white.withOpacity(0.7),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.mediumPink,
                    ),
                  ),
                ))
          ]),
        ));
  }

  void handleSendRecovResult(SendRecovEmailResult result) {
    if (result == SendRecovEmailResult.success) {
      goNextStepWithOkToast();
    } else if (result == SendRecovEmailResult.failed) {
      setStateCompleted(false);
    } else if (result == SendRecovEmailResult.limited) {
      Fluttertoast.showToast(msg: "계정 접근 시도를 5회 초과하였습니다. 최대 1시간 후 다시 시도해주세요.");
    } else if (result == SendRecovEmailResult.error) {
      Fluttertoast.showToast(msg: "복구메일 발송 실패");
    } else {
      Fluttertoast.showToast(msg: "잘못된 접근입니다");
    }
  }

  void setStateCompleted(bool completed) {
    setState(() {
      _sendCompleted = completed;
    });
  }

  void setStateLoding(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void goNextStepWithOkToast() {
    Navigator.pushReplacementNamed(context, Routes.recoveryPass,
        arguments: RecoveryPassArgs(email: _email));
    Fluttertoast.showToast(msg: "인증번호를 발송하였습니다. 새 비밀번호와 함께 입력해주세요.");
  }
}
