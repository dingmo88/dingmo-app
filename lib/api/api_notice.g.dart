// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_notice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNoticeResult _$GetNoticeResultFromJson(Map<String, dynamic> json) =>
    GetNoticeResult(
      noticeId: json['notice_id'] as int,
      content: json['notice_content'] as String,
    );

Map<String, dynamic> _$GetNoticeResultToJson(GetNoticeResult instance) =>
    <String, dynamic>{
      'notice_id': instance.noticeId,
      'notice_content': instance.content,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiNotice implements ApiNotice {
  _ApiNotice(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<List<GetNoticeResult>>> getList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetNoticeResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/notice/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetNoticeResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetNoticeResult>(
              (i) => GetNoticeResult.fromJson(i as Map<String, dynamic>))
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
