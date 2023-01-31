import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'widgets/disabled_myinfo_form.dart';

class UserMyInfoPage extends StatefulWidget {
  const UserMyInfoPage({Key? key}) : super(key: key);

  @override
  State<UserMyInfoPage> createState() => _UserMyInfoPageState();
}

class _UserMyInfoPageState extends State<UserMyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "내 정보"),
      body: SingleChildScrollView(
          reverse: true,
          child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "로그인 계정",
                    style: TextStyle(
                        fontSize: 13,
                        color: AppColors.greyishBrown,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/mypage/kakaologin_icon.svg"),
                      const SizedBox(width: 5),
                      Text(
                        "dingmo@gmail.com",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.purpleGrey),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  const DisabledMyInfoFormWidget(name: "비밀번호", content: ""),
                ],
              ))),
    );
  }
}
