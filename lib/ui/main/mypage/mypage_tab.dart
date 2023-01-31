import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/main/mypage/guest_mypage_tab.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:flutter/material.dart';

import 'comp_mypage_tab.dart';
import 'plan_mypage_tab.dart';
import 'user_mypage_tab.dart';

class MypageTab extends StatefulWidget {
  const MypageTab({Key? key}) : super(key: key);

  @override
  State<MypageTab> createState() => _MypageTabState();
}

class _MypageTabState extends State<MypageTab> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getIt<AuthManager>().authState,
        builder: (context, snapshot) {
          final authState = snapshot.data ?? _getCurrentAuthState();
          safePrint("debug! authState: $authState");

          if (authState == AuthState.loggedIn) {
            final memberType = getIt<MemberInfo>().memberType;
            safePrint("debug! memberType: $memberType");

            if (memberType == MemberType.comp) {
              return const CompMypageTab();
            } else if (memberType == MemberType.plan) {
              return const PlanMypageTab();
            } else if (memberType == MemberType.user) {
              return const UserMypageTab();
            } else {
              return const GuestMypageTab();
            }
          } else {
            return const GuestMypageTab();
          }
        });
  }

  AuthState _getCurrentAuthState() {
    final isLoggedIn = getIt<MemberInfo>().accessToken != null;
    return isLoggedIn ? AuthState.loggedIn : AuthState.guest;
  }
}
