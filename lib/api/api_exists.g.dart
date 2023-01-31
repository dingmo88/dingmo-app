// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_exists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostEmailExistsRequest _$PostEmailExistsRequestFromJson(
        Map<String, dynamic> json) =>
    PostEmailExistsRequest(
      email: json['email'] as String,
    );

Map<String, dynamic> _$PostEmailExistsRequestToJson(
        PostEmailExistsRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

PostNicknameExistsRequest _$PostNicknameExistsRequestFromJson(
        Map<String, dynamic> json) =>
    PostNicknameExistsRequest(
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$PostNicknameExistsRequestToJson(
        PostNicknameExistsRequest instance) =>
    <String, dynamic>{
      'nickname': instance.nickname,
    };

PostEmailExistsResult _$PostEmailExistsResultFromJson(
        Map<String, dynamic> json) =>
    PostEmailExistsResult(
      exists: json['exists'] as bool,
      socialType: json['social_type'] as int,
    );

Map<String, dynamic> _$PostEmailExistsResultToJson(
        PostEmailExistsResult instance) =>
    <String, dynamic>{
      'exists': instance.exists,
      'social_type': instance.socialType,
    };

PostNicknameExistsResult _$PostNicknameExistsResultFromJson(
        Map<String, dynamic> json) =>
    PostNicknameExistsResult(
      exists: json['exists'] as bool,
    );

Map<String, dynamic> _$PostNicknameExistsResultToJson(
        PostNicknameExistsResult instance) =>
    <String, dynamic>{
      'exists': instance.exists,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiExists implements ApiExists {
  _ApiExists(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<PostEmailExistsResult>> email(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<PostEmailExistsResult>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/exists/email',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<PostEmailExistsResult>.fromJson(
      _result.data!,
      (json) => PostEmailExistsResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<PostNicknameExistsResult>> nickname(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<PostNicknameExistsResult>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/exists/nickname',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<PostNicknameExistsResult>.fromJson(
      _result.data!,
      (json) => PostNicknameExistsResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
