import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_exists.dart';
import 'package:dingmo/api/api_third_party.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/third_party/aws_amplify.dart';
import 'package:dingmo/ui/account/widgets/form_message.dart';
import 'package:dingmo/ui/account/widgets/signup_progress.dart';
import 'package:dingmo/ui/account/widgets/step_description.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/buttons.dart';
import 'package:dingmo/ui/widgets/form.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'form/signup_form.dart';

class CompNumCheckPage extends StatefulWidget {
  const CompNumCheckPage({Key? key}) : super(key: key);

  @override
  State<CompNumCheckPage> createState() => _CompNumCheckPageState();
}

class CompInfoDetailsCheckPage extends StatefulWidget {
  const CompInfoDetailsCheckPage({Key? key}) : super(key: key);

  @override
  State<CompInfoDetailsCheckPage> createState() =>
      _CompInfoDetailsCheckPageState();
}

class _CompInfoDetailsCheckPageState extends State<CompInfoDetailsCheckPage> {
  final SignUpForm _form = SignUpForm.instance();

  final FocusNode nicknameFocus = FocusNode();
  final FocusNode addressDetailsFocus = FocusNode();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController addressDetailsController =
      TextEditingController();

  bool _isInProgressVerification = false;
  bool _isInProgressDupCheckNickname = false;
  bool _isNicknameDuplicated = false;
  bool _isNicknameUsable = false;

