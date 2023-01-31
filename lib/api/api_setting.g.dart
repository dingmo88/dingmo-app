// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchSettingRequest _$PatchSettingRequestFromJson(Map<String, dynamic> json) =>
    PatchSettingRequest(
      json['noti_cmt'] as bool?,
      json['noti_lik'] as bool?,
      json['noti_inq'] as bool?,
      json['noti_mention'] as bool?,
      json['noti_push'] as bool?,
    );

Map<String, dynamic> _$PatchSettingRequestToJson(
        PatchSettingRequest instance) =>
    <String, dynamic>{
      'noti_cmt': instance.notiCmt,
      'noti_lik': instance.notiLike,
      'noti_inq': instance.notiInquiry,
      'noti_mention': instance.notiMention,
      'noti_push': instance.notiPush,
    };

GetSettingResult _$GetSettingResultFromJson(Map<String, dynamic> json) =>
    GetSettingResult(
      json['noti_cmt'] as bool,
      json['noti_lik'] as bool,
      json['noti_inq'] as bool,
      json['noti_mention'] as bool,
      json['noti_push'] as bool,
    );

Map<String, dynamic> _$GetSettingResultToJson(GetSettingResult instance) =>
    <String, dynamic>{
      'noti_cmt': instance.notiCmt,
      'noti_lik': instance.notiLike,
      'noti_inq': instance.notiInquiry,
      'noti_mention': instance.notiMention,
      'noti_push': instance.notiPush,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiSetting implements ApiSetting {
  _ApiSetting(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<GetSettingResult>> get() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetSettingResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/setting',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetSettingResult>.fromJson(
      _result.data!,
      (json) => GetSettingResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiBlankResponse> update(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiBlankResponse>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/setting',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
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
