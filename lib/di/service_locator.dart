import 'dart:convert';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_area.dart';
import 'package:dingmo/api/api_banner.dart';
import 'package:dingmo/api/api_bgm.dart';
import 'package:dingmo/api/api_block.dart';
import 'package:dingmo/api/api_bmk_folder.dart';
import 'package:dingmo/api/api_bmk_item.dart';
import 'package:dingmo/api/api_board.dart';
import 'package:dingmo/api/api_comment.dart';
import 'package:dingmo/api/api_content.dart';
import 'package:dingmo/api/api_coupon_comp.dart';
import 'package:dingmo/api/api_coupon_plan.dart';
import 'package:dingmo/api/api_exists.dart';
import 'package:dingmo/api/api_faq.dart';
import 'package:dingmo/api/api_follow.dart';
import 'package:dingmo/api/api_inquiry.dart';
import 'package:dingmo/api/api_like.dart';
import 'package:dingmo/api/api_notice.dart';
import 'package:dingmo/api/api_notification.dart';
import 'package:dingmo/api/api_point.dart';
import 'package:dingmo/api/api_profile.dart';
import 'package:dingmo/api/api_profile_comp.dart';
import 'package:dingmo/api/api_profile_plan.dart';
import 'package:dingmo/api/api_reply.dart';
import 'package:dingmo/api/api_search.dart';
import 'package:dingmo/api/api_setting.dart';
import 'package:dingmo/api/api_shorts.dart';
import 'package:dingmo/api/api_sign.dart';
import 'package:dingmo/api/api_third_party.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/third_party/aws_amplify.dart';
import 'package:dingmo/third_party/aws_s3_uploader.dart';
import 'package:dingmo/third_party/fcm_service.dart';
import 'package:dingmo/utils/auth_manager.dart';
import 'package:dingmo/utils/permission_manager.dart';
import 'package:dingmo/utils/reels_paging_manager.dart';
import 'package:dingmo/utils/media_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_video_info/flutter_video_info.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> getItSetup() async {
  // basic class
  getIt.registerSingleton(MediaUtil());
  getIt.registerSingleton(FlutterVideoInfo());
  getIt.registerSingleton(PermissionManager());
  getIt.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());

  // third party class
  getIt.registerSingleton(FcmService()..init());
  getIt.registerSingleton(AwsS3Uploader());

  await _initMemberInfo();

  getIt.registerSingleton(ReelsPagingManager());

  // api (contained third party api)
  await _setApis(await _getDio());

  getIt.registerSingleton(AwsAmplify());
  await getIt<AwsAmplify>().configure();

  getIt.registerSingleton(AuthManager());
}

Future<void> setMemberInfo(MemberInfo memberInfo) async {
  safePrint("debug! setMemberInfo ${json.encode(memberInfo.toJson())}");

  await getIt<FlutterSecureStorage>()
      .write(key: "member_info", value: json.encode(memberInfo.toJson()));
  await getIt.unregister<MemberInfo>();
  getIt.registerSingleton(MemberInfo(
      accessToken: memberInfo.accessToken,
      memberType: memberInfo.memberType,
      socialType: memberInfo.socialType));
}

Future<void> clearMemberInfo() async {
  await getIt<FlutterSecureStorage>().delete(key: "member_info");
  await getIt.unregister<MemberInfo>();
  getIt.registerSingleton(MemberInfo());
}

Future<void> _initMemberInfo() async {
  final memberInfoStr =
      await getIt<FlutterSecureStorage>().read(key: "member_info");

  if (memberInfoStr == null) {
    getIt.registerSingleton(MemberInfo());
  } else {
    final memberInfo = MemberInfo.fromJson(json.decode(memberInfoStr));

    getIt.registerSingleton(MemberInfo(
        accessToken: memberInfo.accessToken,
        memberType: memberInfo.memberType,
        socialType: memberInfo.socialType));
  }
}

Future<Dio> _getDio() async {
  safePrint("debug! _getDio accessToken: ${getIt<MemberInfo>().accessToken}");
  return Dio()
    ..options.headers['content-type'] = "application/json"
    ..options.headers['access-token'] = getIt<MemberInfo>().accessToken;
}

Future<void> resetApiAndAuth() async {
  safePrint("debug! resetApiAndAuth");
  await _unsetApis();
  await _setApis(await _getDio());

  await getIt.unregister<AuthManager>();
  getIt.registerSingleton(AuthManager());
}

Future<void> _setApis(Dio dio) async {
  safePrint("debug! _setApi dio accessToken: ${dio.options.headers}");

  getIt.registerSingleton(ApiArea(dio));
  getIt.registerSingleton(ApiBanner(dio));
  getIt.registerSingleton(ApiBgm(dio));
  getIt.registerSingleton(ApiBlock(dio));
  getIt.registerSingleton(ApiBmkFolder(dio));
  getIt.registerSingleton(ApiBmkItem(dio));
  getIt.registerSingleton(ApiBoard(dio));
  getIt.registerSingleton(ApiContent(dio));
  getIt.registerSingleton(ApiComment(dio));
  getIt.registerSingleton(ApiCouponComp(dio));
  getIt.registerSingleton(ApiCouponPlan(dio));
  getIt.registerSingleton(ApiExists(dio));
  getIt.registerSingleton(ApiFaq(dio));
  getIt.registerSingleton(ApiFollow(dio));
  getIt.registerSingleton(ApiInquiry(dio));
  getIt.registerSingleton(ApiLike(dio));
  getIt.registerSingleton(ApiNotice(dio));
  getIt.registerSingleton(ApiNotification(dio));
  getIt.registerSingleton(ApiPoint(dio));
  getIt.registerSingleton(ApiProfile(dio));
  getIt.registerSingleton(ApiProfileComp(dio));
  getIt.registerSingleton(ApiProfilePlan(dio));
  getIt.registerSingleton(ApiReply(dio));
  getIt.registerSingleton(ApiSearch(dio));
  getIt.registerSingleton(ApiSetting(dio));
  getIt.registerSingleton(ApiShorts(dio));
  getIt.registerSingleton(ApiSign(dio));
  getIt.registerSingleton(ApiThirdParty(dio));
}

Future<void> _unsetApis() async {
  await getIt.unregister<ApiArea>();
  await getIt.unregister<ApiBanner>();
  await getIt.unregister<ApiBgm>();
  await getIt.unregister<ApiBlock>();
  await getIt.unregister<ApiBmkFolder>();
  await getIt.unregister<ApiBmkItem>();
  await getIt.unregister<ApiBoard>();
  await getIt.unregister<ApiContent>();
  await getIt.unregister<ApiComment>();
  await getIt.unregister<ApiCouponComp>();
  await getIt.unregister<ApiCouponPlan>();
  await getIt.unregister<ApiExists>();
  await getIt.unregister<ApiFaq>();
  await getIt.unregister<ApiFollow>();
  await getIt.unregister<ApiInquiry>();
  await getIt.unregister<ApiLike>();
  await getIt.unregister<ApiNotice>();
  await getIt.unregister<ApiNotification>();
  await getIt.unregister<ApiPoint>();
  await getIt.unregister<ApiProfile>();
  await getIt.unregister<ApiProfileComp>();
  await getIt.unregister<ApiProfilePlan>();
  await getIt.unregister<ApiReply>();
  await getIt.unregister<ApiSearch>();
  await getIt.unregister<ApiSetting>();
  await getIt.unregister<ApiShorts>();
  await getIt.unregister<ApiSign>();
  await getIt.unregister<ApiThirdParty>();
}