  String _nickname = "";
  GetSearchAddressInfo? _addressInfo;
  String _addressDetails = "";

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: _isInProgressVerification,
      child: Scaffold(
        appBar: AppBars.defaultAppBar(context),
        body: Stack(children: [
          SingleChildScrollView(
              reverse: true,
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const SignUpProgressWidget(progress: 80),
                      const SizedBox(height: 30),
                      const StepDescriptionWidget(
                        title: "?????????, ?????? ??????",
                        description: "???????????? ????????? ?????????(?????????)??? ????????? ??????????????????.",
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            IgnorePointer(
                              ignoring: _isInProgressDupCheckNickname,
                              child: TextForm(
                                focusNode: nicknameFocus,
                                name: "?????????(?????????)",
                                controller: nicknameController,
                                onChanged: (text) {
                                  setState(() {
                                    clearAllNickDupState();
                                    _nickname = text;
                                  });
                                },
                                hint: "????????????",
                                suffixIcon: GestureDetector(
                                    onTap: _nickname.isNotEmpty == true
                                        ? () async {
                                            clearAllNickDupState();

                                            setLoadingNicknameDupCheck(true);

                                            final isExistNickname =
                                                await _checkExistsNickname(
                                                    _nickname);

                                            setLoadingNicknameDupCheck(false);

                                            if (isExistNickname == null) {
                                              Fluttertoast.showToast(
                                                  msg: "????????? ?????????????????????");
                                            } else if (isExistNickname) {
                                              showMsgNicknameDupError();
                                            } else {
                                              showMsgNicknameUsable();
                                            }
                                          }
                                        : null,
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            top: 18, right: 20),
                                        child: Text("????????????",
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: AppColors.mediumPink
                                                    .withOpacity(
                                                        _nickname.isNotEmpty
                                                            ? 1
                                                            : 0.6))))),
                              ),
                            ),
                            Visibility(
                              visible: _isInProgressDupCheckNickname,
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
                              visible: _isNicknameDuplicated,
                              child: FormMessageText(
                                text: "?????? ?????? ?????? ??????????????????.",
                                textColor: AppColors.strawberry,
                              )),
                          Visibility(
                              visible: _isNicknameUsable,
                              child: FormMessageText(
                                text: "?????? ????????? ??????????????????.",
                                textColor: AppColors.purpleGrey,
                              )),
                          const SizedBox(height: 25),
                          Text(
                            "?????? ??????",
                            style: TextStyle(
                                color: AppColors.purpleGrey,
                                fontSize: 13,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () async {
                              FocusScope.of(context).unfocus();
                              final result = await getAddressFromSearchPage();
                              if (result is GetSearchAddressInfo) {
                                setState(() {
                                  _addressInfo = result;
                                });
                              }
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 60, top: 15, bottom: 15),
                                  alignment: Alignment.centerLeft,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.veryLightPink),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    _addressInfo?.roadAddress ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 14),
                                  height: 50,
                                  alignment: Alignment.centerRight,
                                  child: Buttons.textButton(
                                    onTap: () async {
                                      FocusScope.of(context).unfocus();
                                      final result =
                                          await getAddressFromSearchPage();
                                      if (result is GetSearchAddressInfo) {
                                        setState(() {
                                          _addressInfo = result;
                                        });
                                      }
                                    },
                                    width: 40,
                                    text: "??????",
                                    fontSize: 13,
                                    color: AppColors.mediumPink,
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          TextForm(
                              isEnabled: _addressInfo != null,
                              focusNode: addressDetailsFocus,
                              name: "?????? ??????",
                              controller: addressDetailsController,
                              onChanged: (text) => setState(
                                    () => _addressDetails = text,
                                  ),
                              // suffixIcon: ,
                              hint: "ex) B??? 902???")
                        ],
                      ),
                      const SizedBox(height: 150),
                      ElevatedButton(
                          onPressed: isAllFilled()
                              ? () async {
                                  FocusScope.of(context).unfocus();

                                  _setDataToForm();

                                  setStateInProgress(true);

                                  final sendResult = await getIt<AuthManager>()
                                      .sendVerificationEmail(AuthCredentials(
                                          email: _form.email!,
                                          password: _form.password!));

                                  safePrint("sendResult: $sendResult");
                                  if (sendResult == AmpResState.error) {
                                    Fluttertoast.showToast(msg: "???????????? ?????? ??????");
                                  } else if (sendResult ==
                                      AmpResState.limited) {
                                    Fluttertoast.showToast(
                                        msg:
                                            "?????? ?????? ????????? 5??? ?????????????????????. ?????? 1?????? ??? ?????? ??????????????????.");
                                  } else {
                                    goVerificationPage();
                                  }

                                  setStateInProgress(false);
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
                              "?????? ??????",
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            )),
                          )),
                      const SizedBox(height: 55),
                    ],
                  ))),
          Visibility(
              visible: _isInProgressVerification,
              child: Center(
                  child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.mediumPink,
              )))
        ]),
      ),
    );
  }

  Future<bool?> _checkExistsNickname(String nickname) async {
    try {
      return (await getIt<ApiExists>()
              .nickname(PostNicknameExistsRequest(nickname: nickname)))
          .result
          .exists;
    } catch (e) {
      safePrint("exception: $e");
      return null;
    }
  }

  void _setDataToForm() {
    _form.compInfoForm.nickname = _nickname;
    _form.compInfoForm.addressInfo = _addressInfo;
    _form.compInfoForm.addrressDetails = _addressDetails;
  }

  Future<Object?> getAddressFromSearchPage() {
    return Navigator.pushNamed(context, Routes.compSearchAddress)
        .then((value) => value);
  }

  void showMsgNicknameUsable() {
    setState(() {
      _isNicknameDuplicated = false;
      _isNicknameUsable = true;
    });
  }

  void showMsgNicknameDupError() {
    setState(() {
      _isNicknameDuplicated = true;
      _isNicknameUsable = false;
    });
  }

  void clearAllNickDupState() {
    _isInProgressDupCheckNickname = false;
    _isNicknameDuplicated = false;
    _isNicknameUsable = false;
  }

  void setLoadingNicknameDupCheck(bool isLoading) {
    setState(() {
      _isInProgressDupCheckNickname = isLoading;
    });
  }

  bool isAllFilled() {
    return _addressInfo != null &&
        _addressDetails.isNotEmpty &&
        (_nickname.isNotEmpty && _isNicknameUsable);
  }

  double getSelectionCardWidth() {
    return (MediaQuery.of(context).size.width - (20 + 20 + 20)) / 2;
  }

  void setStateInProgress(bool isInProgress) {
    setState(() {
      _isInProgressVerification = isInProgress;
    });
  }

  void goVerificationPage() {
    Navigator.pushNamed(context, Routes.verification);
  }
}

class _CompNumCheckPageState extends State<CompNumCheckPage> {
  final SignUpForm form = SignUpForm.instance();

  final FocusNode compNumFocus = FocusNode();
  final FocusNode compNameFocus = FocusNode();
  final FocusNode ceoNameFocus = FocusNode();
  final TextEditingController compNumController = TextEditingController();
  final TextEditingController compNameController = TextEditingController();
  final TextEditingController ceoNameController = TextEditingController();

  bool _isInProgress = false;
  PostCertCorpResult? _certCorpResult;

