import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DarkStatusBarWidget extends StatelessWidget {
  final bool isLightIcon;
  final Widget child;
  const DarkStatusBarWidget(
      {Key? key, this.isLightIcon = false, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    settingStatusBar();
    return child;
  }

  void settingStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(isLightIcon
        ? const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.dark)
        : const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.black,
            systemNavigationBarIconBrightness: Brightness.dark));
  }
}
