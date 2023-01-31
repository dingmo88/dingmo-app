// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_point.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPointResult _$GetPointResultFromJson(Map<String, dynamic> json) =>
    GetPointResult(
      json['pt_id'] as int,
      json['pt_amount'] as int,
      json['pt_type'] as int,
    );

Map<String, dynamic> _$GetPointResultToJson(GetPointResult instance) =>
    <String, dynamic>{
      'pt_id': instance.pointId,
      'pt_amount': instance.amount,
      'pt_type': instance.type,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiPoint implements ApiPoint {
  _ApiPoint(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<List<GetPointResult>>> getList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetPointResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/point/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetPointResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetPointResult>(
              (i) => GetPointResult.fromJson(i as Map<String, dynamic>))
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
