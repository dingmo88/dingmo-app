import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LightStatusBarWidget extends StatelessWidget {
  final bool isLightIcon;
  final Widget child;
  const LightStatusBarWidget(
      {Key? key, this.isLightIcon = false, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // settingStatusBar();
    return AnnotatedRegion(
        value: isLightIcon
            ? const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark)
            : const SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark,
                statusBarColor: Colors.transparent,
                systemNavigationBarColor: Colors.white,
                systemNavigationBarIconBrightness: Brightness.dark),
        child: child);
  }

  void settingStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(isLightIcon
        ? const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light,
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark)
        : const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark));
  }
}
