import 'dart:async';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'firebase_options.dart';

void main() async {
  setStatusBarColor();
  splashPreserve();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  KakaoSdk.init(nativeAppKey: "95626f081fe6f241fb0331dd8660fea0");

  await setPreferredOrientations();

  await getItSetup();

  runZonedGuarded(() async {
    runApp(const DingmoApp());
  }, (error, stack) {
    safePrint(stack);
    safePrint(error);
  });
}

void setStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      statusBarColor: Colors.white));
}

void splashPreserve() {
  return FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}
