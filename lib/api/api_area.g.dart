// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_area.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAreaSecondRequest _$GetAreaSecondRequestFromJson(
        Map<String, dynamic> json) =>
    GetAreaSecondRequest(
      area1Id: json['area1_id'] as int,
    );

Map<String, dynamic> _$GetAreaSecondRequestToJson(
        GetAreaSecondRequest instance) =>
    <String, dynamic>{
      'area1_id': instance.area1Id,
    };

GetAreaResult _$GetAreaResultFromJson(Map<String, dynamic> json) =>
    GetAreaResult(
      areaId: json['area_id'] as int,
      areaName: json['area_name'] as String,
    );

Map<String, dynamic> _$GetAreaResultToJson(GetAreaResult instance) =>
    <String, dynamic>{
      'area_id': instance.areaId,
      'area_name': instance.areaName,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiArea implements ApiArea {
  _ApiArea(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<List<GetAreaResult>>> getAreaFirstList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetAreaResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/area/first/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetAreaResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetAreaResult>(
              (i) => GetAreaResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetAreaResult>>> getAreaSecondList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetAreaResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/area/second/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetAreaResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetAreaResult>(
              (i) => GetAreaResult.fromJson(i as Map<String, dynamic>))
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
