import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/main/mypage/widgets/logout_confirm_dialog.dart';
import 'package:dingmo/ui/main/mypage/widgets/mypage_divider.dart';
import 'package:dingmo/ui/main/mypage/widgets/mypage_menu.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants/colors.dart';
import 'widgets/resign_confirm_dialog.dart';

class MySettingsPage extends StatefulWidget {
  const MySettingsPage({Key? key}) : super(key: key);

  @override
  State<MySettingsPage> createState() => _MySettingsPageState();
}

class _MySettingsPageState extends State<MySettingsPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return !_isLoading;
      },
      child: IgnorePointer(
        ignoring: _isLoading,
        child: Stack(children: [
          Scaffold(
            appBar: AppBars.defaultAppBar(context, title: "설정"),
            body: Column(children: [
              MyPageMenu(
                  name: "알림 설정",
                  onPressed: () {
                    // Navigator.pushNamed(context, Routes.myNotiSettings);
                    Fluttertoast.showToast(msg: "coming soon!");
                  }),
              const MyPageDivider(),
              MyPageMenu(
                  name: "약관 및 정책",
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.termsAndPolicies);
                  }),
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
        ]),
      ),
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
