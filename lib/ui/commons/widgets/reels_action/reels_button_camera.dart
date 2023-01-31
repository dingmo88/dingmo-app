import 'package:amplify_core/amplify_core.dart';
import 'package:camera/camera.dart';
import 'package:dingmo/api/api_profile.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/args_reels_filming.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/utils/permission_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReelsCameraButton extends StatelessWidget {
  final permissionManager = getIt<PermissionManager>();

  ReelsCameraButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await existsArea()) {
          permissionManager.checkCamera().then((isOk) {
            if (isOk) {
              availableCameras().then((cameras) {
                Navigator.pushReplacementNamed(context, Routes.reelsFilming,
                        arguments: ReelsFilmingArgs(
                            pushReplacementHome: true,
                            backCamera: cameras.firstWhere(isBackCamera),
                            frontCamera: cameras.lastWhere(isFrontCamera)))
                    .then((_) {});
              });
            }
          });
        } else {
          Fluttertoast.showToast(msg: "프로필에서 위치 등록 후 이용하실 수 있습니다");
        }
      },
      child: Container(
          margin: const EdgeInsets.only(top: 55),
          child: SvgPicture.asset(
            "assets/permission/camera_icon.svg",
            color: Colors.white,
            width: 20,
          )),
    );
  }

  bool isFrontCamera(CameraDescription camera) {
    return camera.lensDirection == CameraLensDirection.front;
  }

  bool isBackCamera(CameraDescription camera) {
    return camera.lensDirection == CameraLensDirection.back;
  }

  Future<bool> existsArea() async {
    try {
      final response = await getIt<ApiProfile>().myAreaExists();
      return response.result.exists;
    } catch (e) {
      safePrint("exception: $e");
    }
    return false;
  }
}
