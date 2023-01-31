// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMyAreaExistsResult _$GetMyAreaExistsResultFromJson(
        Map<String, dynamic> json) =>
    GetMyAreaExistsResult(
      json['exists'] as bool,
    );

Map<String, dynamic> _$GetMyAreaExistsResultToJson(
        GetMyAreaExistsResult instance) =>
    <String, dynamic>{
      'exists': instance.exists,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiProfile implements ApiProfile {
  _ApiProfile(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<GetMyAreaExistsResult>> myAreaExists() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetMyAreaExistsResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/profile/my-area/exists',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetMyAreaExistsResult>.fromJson(
      _result.data!,
      (json) => GetMyAreaExistsResult.fromJson(json as Map<String, dynamic>),
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
