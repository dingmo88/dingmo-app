import 'package:dingmo/ui/main/mypage/widgets/mypage_divider.dart';
import 'package:dingmo/ui/main/mypage/widgets/mypage_switch.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:flutter/material.dart';

class MyNotiSettingsPage extends StatefulWidget {
  const MyNotiSettingsPage({Key? key}) : super(key: key);

  @override
  State<MyNotiSettingsPage> createState() => _MyNotiSettingsPageState();
}

class _MyNotiSettingsPageState extends State<MyNotiSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "알림 설정"),
      body: Column(children: const [
        MyPageSwitch(name: "내 게시물 댓글 알림", isOn: true),
        MyPageDivider(),
        MyPageSwitch(name: "내 게시물 좋아요 알림", isOn: false),
        MyPageDivider(),
        MyPageSwitch(name: "문의 메시지 알림", isOn: false),
        MyPageDivider(),
        MyPageSwitch(name: "이벤트 및 혜택 푸시 알림", isOn: false),
        MyPageSwitch(name: "언급 알림", isOn: false),
      ]),
    );
  }
}
