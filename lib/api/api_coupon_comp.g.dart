// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_coupon_comp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteCouponCompRequest _$DeleteCouponCompRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteCouponCompRequest(
      couponId: json['ccpon_id'] as int,
    );

Map<String, dynamic> _$DeleteCouponCompRequestToJson(
        DeleteCouponCompRequest instance) =>
    <String, dynamic>{
      'ccpon_id': instance.couponId,
    };

GetCouponCompResult _$GetCouponCompResultFromJson(Map<String, dynamic> json) =>
    GetCouponCompResult(
      json['ccpon_id'] as int,
      json['nick'] as String,
      DateTime.parse(json['exp_dt'] as String),
      json['discnt'] as int,
    );

Map<String, dynamic> _$GetCouponCompResultToJson(
        GetCouponCompResult instance) =>
    <String, dynamic>{
      'ccpon_id': instance.couponId,
      'nick': instance.nickname,
      'exp_dt': instance.expDt.toIso8601String(),
      'discnt': instance.discount,
    };

PostCouponCompRequest _$PostCouponCompRequestFromJson(
        Map<String, dynamic> json) =>
    PostCouponCompRequest(
      cprofileId: json['cprofi_id'] as int,
      discntAmount: json['discnt_amount'] as int,
      regDt: DateTime.parse(json['reg_dt'] as String),
      expDt: DateTime.parse(json['exp_dt'] as String),
    );

Map<String, dynamic> _$PostCouponCompRequestToJson(
        PostCouponCompRequest instance) =>
    <String, dynamic>{
      'cprofi_id': instance.cprofileId,
      'discnt_amount': instance.discntAmount,
      'reg_dt': instance.regDt.toIso8601String(),
      'exp_dt': instance.expDt.toIso8601String(),
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiCouponComp implements ApiCouponComp {
  _ApiCouponComp(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiBlankResponse> create(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiBlankResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/coupon/comp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<List<GetCouponCompResult>>> getList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetCouponCompResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/coupon/comp/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetCouponCompResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetCouponCompResult>(
              (i) => GetCouponCompResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiBlankResponse> delete(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiBlankResponse>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/coupon/comp',
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
