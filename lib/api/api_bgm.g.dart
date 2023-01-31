// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_bgm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBgmResult _$GetBgmResultFromJson(Map<String, dynamic> json) => GetBgmResult(
      bgmId: json['bgm_id'] as int,
      bgmImgKey: json['bgm_img_key'] as String,
    );

Map<String, dynamic> _$GetBgmResultToJson(GetBgmResult instance) =>
    <String, dynamic>{
      'bgm_id': instance.bgmId,
      'bgm_img_key': instance.bgmImgKey,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiBgm implements ApiBgm {
  _ApiBgm(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<List<GetBgmResult>>> getAreaFirstList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetBgmResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/bgm/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetBgmResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetBgmResult>(
              (i) => GetBgmResult.fromJson(i as Map<String, dynamic>))
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
