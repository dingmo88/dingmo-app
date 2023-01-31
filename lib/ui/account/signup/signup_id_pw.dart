import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/account/signup/form/signup_form.dart';
import 'package:dingmo/ui/account/widgets/form_message.dart';
import 'package:dingmo/ui/account/widgets/pass_security_level.dart';
import 'package:dingmo/ui/account/widgets/step_description.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/form.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:dingmo/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class IdPwForSignUpPage extends StatefulWidget {
  const IdPwForSignUpPage({Key? key}) : super(key: key);

  @override
  State<IdPwForSignUpPage> createState() => _IdPwForSignUpPageState();
}

class _IdPwForSignUpPageState extends State<IdPwForSignUpPage> {
  String _email = "";
  String _pass = "";
  bool _isVisiblePass = false;
  int _passLevel = 0;

  bool _isLoadingDupEmailCheck = false;
  bool _visibleEmailDupError = false;
  bool _visibleEmailUsable = false;

  final FocusNode emailFormFocus = FocusNode();
  final FocusNode passFormFocus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  SignUpForm form = SignUpForm.instance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars.defaultAppBar(context),
        body: SingleChildScrollView(
          reverse: true,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.horizontalPadding),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 45),
                      const StepDescriptionWidget(
                          title: "이메일 및 비밀번호",
                          description: "계정으로 사용할 이메일을 입력해주세요."),
                      const SizedBox(height: 120),
                      Stack(children: [
                        IgnorePointer(
                          ignoring: _isLoadingDupEmailCheck,
                          child: TextForm(
                            focusNode: emailFormFocus,
                            name: "이메일",
                            controller: emailController,
                            onChanged: (text) => setState(() {
                              _email = text;
                              clearVisibleState();
                            }),
                            hint: "weddingmoa@dingmo.com",
                            suffixIcon: GestureDetector(
                                onTap: _email.isNotEmpty &&
                                        Validator.emailValidation(_email)
                                    ? () async {
                                        clearVisibleState();

                                        setLoadingEmailDupCheck(true);
                                        final dupResult =
                                            await getIt<AuthManager>()
                                                .existsEmail(_email);
                                        setLoadingEmailDupCheck(false);

                                        if (dupResult == null) {
                                          Fluttertoast.showToast(
                                              msg: "문제가 발생하였습니다");
                                        } else {
                                          if (dupResult.exists) {
                                            showMsgEmailDupError();
                                          } else {
                                            showMsgEmailUsable();
                                          }
                                        }
                                      }
                                    : null,
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        top: 18, right: 20),
                                    child: Text("중복조회",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.mediumPink
                                                .withOpacity(_email
                                                            .isNotEmpty &&
                                                        Validator
                                                            .emailValidation(
                                                                _email)
                                                    ? 1
                                                    : 0.6))))),
                          ),
                        ),
                        Visibility(
                          visible: _isLoadingDupEmailCheck,
                          child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.mediumPink,
                                  ))),
                        )
                      ]),
                      Visibility(
                          visible: _visibleEmailDupError,
                          child: FormMessageText(
                            text: "이미 사용 중인 이메일입니다.",
                            textColor: AppColors.strawberry,
                          )),
                      Visibility(
                          visible: _visibleEmailUsable,
                          child: FormMessageText(
                            text: "사용 가능한 이메일입니다.",
                            textColor: AppColors.purpleGrey,
                          )),
                      Visibility(
                          visible: _email.isNotEmpty &&
                              !Validator.emailValidation(_email),
                          child: FormMessageText(
                            text: "이메일 형식이 올바르지 않습니다.",
                            textColor: AppColors.purpleGrey,
                          )),
                      const SizedBox(height: 25),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            PassForm(
                                focusNode: passFormFocus,
                                name: "비밀번호",
                                controller: passController,
                                onChanged: (text) => setState(() {
                                      _pass = text;
                                      _passLevel =
                                          Validator.getPassSecurityLevel(_pass);
                                    }),
                                obsecureText: !_isVisiblePass,
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
                          ]),
                      const SizedBox(height: 10),
                      Visibility(
                          visible: passController.text.isNotEmpty,
                          child:
                              PWSecurityLevelWidget(securityLevel: _passLevel)),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.245),
                      ElevatedButton(
                          onPressed: isAllFilled() &&
                                  Validator.emailValidation(_email) &&
                                  _passLevel >= 4 &&
                                  _visibleEmailUsable
                              ? () {
                                  FocusScope.of(context).unfocus();
                                  form.email = _email;
                                  form.password = _pass;
                                  goNextPage();
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
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            )),
                          ))
                    ]),
              ),
            ],
          ),
        ));
  }

  void clearVisibleState() {
    _visibleEmailDupError = false;
    _visibleEmailUsable = false;
  }

  void showMsgEmailUsable() {
    setState(() {
      _visibleEmailDupError = false;
      _visibleEmailUsable = true;
    });
  }

  void showMsgEmailDupError() {
    setState(() {
      _visibleEmailDupError = true;
      _visibleEmailUsable = false;
    });
  }

  void setLoadingEmailDupCheck(bool isLoading) {
    setState(() {
      _isLoadingDupEmailCheck = isLoading;
    });
  }

  void goNextPage() {
    Future.delayed(const Duration(milliseconds: 200),
        () => Navigator.pushNamed(context, Routes.signupTypeSelect1));
  }

  bool isAllFilled() {
    return _email.isNotEmpty && _pass.isNotEmpty;
  }

  Widget getEyeOffIcon() {
    return SvgPicture.asset("assets/sign/eye_off.svg");
  }

  Widget getEyeOnIcon() {
    return SvgPicture.asset("assets/sign/eye_on.svg");
  }
}
