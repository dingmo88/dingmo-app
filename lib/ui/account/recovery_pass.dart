import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/third_party/aws_amplify.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/form.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:dingmo/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/pass_security_level.dart';

class RecoveryPassPage extends StatefulWidget {
  final String email;
  const RecoveryPassPage({Key? key, required this.email}) : super(key: key);

  @override
  State<RecoveryPassPage> createState() => _RecoveryPassPageState();
}

class _RecoveryPassPageState extends State<RecoveryPassPage> {
  String _newPassword = "";
  String _verificationCode = "";
  bool _isVisiblePass = false;
  int _passLevel = 0;

  bool isLoading = false;

  bool? _isVerificationFailed;

  final FocusNode newPassFocus = FocusNode();
  final FocusNode verificationCodeFocus = FocusNode();

  final TextEditingController newPassController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();

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
                      PassForm(
                          focusNode: newPassFocus,
                          obsecureText: !_isVisiblePass,
                          name: "새 비밀번호",
                          controller: newPassController,
                          onChanged: (text) => setState(() {
                                _newPassword = text;
                                _passLevel = Validator.getPassSecurityLevel(
                                    _newPassword);
                              }),
                          suffixIcon: GestureDetector(
                            onTap: () => setState(
                                () => _isVisiblePass = !_isVisiblePass),
                            child: Container(
                                margin: const EdgeInsets.only(right: 20),
                                child: _isVisiblePass
                                    ? getEyeOnIcon()
                                    : getEyeOffIcon()),
                          ),
                          hint: "영문,숫자,특수문자 포함 8자 이상"),
                      const SizedBox(height: 10),
                      Visibility(
                          visible: newPassController.text.isNotEmpty,
                          child:
                              PWSecurityLevelWidget(securityLevel: _passLevel)),
                      const SizedBox(height: 25),
                      TextForm(
                        focusNode: verificationCodeFocus,
                        name: "인증번호",
                        controller: verificationCodeController,
                        onChanged: (text) =>
                            setState(() => _verificationCode = text),
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                          visible: _isVerificationFailed == false,
                          child: Text(
                            "인증번호가 올바르지 않습니다.",
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.strawberry,
                                fontWeight: FontWeight.w500),
                          )),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: _newPassword.isNotEmpty &&
                                  _passLevel >= 4 &&
                                  _verificationCode.isNotEmpty
                              ? () async {
                                  setStateLoding(true);
                                  final result = await getIt<AuthManager>()
                                      .confirmResetPassword(
                                          AuthCredentials(
                                              email: widget.email,
                                              password: _newPassword),
                                          _verificationCode);
                                  setStateLoding(false);

                                  if (result ==
                                      ConfirmResetPassResult.success) {
                                    popWithOkToast();
                                  } else if (result ==
                                      ConfirmResetPassResult.failed) {
                                    setStateCompleted(false);
                                  } else if (result ==
                                      ConfirmResetPassResult.limited) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "계정 접근 시도를 5회 초과하였습니다. 최대 1시간 후 다시 시도해주세요.");
                                  } else {
                                    Fluttertoast.showToast(msg: "비밀번호 변경 실패");
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
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: const Text(
                              "비밀번호 변경",
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

  void setStateCompleted(bool completed) {
    setState(() {
      _isVerificationFailed = completed;
    });
  }

  void setStateLoding(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }

  void popWithOkToast() {
    Navigator.pop(context);
    Fluttertoast.showToast(msg: "비밀번호 변경 완료");
  }

  Widget getEyeOffIcon() {
    return SvgPicture.asset("assets/sign/eye_off.svg");
  }

  Widget getEyeOnIcon() {
    return SvgPicture.asset("assets/sign/eye_on.svg");
  }
}
