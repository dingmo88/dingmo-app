// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotificationResult _$GetNotificationResultFromJson(
        Map<String, dynamic> json) =>
    GetNotificationResult(
      json['noti_id'] as int,
      json['noti_type'] as int,
      json['noti_msg'] as String,
      DateTime.parse(json['noti_dt'] as String),
    );

Map<String, dynamic> _$GetNotificationResultToJson(
        GetNotificationResult instance) =>
    <String, dynamic>{
      'noti_id': instance.notiId,
      'noti_type': instance.notiType,
      'noti_msg': instance.message,
      'noti_dt': instance.createdDt.toIso8601String(),
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiNotification implements ApiNotification {
  _ApiNotification(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<List<GetNotificationResult>>> getList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetNotificationResult>>>(Options(
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
    final value = ApiResponse<List<GetNotificationResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetNotificationResult>(
              (i) => GetNotificationResult.fromJson(i as Map<String, dynamic>))
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
