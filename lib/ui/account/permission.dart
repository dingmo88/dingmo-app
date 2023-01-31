import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/utils/permission_manager.dart';
import 'package:flutter/material.dart';

import 'widgets/permission_info.dart';

class PermissionPage extends StatefulWidget {
  const PermissionPage({Key? key}) : super(key: key);

  @override
  State<PermissionPage> createState() => _PermissionPageState();
}

class _PermissionPageState extends State<PermissionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: Dimens.horizontalPadding),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 80),
            const Text(
              "필수 접근 권한 허용",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              "딩모 회원 이용을 위해 아래 권한이 필요합니다.",
              style: TextStyle(
                  fontSize: 13,
                  color: AppColors.purpleGrey,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 60),
            const PermissionInfoWidget(
                assetDir: "assets/permission/camera_icon.svg",
                title: "카메라/마이크 (필수)",
                description: "사진, 동영상 촬영"),
            const SizedBox(height: 30),
            const PermissionInfoWidget(
                assetDir: "assets/permission/folder_icon.svg",
                title: "저장공간 (필수)",
                description: "기기사진, 미디어, 파일 업로드"),
          ]),
          const Spacer(),
          ElevatedButton(
              onPressed: () =>
                  getIt<PermissionManager>().checkAll().then((isOk) {
                    Navigator.pop(context, isOk);
                  }),
              style: ElevatedButton.styleFrom(
                primary: AppColors.mediumPink,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: const Text(
                  "내용을 확인했습니다.",
                  style: TextStyle(fontSize: 14),
                ),
              )),
          const SizedBox(height: 55)
        ]),
      )),
    );
  }
}
