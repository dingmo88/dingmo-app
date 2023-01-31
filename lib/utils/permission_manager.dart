import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<bool> isAllChecked() async {
    return await Permission.camera.isGranted &&
        await Permission.microphone.isGranted &&
        await Permission.storage.isGranted;
  }

  Future<bool> checkAll() async {
    final List<Permission> permissions = [];
    bool isFail = false;
    String failAuthName = "";

    if (!await Permission.camera.isGranted) {
      permissions.add(Permission.camera);
    }
    if (!await Permission.microphone.isGranted) {
      permissions.add(Permission.microphone);
    }
    if (!await Permission.storage.isGranted) {
      permissions.add(Permission.storage);
    }

    if (permissions.isNotEmpty) {
      await permissions.request();

      if (!await Permission.camera.isGranted) {
        isFail = true;
        failAuthName = "카메라/마이크";
      }
      if (!await Permission.microphone.isGranted) {
        permissions.add(Permission.microphone);
        isFail = true;
        failAuthName = "카메라/마이크";
      }
      if (!await Permission.storage.isGranted) {
        permissions.add(Permission.storage);
        isFail = true;
        failAuthName = "저장소";
      }
    }
    if (isFail) {
      Fluttertoast.showToast(msg: "$failAuthName 권한이 필요합니다.");
      Future.delayed(const Duration(seconds: 1), () {
        openAppSettings();
      });
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkCamera() async {
    final List<Permission> permissions = [];
    bool isFail = false;
    String failAuthName = "";

    if (!await Permission.camera.isGranted) {
      permissions.add(Permission.camera);
    }
    if (!await Permission.microphone.isGranted) {
      permissions.add(Permission.microphone);
    }

    if (permissions.isNotEmpty) {
      await permissions.request();

      if (!await Permission.camera.isGranted) {
        isFail = true;
        failAuthName = "카메라/마이크";
      }
      if (!await Permission.microphone.isGranted) {
        permissions.add(Permission.microphone);
        isFail = true;
        failAuthName = "카메라/마이크";
      }
    }
    if (isFail) {
      Fluttertoast.showToast(msg: "$failAuthName 권한이 필요합니다.");
      Future.delayed(const Duration(seconds: 1), () {
        openAppSettings();
      });
      return false;
    } else {
      return true;
    }
  }
}
