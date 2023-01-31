import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/main/mypage/widgets/mypage_menu.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:flutter/material.dart';

import 'widgets/mypage_divider.dart';

class TermsAndPoliciesPage extends StatelessWidget {
  const TermsAndPoliciesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "약관 및 정책"),
      body: Column(children: [
        MyPageMenu(
            name: "서비스 이용약관",
            onPressed: () => Navigator.pushNamed(context, Routes.termsOfUse)),
        const MyPageDivider(),
        MyPageMenu(
            name: "개인정보 처리방침",
            onPressed: () =>
                Navigator.pushNamed(context, Routes.privacyPolicy)),
        const MyPageDivider(),
        // MyPageMenu(
        //     name: "마케팅 수신동의",
        //     onPressed: () => Fluttertoast.showToast(msg: "마케팅 수신동의")),
      ]),
    );
  }
}
