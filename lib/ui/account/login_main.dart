import 'dart:io';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/constants/social_type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/account/signup/form/signup_form.dart';
import 'package:dingmo/ui/widgets/light_status_bar.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:dingmo/utils/permission_manager.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class LoginMainPage extends StatefulWidget {
  const LoginMainPage({Key? key}) : super(key: key);

  @override
  State<LoginMainPage> createState() => _LoginMainPageState();
}

class _LoginMainPageState extends State<LoginMainPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    getIt<PermissionManager>().isAllChecked().then((isAllChecked) {
      if (!isAllChecked) {
        Navigator.pushNamed(context, Routes.permission)
            .then((isOkAll) => isOkAll != true ? Navigator.pop(context) : {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isLoading;
      },
      child: IgnorePointer(
          ignoring: _isLoading,
          child: LightStatusBarWidget(
            child: Stack(
              children: [
                Scaffold(
                  body: SafeArea(
                      child: Container(
                    padding: const EdgeInsets.only(
                        left: Dimens.horizontalPadding,
                        right: Dimens.horizontalPadding,
                        bottom: Dimens.verticalPadding),
                    alignment: Alignment.center,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 200),
                          Image.asset('assets/splash.png', width: 130),
                          const Spacer(),
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  setLoading(true);
                                  final kakaoUser =
                                      await getIt<AuthManager>().kakaoLogin();

                                  if (!await validateKakaoLogin(
                                      kakaoUser?.userData)) {
                                    setLoading(false);
                                  }

                                  final existResult = await getIt<AuthManager>()
                                      .existsEmail(kakaoUser!
                                          .userData.kakaoAccount!.email!);

                                  if (existResult == null) {
                                    await cancelKakaoLogin();
                                    setLoading(false);
                                    Fluttertoast.showToast(msg: "카카오 로그인 실패");
                                  }

                                  if (existResult!.exists &&
                                      valueToSocialType(
                                              existResult.socialType) !=
                                          SocialType.kakao) {
                                    await cancelKakaoLogin();
                                    setLoading(false);
                                    Fluttertoast.showToast(
                                        msg: "이미 다른 방법으로 가입한 이메일입니다");
                                    return;
                                  }

                                  final loginResult = await getIt<AuthManager>()
                                      .login(kakaoUser.getCredentials()!);
                                  setLoading(false);
                                  if (loginResult == LoginResult.success) {
                                    Fluttertoast.showToast(msg: "환영합니다!");
                                    pop();
                                    return;
                                  }

                                  SignUpForm.instance().socialSignUpType =
                                      SocialType.kakao;
                                  SignUpForm.instance().email =
                                      kakaoUser.userData.kakaoAccount!.email;
                                  SignUpForm.instance().password =
                                      kakaoUser.userData.id.toString();

                                  setLoading(false);
                                  goRoute(Routes.agreements);
                                },
                                child: SvgPicture.asset(
                                  'assets/sign/kakao_login.svg',
                                ),
                              ),
                              const SizedBox(height: 15),
                              Visibility(
                                visible: Platform.isIOS,
                                maintainState: true,
                                child: SvgPicture.asset(
                                  'assets/sign/apple_login.svg',
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 35),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  SignUpForm.instance().clear();
                                  Navigator.pushNamed(
                                      context, Routes.agreements);
                                },
                                child: const Text(
                                  "이메일로 회원가입",
                                ),
                              ),
                              const Text(
                                " | ",
                              ),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(
                                        context, Routes.loginEmail)
                                    .then((isLoginOk) => isLoginOk == true
                                        ? Navigator.pop(context)
                                        : {}),
                                child: const Text(
                                  "이메일로 로그인",
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 45),
                          Text.rich(TextSpan(children: [
                            const TextSpan(
                              text: "가입 시 ",
                              style: TextStyle(fontSize: 12),
                            ),
                            TextSpan(
                                text: "이용약관",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => safePrint("이용약관 클릭됨")),
                            const TextSpan(
                              text: " 및 ",
                              style: TextStyle(fontSize: 12),
                            ),
                            TextSpan(
                                text: "개인정보처리방침",
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => safePrint("개인정보처리방침 클릭됨")),
                            const TextSpan(
                              text: "에 동의한 것으로 간주합니다",
                              style: TextStyle(fontSize: 12),
                            )
                          ]))
                        ]),
                  )),
                ),
                Visibility(
                    visible: _isLoading,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.mediumPink,
                      ),
                    ))
              ],
            ),
          )),
    );
  }

  void pop() {
    Navigator.pop(context);
  }

  Future<bool> validateKakaoLogin(User? userInfo) async {
    if (userInfo == null ||
        userInfo.kakaoAccount == null ||
        userInfo.kakaoAccount?.email == null) {
      await cancelKakaoLogin();
      setLoading(false);
      return false;
    }

    return true;
  }

  void setLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  Future<void> cancelKakaoLogin() async {
    try {
      await getIt<AuthManager>().kakaoUnlink();
    } catch (e) {
      safePrint("exception: $e");
    }
  }

  void goRoute(String routeName) {
    Navigator.pushNamed(context, routeName);
  }
}
