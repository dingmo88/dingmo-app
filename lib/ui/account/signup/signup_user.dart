import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/colors.dart';
import '../../../constants/dimens.dart';
import '../../widgets/buttons.dart';
import '../../widgets/form.dart';
import '../../widgets/texts.dart';
import '../widgets/signup_progress.dart';
import '../widgets/step_description.dart';
import 'form/signup_form.dart';

class SignUpUserNicknamePage extends StatefulWidget {
  const SignUpUserNicknamePage({Key? key}) : super(key: key);

  @override
  State<SignUpUserNicknamePage> createState() => _SignUpUserNicknamePageState();
}

class _SignUpUserNicknamePageState extends State<SignUpUserNicknamePage> {
  String nickname = "";

  final SignUpForm form = SignUpForm.instance();

  bool isLoadingDupNicknameCheck = false;
  bool visibleNicknameDupError = false;
  bool visibleNicknameUsable = false;

  final FocusNode nicknameFormFocus = FocusNode();
  final TextEditingController nicknameController = TextEditingController();

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
              const SignUpProgressWidget(progress: 20),
              const SizedBox(height: 30),
              const StepDescriptionWidget(
                  title: "닉네임 설정", description: "딩모에서 사용할 닉네임을 만들어주세요."),
              const SizedBox(height: 105),
              Stack(children: [
                IgnorePointer(
                  ignoring: isLoadingDupNicknameCheck,
                  child: TextForm(
                    focusNode: nicknameFormFocus,
                    name: "닉네임",
                    controller: nicknameController,
                    onChanged: (text) => setState(() {
                      nickname = text;
                      visibleNicknameDupError = false;
                      visibleNicknameUsable = false;
                      isLoadingDupNicknameCheck = false;
                    }),
                    hint: "닉네임을 입력해주세요.",
                    suffixIcon: GestureDetector(
                        onTap: () {
                          if (nickname.isNotEmpty &&
                              isValidNickname(nickname)) {
                            setState(() {
                              isLoadingDupNicknameCheck = true;
                            });

                            Future.delayed(const Duration(seconds: 1), () {
                              if (!visibleNicknameDupError) {
                                setState(() {
                                  visibleNicknameDupError = true;
                                  visibleNicknameUsable = false;
                                  isLoadingDupNicknameCheck = false;
                                });
                              } else if (!visibleNicknameUsable) {
                                setState(() {
                                  visibleNicknameDupError = false;
                                  visibleNicknameUsable = true;
                                  isLoadingDupNicknameCheck = false;
                                });
                              }
                            });
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.only(top: 18, right: 20),
                            child: Text("중복조회",
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.mediumPink.withOpacity(
                                        nickname.isNotEmpty &&
                                                isValidNickname(nickname)
                                            ? 1
                                            : 0.6))))),
                  ),
                ),
                Visibility(
                  visible: isLoadingDupNicknameCheck,
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
                  visible: visibleNicknameDupError,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      "이미 사용 중인 닉네임입니다.",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.strawberry,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
              Visibility(
                  visible: visibleNicknameUsable,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      "사용 가능한 닉네임입니다.",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.purpleGrey,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
              Visibility(
                  visible: nickname.isNotEmpty && !isValidNickname(nickname),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 10),
                    child: Text(
                      "닉네임 형식이 올바르지 않습니다. (특수문자, 공백 불가)",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.strawberry,
                          fontWeight: FontWeight.w500),
                    ),
                  )),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "비방, 욕설이 포함된 닉네임은 추후 이용이 제한 될 수 있습니다.",
                  style: TextStyle(fontSize: 13, color: AppColors.purpleGrey),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                  onPressed: nickname.isNotEmpty &&
                          isValidNickname(nickname) &&
                          visibleNicknameUsable
                      ? () {
                          FocusScope.of(context).unfocus();
                          form.userInfoForm.nickname = nickname;

                          Navigator.pushNamed(
                              context, Routes.signUpUserDateWedding);
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

  bool isValidNickname(String nickname) {
    return RegExp(r'^[a-zA-Z0-9]+$').hasMatch(nickname);
  }
}

class SignUpUserDateWeddingPage extends StatefulWidget {
  const SignUpUserDateWeddingPage({Key? key}) : super(key: key);

  @override
  State<SignUpUserDateWeddingPage> createState() =>
      _SignUpUserDateWeddingPageState();
}

class _SignUpUserDateWeddingPageState extends State<SignUpUserDateWeddingPage> {
  String dateWedding = "";

  final SignUpForm form = SignUpForm.instance();

  final FocusNode nicknameFormFocus = FocusNode();
  final TextEditingController dateWeddingController = TextEditingController();

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
              const SignUpProgressWidget(progress: 20),
              const SizedBox(height: 30),
              const StepDescriptionWidget(
                  title: "예식 날짜 입력", description: "예식일이 결정되셨나요?"),
              const SizedBox(height: 105),
              TextForm(
                focusNode: nicknameFormFocus,
                name: "예식 예정 날짜",
                controller: dateWeddingController,
                onChanged: (text) => setState(() {
                  dateWedding = text;
                }),
                hint: "ex) 2023.01.23",
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: dateWedding.isNotEmpty
                      ? () {
                          FocusScope.of(context).unfocus();
                          form.userInfoForm.nickname = dateWedding;
                          Navigator.pushNamed(context, Routes.signUpUserOk);
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
              const SizedBox(height: 24),
              Container(
                alignment: Alignment.center,
                child: Buttons.textButton(
                    width: 100,
                    text: "건너뛰기",
                    onTap: () {
                      Navigator.pushNamed(context, Routes.signUpUserOk);
                    }),
              ),
              const SizedBox(height: 55),
            ],
          )),
    );
  }
}

class SignUpUserOkPage extends StatelessWidget {
  const SignUpUserOkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 60),
          Container(
              alignment: Alignment.center,
              child: Texts.defaultText(
                  text: "가입완료!", fontSize: 24, fontWeight: FontWeight.w700)),
          const SizedBox(height: 65),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 75),
            child: SvgPicture.asset("assets/sign/congra_present_icon.svg"),
          ),
          const SizedBox(height: 30),
          Text.rich(
              textAlign: TextAlign.center,
              TextSpan(children: [
                TextSpan(
                    text: "김딩모  ",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.mediumPink,
                        fontWeight: FontWeight.w500,
                        height: 1.2)),
                TextSpan(
                    text: "님의\n",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.greyishBrown,
                        fontWeight: FontWeight.w500,
                        height: 1.2)),
                TextSpan(
                    text: "회원가입을 축하드립니다!\n\n",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.greyishBrown,
                        fontWeight: FontWeight.w500,
                        height: 1.2)),
                TextSpan(
                    text: "이제 딩모에서 함께\n",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.greyishBrown,
                        fontWeight: FontWeight.w500,
                        height: 1.2)),
                TextSpan(
                    text: "웨딩 정보를 모아보아요☺️",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.greyishBrown,
                        fontWeight: FontWeight.w500,
                        height: 1.2))
              ])),
          const Spacer(),
          Buttons.defaultButton(
              text: "딩모 시작하기",
              onPressed: () {
                Navigator.pushNamed(context, Routes.start);
              }),
          const SizedBox(height: 55),
        ],
      ),
    )));
  }
}
