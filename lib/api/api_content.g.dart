// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetContentThumbRequest _$GetContentThumbRequestFromJson(
        Map<String, dynamic> json) =>
    GetContentThumbRequest(
      profileId: json['profile_id'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$GetContentThumbRequestToJson(
        GetContentThumbRequest instance) =>
    <String, dynamic>{
      'profile_id': instance.profileId,
      'page': instance.page,
      'size': instance.size,
    };

GetContentThumbResult _$GetContentThumbResultFromJson(
        Map<String, dynamic> json) =>
    GetContentThumbResult(
      json['ct_id'] as int,
      json['ct_type'] as int,
      json['thumb_key'] as String,
      json['view_cnt'] as int,
    );

Map<String, dynamic> _$GetContentThumbResultToJson(
        GetContentThumbResult instance) =>
    <String, dynamic>{
      'ct_id': instance.contentId,
      'ct_type': instance.contentType,
      'thumb_key': instance.thumbKey,
      'view_cnt': instance.viewCnt,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiContent implements ApiContent {
  _ApiContent(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<List<GetContentThumbResult>>> getThumbnails(
      request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetContentThumbResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/content/thumbnails',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetContentThumbResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetContentThumbResult>(
              (i) => GetContentThumbResult.fromJson(i as Map<String, dynamic>))
          .toList(),
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
