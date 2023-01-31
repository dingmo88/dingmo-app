import 'package:json_annotation/json_annotation.dart';

import 'social_type.dart';

part 'member.g.dart';

enum MemberType { comp, plan, user }

int memberTypeToValue(MemberType memberType) {
  switch (memberType) {
    case MemberType.user:
      return 1;
    case MemberType.plan:
      return 2;
    case MemberType.comp:
      return 3;
  }
}

String memberTypeToString(MemberType memberType) {
  switch (memberType) {
    case MemberType.user:
      return "예비신랑신부";
    case MemberType.plan:
      return "웨딩플래너";
    case MemberType.comp:
      return "";
  }
}

MemberType? valueToMemberType(int value) {
  switch (value) {
    case 1:
      return MemberType.user;
    case 2:
      return MemberType.plan;
    case 3:
      return MemberType.comp;
    default:
      return null;
  }
}

@JsonSerializable()
class MemberInfo {
  final String? accessToken;
  final MemberType? memberType;
  final SocialType? socialType;

  MemberInfo({this.accessToken, this.memberType, this.socialType});

  factory MemberInfo.fromJson(Map<String, dynamic> json) =>
      _$MemberInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MemberInfoToJson(this);

  bool isGuest() => accessToken == null;
}
