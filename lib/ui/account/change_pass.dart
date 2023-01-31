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

class ChangePassPage extends StatefulWidget {
  const ChangePassPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePassPage> createState() => _ChangePassPageState();
}

class _ChangePassPageState extends State<ChangePassPage> {
  String _oldPassword = "";
  String _newPassword = "";
  bool _isVisiblePass = false;
  int _newPassLevel = 0;

  bool isLoading = false;

  final FocusNode newPassFocus = FocusNode();
  final FocusNode oldPassFocus = FocusNode();

  final TextEditingController newPassController = TextEditingController();
  final TextEditingController oldPassController = TextEditingController();

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
                  title: "비밀번호 변경", closeEnabled: !isLoading),
              body: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.horizontalPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 120),
                      PassForm(
                        focusNode: oldPassFocus,
                        obsecureText: true,
                        name: "현재 비밀번호",
                        controller: oldPassController,
                        onChanged: (text) =>
                            setState(() => _oldPassword = text),
                      ),
                      const SizedBox(height: 25),
                      PassForm(
                          focusNode: newPassFocus,
                          obsecureText: !_isVisiblePass,
                          name: "새 비밀번호",
                          controller: newPassController,
                          onChanged: (text) => setState(() {
                                _newPassword = text;
                                _newPassLevel = Validator.getPassSecurityLevel(
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
                          child: PWSecurityLevelWidget(
                              securityLevel: _newPassLevel)),
                      const SizedBox(height: 10),
                      const Spacer(),
                      ElevatedButton(
                          onPressed: _newPassword.isNotEmpty &&
                                  _newPassLevel >= 4 &&
                                  _oldPassword.isNotEmpty
                              ? () async {
                                  setStateLoding(true);
                                  final result = await getIt<AuthManager>()
                                      .changePassword(
                                          _oldPassword, _newPassword);
                                  setStateLoding(false);

                                  if (result == AmpResState.yes) {
                                    popWithOkToast();
                                  } else if (result == AmpResState.no) {
                                    Fluttertoast.showToast(
                                        msg: "현재 비밀번호가 올바르지 않습니다");
                                  } else if (result == AmpResState.limited) {
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
