import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_profile_plan.dart';
import 'package:dingmo/api/api_third_party.dart';
import 'package:dingmo/api/commons/api_response.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/social_type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_certifications.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/buttons.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/disabled_myinfo_form.dart';
import 'widgets/enabled_myinfo_form.dart';
import 'widgets/logout_confirm_dialog.dart';
import 'widgets/resign_confirm_dialog.dart';

class PlanMyInfoPage extends StatefulWidget {
  const PlanMyInfoPage({Key? key}) : super(key: key);

  @override
  State<PlanMyInfoPage> createState() => _PlanMyInfoPageState();
}

class _PlanMyInfoPageState extends State<PlanMyInfoPage> {
  bool _isLoading = false;

  final socialType = getIt<MemberInfo>().socialType;

  bool _isLoadingTeamName = false;
  bool _isLoadingCert = false;

  String? newPhone;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isLoadingTeamName && !_isLoadingCert && !_isLoading;
      },
      child: IgnorePointer(
          ignoring: _isLoading,
          child: Stack(
            children: [
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: FutureBuilder<ApiResponse<GetPlanMyinfoResult>>(
                  future: getIt<ApiProfilePlan>().getMyinfo(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.mediumPink,
                        ),
                      );
                    } else {
                      final result = snapshot.data!.result;

                      return Scaffold(
                        appBar: AppBars.defaultAppBar(context,
                            title: "내 정보",
                            closeEnabled:
                                !_isLoadingTeamName && !_isLoadingCert),
                        body: SingleChildScrollView(
                            reverse: true,
                            child: Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "로그인 계정",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.greyishBrown,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        socialTypeIcon(),
                                        const SizedBox(width: 5),
                                        Text(
                                          result.email,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.purpleGrey),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 25),
                                    Visibility(
                                        visible: socialType == SocialType.email,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "비밀번호",
                                            style: TextStyle(
                                                color: AppColors.purpleGrey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )),
                                    const SizedBox(height: 10),
                                    socialType == SocialType.email
                                        ? GestureDetector(
                                            onTap: () async {
                                              FocusScope.of(context).unfocus();
                                              Navigator.pushNamed(
                                                  context, Routes.changePass);
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10,
                                                          right: 60,
                                                          top: 15,
                                                          bottom: 15),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .veryLightPink),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  child: const Text(
                                                    "",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 14),
                                                  height: 50,
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "변경",
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: AppColors
                                                            .mediumPink,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : const DisabledMyInfoFormWidget(
                                            name: "비밀번호", content: ""),
                                    const SizedBox(height: 20),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "휴대폰 번호",
                                        style: TextStyle(
                                            color: AppColors.purpleGrey,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    GestureDetector(
                                      onTap: () async {
                                        FocusScope.of(context).unfocus();
                                        setState(() {
                                          _isLoadingCert = true;
                                        });

                                        Navigator.pushNamed(
                                            context, Routes.certifications,
                                            arguments: CertificationsArgs(
                                                onComplete: ((result) async {
                                          if (result == null) {
                                            setState(() {
                                              _isLoadingCert = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg: "본인인증에 실패했습니다");
                                          } else {
                                            final isSucceed =
                                                await updatePersonalInfo(
                                                    result);
                                            setState(() {
                                              _isLoadingCert = false;
                                            });
                                            Fluttertoast.showToast(
                                                msg: isSucceed
                                                    ? "수정 완료"
                                                    : "수정 실패");
                                          }
                                        }))).then((_) => setState(() {
                                              _isLoadingCert = false;
                                            }));
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 60,
                                                top: 15,
                                                bottom: 15),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: AppColors
                                                        .veryLightPink),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Text(
                                              formatPhoneNumber(
                                                  newPhone ?? result.phone),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 14),
                                            height: 50,
                                            alignment: Alignment.centerRight,
                                            child: Buttons.textButton(
                                              onTap: () async {
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              width: 40,
                                              text: "변경",
                                              fontSize: 13,
                                              color: AppColors.mediumPink,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 25),
                                    Container(
                                      color: AppColors.white,
                                      width: double.infinity,
                                      height: 1,
                                    ),
                                    const SizedBox(height: 20),
                                    IgnorePointer(
                                      ignoring: _isLoadingTeamName,
                                      child: Stack(children: [
                                        EnabledMyInfoFormWidget(
                                            name: "컨설팅 소속명",
                                            content: result.teamName ?? "",
                                            onSubmit: (newText) async {
                                              if (newText == result.teamName) {
                                                return;
                                              }

                                              FocusScope.of(context).unfocus();

                                              setState(() {
                                                _isLoadingTeamName = true;
                                              });

                                              final isSucceed =
                                                  await updateTeamName(newText);

                                              setState(() {
                                                _isLoadingTeamName = false;
                                              });
                                              Fluttertoast.showToast(
                                                  msg: isSucceed
                                                      ? "수정 완료"
                                                      : "수정 실패");
                                            }),
                                        Visibility(
                                            visible: _isLoadingTeamName,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: AppColors.mediumPink,
                                              ),
                                            ))
                                      ]),
                                    ),
                                    const SizedBox(height: 30),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: showLogoutAlertDialog,
                                          child: Text(
                                            "로그아웃",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.purpleGrey,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                            width: 1,
                                            height: 10,
                                            color: AppColors.purpleGrey),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: showResignAlertDialog,
                                          child: Text(
                                            "회원탈퇴",
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: AppColors.purpleGrey,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ))),
                      );
                    }
                  },
                ),
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
          )),
    );
  }

  Future<bool> updatePersonalInfo(PostCertPersonResult result) async {
    try {
      await getIt<ApiProfilePlan>().updateMyinfo(PatchPlanMyinfoRequest(
          personal:
              PlanMyinfoPersonal(result.phone, result.name, result.birthDay)));
      return true;
    } catch (e) {
      safePrint("debug! $e");
    }
    return false;
  }

  Future<bool> updateTeamName(String teamName) async {
    try {
      await getIt<ApiProfilePlan>()
          .updateMyinfo(PatchPlanMyinfoRequest(teamName: teamName));
      return true;
    } catch (e) {
      safePrint("debug! $e");
    }
    return false;
  }

  String formatPhoneNumber(String phone) {
    return "${phone.substring(0, 3)}-${phone.substring(3, 7)}-${phone.substring(7, phone.length)}";
  }

  Widget socialTypeIcon() {
    if (socialType == SocialType.kakao) {
      return SvgPicture.asset("assets/mypage/kakaologin_icon.svg");
    } else if (socialType == SocialType.apple) {
      return SvgPicture.asset("assets/mypage/kakaologin_icon.svg");
    } else {
      return Container();
    }
  }

  void showResignAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return ResignConfirmDialog(onYes: () async {
            setState(() {
              _isLoading = true;
            });
            getIt<AuthManager>().resignWithSignOut().then((isOk) {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.start, (route) => false);
              if (isOk) {
                Fluttertoast.showToast(msg: "회원탈퇴 완료");
              } else {
                Fluttertoast.showToast(msg: "회원탈퇴 실패");
              }
            });
          });
        });
  }

  void showLogoutAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return LogoutConfirmDialog(onYes: () async {
            setState(() {
              _isLoading = true;
            });
            getIt<AuthManager>().signOut().then((_) {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.start, (route) => false);
              Fluttertoast.showToast(msg: "로그아웃 되었습니다");
            });
          });
        });
  }
}
