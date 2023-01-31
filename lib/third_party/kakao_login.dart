import 'dart:convert';

import 'package:amplify_core/amplify_core.dart';
import 'package:crypto/crypto.dart';
import 'package:dingmo/third_party/aws_amplify.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

class KakaoUser {
  final User _userData;

  KakaoUser(this._userData);

  User get userData => _userData;

  AuthCredentials? getCredentials() {
    if (_userData.kakaoAccount?.email == null) {
      return null;
    }

    final key = utf8.encode(
        "BjWOUU2xDzoA7Z2AE=!cYUiA??tGqJK?!WicSMJH5jMm8g69MbgWv7c2=M10gnin4SCJ?ikNbHqlZVjoFzWEGTzVSJHii3?FE-yE/peQcjYH3NOjaYHgvv3lpVChZF5/PeX-!wwWcU66WQTlg7bp/=ea4UU5eX=XV-vQoKTCGJs0u3=8Z?TKX7TFYns!-towucYwz3-/RNGu/ZoTh!uvGNkEauSiUP6HsxxHUjopepOUrr=U8LEF8N9spanFbyq6");

    final bytes = utf8.encode(_userData.id.toString());
    final password = Hmac(sha256, key).convert(bytes);

    return AuthCredentials(
        email: _userData.kakaoAccount!.email!, password: password.toString());
  }
}
