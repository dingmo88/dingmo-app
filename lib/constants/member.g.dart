// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberInfo _$MemberInfoFromJson(Map<String, dynamic> json) => MemberInfo(
      accessToken: json['accessToken'] as String?,
      memberType: $enumDecodeNullable(_$MemberTypeEnumMap, json['memberType']),
      socialType: $enumDecodeNullable(_$SocialTypeEnumMap, json['socialType']),
    );

Map<String, dynamic> _$MemberInfoToJson(MemberInfo instance) =>
    <String, dynamic>{
      'accessToken': instance.accessToken,
      'memberType': _$MemberTypeEnumMap[instance.memberType],
      'socialType': _$SocialTypeEnumMap[instance.socialType],
    };

const _$MemberTypeEnumMap = {
  MemberType.comp: 'comp',
  MemberType.plan: 'plan',
  MemberType.user: 'user',
};

const _$SocialTypeEnumMap = {
  SocialType.kakao: 'kakao',
  SocialType.apple: 'apple',
  SocialType.email: 'email',
};
