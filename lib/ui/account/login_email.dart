import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/third_party/aws_amplify.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/form.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({Key? key}) : super(key: key);

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  final authManager = getIt<AuthManager>();
  final storage = getIt<FlutterSecureStorage>();

  bool isLoginFailed = false;

  bool isInProgressLogin = false;

  String _email = "";
  String _password = "";

  final FocusNode emailFocus = FocusNode();
  final FocusNode passFocus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => !isInProgressLogin,
        child: IgnorePointer(
          ignoring: isInProgressLogin,
          child: Stack(children: [
            Scaffold(
                appBar: AppBars.defaultAppBar(context,
                    title: "이메일로 로그인", closeEnabled: !isInProgressLogin),
                body: SingleChildScrollView(
                  reverse: true,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: Dimens.horizontalPadding),
                    child: Column(children: [
                      const SizedBox(height: 120),
                      TextForm(
                        focusNode: emailFocus,
                        name: "이메일",
                        controller: emailController,
                        onChanged: (text) => setState(() {
                          isLoginFailed = false;
                          _email = text;
                        }),
                      ),
                      const SizedBox(height: 25),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            PassForm(
                                focusNode: passFocus,
                                name: "비밀번호",
                                controller: passController,
                                onChanged: (text) => setState(() {
                                      isLoginFailed = false;
                                      _password = text;
                                    }),
                                obsecureText: true),
                            const SizedBox(height: 10),
                            Visibility(
                                visible: isLoginFailed,
                                child: Text(
                                  "이메일 또는 비밀번호가 일치하지 않습니다.",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.strawberry,
                                      fontWeight: FontWeight.w500),
                                )),
                            const SizedBox(height: 35),
                            ElevatedButton(
                                onPressed: isAllFilled() && !isLoginFailed
                                    ? () async {
                                        FocusScope.of(context).unfocus();

                                        setStateLoginFailed(false);
                                        setStateProgressLogin(true);

                                        final loginResult = await authManager
                                            .login(AuthCredentials(
                                                email: _email,
                                                password: _password));

                                        setStateProgressLogin(false);

                                        if (loginResult ==
                                            LoginResult.success) {
                                          Fluttertoast.showToast(msg: "환영합니다!");
                                          pop();
                                        } else {
                                          setStateLoginFailed(true);
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
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: const Text(
                                    "로그인",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                )),
                            const SizedBox(height: 20),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  Navigator.pushNamed(
                                      context, Routes.sendRecoveryMail);
                                },
                                child: Text(
                                  "비밀번호 찾기",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.purpleGrey,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ]),
                    ]),
                  ),
                )),
            Visibility(
                visible: isInProgressLogin,
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

  void pop() {
    Navigator.pop(context, true);
  }

  void setStateLoginFailed(bool isLoggedIn) {
    setState(() {
      isLoginFailed = isLoggedIn;
    });
  }

  void setStateProgressLogin(bool isInProgress) {
    setState(() {
      isInProgressLogin = isInProgress;
    });
  }

  bool isAllFilled() {
    return _email.isNotEmpty && _password.isNotEmpty;
  }
}
