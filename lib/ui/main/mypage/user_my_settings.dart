import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/main/mypage/widgets/mypage_divider.dart';
import 'package:dingmo/ui/main/mypage/widgets/mypage_menu.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants/colors.dart';
import 'widgets/logout_confirm_dialog.dart';
import 'widgets/resign_confirm_dialog.dart';

class UserMySettingsPage extends StatefulWidget {
  const UserMySettingsPage({Key? key}) : super(key: key);

  @override
  State<UserMySettingsPage> createState() => _UserMySettingsPageState();
}

class _UserMySettingsPageState extends State<UserMySettingsPage> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isLoading;
      },
      child: IgnorePointer(
          ignoring: _isLoading,
          child: Stack(
            children: [
              Scaffold(
                appBar: AppBars.defaultAppBar(context, title: "설정"),
                body: Column(children: [
                  MyPageMenu(
                      name: "알림 설정",
                      onPressed: () => Navigator.pushNamed(
                          context, Routes.userMyNotiSettings)),
                  const MyPageDivider(),
                  MyPageMenu(
                      name: "약관 및 정책",
                      onPressed: () => Navigator.pushNamed(
                          context, Routes.termsAndPolicies)),
                  const MyPageDivider(),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "현재 버전",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.greyishBrown,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "1.0 최신 버전",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.veryLightPink,
                                fontWeight: FontWeight.w500),
                          ),
                        ]),
                  ),
                  const MyPageDivider(height: 4),
                  GestureDetector(
                      onTap: () {
                        getIt<AuthManager>().signOut().then((_) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.start, (route) => false);
                          Fluttertoast.showToast(msg: "로그아웃 되었습니다");
                        });
                      },
                      child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "로그아웃",
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.greyishBrown,
                                fontWeight: FontWeight.w500),
                          ))),
                  const MyPageDivider(),
                  GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(msg: "회원탈퇴");
                      },
                      child: Container(
                          color: Colors.transparent,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "회원탈퇴",
                            style: TextStyle(
                                fontSize: 12, color: AppColors.purpleGrey),
                          ))),
                ]),
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

  void showResignAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return ResignConfirmDialog(onYes: () {
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
          return LogoutConfirmDialog(onYes: () {
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