  @override
  void initState() {
    super.initState();
    compNumController.text = form.compInfoForm.compNum ?? "";
    compNameController.text = "";
    ceoNameController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context),
      body: SingleChildScrollView(
          reverse: true,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const SignUpProgressWidget(progress: 60),
                  const SizedBox(height: 30),
                  const StepDescriptionWidget(
                    title: "????????? ???????????? ??????",
                    description: "?????? ????????? ?????? ?????? ????????? ???????????????.",
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.17),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IgnorePointer(
                        ignoring: _isInProgress || isValidatedCorpNum(),
                        child: Stack(children: [
                          NumForm(
                              focusNode: compNumFocus,
                              name: "????????? ???????????? ??????",
                              controller: compNumController,
                              onChanged: (text) => setState(
                                    () => form.compInfoForm.compNum = text,
                                  ),
                              isEnabled: !isValidatedCorpNum(),
                              suffixIcon: Buttons.textButton(
                                  onTap: () async {
                                    if (form.compInfoForm.compNum?.isNotEmpty ==
                                        true) {
                                      form.compInfoForm.compNum =
                                          extractOnlyNumber(
                                              form.compInfoForm.compNum!);

                                      compNumController.text =
                                          form.compInfoForm.compNum!;

                                      setStateInProgress(true);
                                      _certCorpResult = await validateCompNum(
                                          form.compInfoForm.compNum ?? "");
                                      setStateInProgress(false);

                                      setState(() {
                                        if (_certCorpResult == null) {
                                          Fluttertoast.showToast(
                                              msg: "????????? ?????????????????????");
                                        } else if (_certCorpResult!.validated) {
                                          disableCompNumForm();
                                        }
                                      });
                                    }
                                  },
                                  width: 40,
                                  text: "??????",
                                  fontSize: 13,
                                  color: isValidatedCorpNum()
                                      ? AppColors.veryLightPink
                                      : AppColors.mediumPink),
                              hint: isValidatedCorpNum()
                                  ? form.compInfoForm.compNum
                                  : "123-45-67890"),
                          Visibility(
                            visible: _isInProgress,
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
                      ),
                      const SizedBox(height: 10),
                      Visibility(
                          visible: _certCorpResult != null &&
                              !_certCorpResult!.validated,
                          child: Text(
                            "???????????? ?????? ?????????????????????.",
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.strawberry,
                                fontWeight: FontWeight.w500),
                          )),
                      const SizedBox(height: 25),
                      Visibility(
                          visible: isValidatedCorpNum(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextForm(
                                  focusNode: compNameFocus,
                                  name: "?????????",
                                  controller: compNameController,
                                  onChanged: (text) => setState(
                                        () => form.compInfoForm.corpName = text,
                                      ),
                                  hint: "(???)??????"),
                              const SizedBox(height: 25),
                              TextForm(
                                  focusNode: ceoNameFocus,
                                  name: "?????????",
                                  controller: ceoNameController,
                                  onChanged: (text) => setState(
                                        () => form.compInfoForm.ceoName = text,
                                      ),
                                  hint: "?????????"),
                            ],
                          ))
                    ],
                  ),
                  const SizedBox(height: 38),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "?????? ??????????????? ???????????? ????????? ??? ????????????",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.purpleGrey,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                      onPressed: isOkForm()
                          ? () {
                              FocusScope.of(context).unfocus();
                              Future.delayed(
                                  const Duration(milliseconds: 200),
                                  () => Navigator.pushNamed(
                                      context, Routes.compInfoDetails));
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
                          "??????",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        )),
                      )),
                  const SizedBox(height: 55),
                ],
              ))),
    );
  }

  String extractOnlyNumber(String text) {
    return text.replaceAll(RegExp(r'[^0-9]'), '');
  }

  bool isValidatedCorpNum() {
    return _certCorpResult?.validated == true;
  }

  void disableCompNumForm() {
    compNumFocus.unfocus();
    compNumController.clear();
  }

  bool isOkForm() {
    return isValidatedCorpNum() &&
        form.compInfoForm.corpName?.isNotEmpty == true &&
        form.compInfoForm.ceoName?.isNotEmpty == true;
  }

  void setStateInProgress(bool isInProgress) {
    setState(() {
      _isInProgress = isInProgress;
    });
  }

  Future<PostCertCorpResult?> validateCompNum(String compNum) async {
    try {
      return (await getIt<ApiThirdParty>()
              .certCorp(PostCertCorpRequest(bNo: compNum)))
          .result;
    } catch (e) {
      safePrint("exception: $e");
      return null;
    }
  }

  double getSelectionCardWidth() {
    return (MediaQuery.of(context).size.width - (20 + 20 + 20)) / 2;
  }
}
