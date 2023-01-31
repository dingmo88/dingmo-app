// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageRequest _$PageRequestFromJson(Map<String, dynamic> json) => PageRequest(
      size: json['size'] as int? ?? 10,
      page: json['page'] as int? ?? 1,
    );

Map<String, dynamic> _$PageRequestToJson(PageRequest instance) =>
    <String, dynamic>{
      'size': instance.size,
      'page': instance.page,
    };
