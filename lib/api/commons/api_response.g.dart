// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiBlankResponse _$ApiBlankResponseFromJson(Map<String, dynamic> json) =>
    ApiBlankResponse(
      json['code'] as int,
      json['message'] as String,
      BlankResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ApiBlankResponseToJson(ApiBlankResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };

BlankResult _$BlankResultFromJson(Map<String, dynamic> json) => BlankResult();

Map<String, dynamic> _$BlankResultToJson(BlankResult instance) =>
    <String, dynamic>{};

ApiResponse<Result> _$ApiResponseFromJson<Result>(
  Map<String, dynamic> json,
  Result Function(Object? json) fromJsonResult,
) =>
    ApiResponse<Result>(
      json['code'] as int,
      json['message'] as String,
      fromJsonResult(json['result']),
    );

Map<String, dynamic> _$ApiResponseToJson<Result>(
  ApiResponse<Result> instance,
  Object? Function(Result value) toJsonResult,
) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': toJsonResult(instance.result),
    };

ApiErrorResponse _$ApiErrorResponseFromJson(Map<String, dynamic> json) =>
    ApiErrorResponse(
      json['code'] as int,
      json['error'] as String,
      json['message'] as String,
    );

Map<String, dynamic> _$ApiErrorResponseToJson(ApiErrorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'error': instance.error,
      'message': instance.message,
    };
