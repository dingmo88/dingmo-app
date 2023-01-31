// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBannerResult _$GetBannerResultFromJson(Map<String, dynamic> json) =>
    GetBannerResult(
      bannId: json['bann_id'] as int,
      bannImgKey: json['bann_img_key'] as String,
    );

Map<String, dynamic> _$GetBannerResultToJson(GetBannerResult instance) =>
    <String, dynamic>{
      'bann_id': instance.bannId,
      'bann_img_key': instance.bannImgKey,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiBanner implements ApiBanner {
  _ApiBanner(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<List<GetBannerResult>>> getList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetBannerResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/banner/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetBannerResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetBannerResult>(
              (i) => GetBannerResult.fromJson(i as Map<String, dynamic>))
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
