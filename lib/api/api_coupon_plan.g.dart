// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_coupon_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteCouponPlanRequest _$DeleteCouponPlanRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteCouponPlanRequest(
      couponId: json['pcpon_id'] as int,
    );

Map<String, dynamic> _$DeleteCouponPlanRequestToJson(
        DeleteCouponPlanRequest instance) =>
    <String, dynamic>{
      'pcpon_id': instance.couponId,
    };

GetCouponPlanResult _$GetCouponPlanResultFromJson(Map<String, dynamic> json) =>
    GetCouponPlanResult(
      json['pcpon_id'] as int,
      json['nick'] as String,
      DateTime.parse(json['exp_dt'] as String),
      json['discnt'] as int,
    );

Map<String, dynamic> _$GetCouponPlanResultToJson(
        GetCouponPlanResult instance) =>
    <String, dynamic>{
      'pcpon_id': instance.couponId,
      'nick': instance.nickname,
      'exp_dt': instance.expDt.toIso8601String(),
      'discnt': instance.discount,
    };

PostCouponPlanRequest _$PostCouponPlanRequestFromJson(
        Map<String, dynamic> json) =>
    PostCouponPlanRequest(
      cprofileId: json['pprofi_id'] as int,
      discntAmount: json['discnt_amount'] as int,
      regDt: DateTime.parse(json['reg_dt'] as String),
      expDt: DateTime.parse(json['exp_dt'] as String),
    );

Map<String, dynamic> _$PostCouponPlanRequestToJson(
        PostCouponPlanRequest instance) =>
    <String, dynamic>{
      'pprofi_id': instance.cprofileId,
      'discnt_amount': instance.discntAmount,
      'reg_dt': instance.regDt.toIso8601String(),
      'exp_dt': instance.expDt.toIso8601String(),
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiCouponPlan implements ApiCouponPlan {
  _ApiCouponPlan(
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
              '/coupon/plan',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<List<GetCouponPlanResult>>> getList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetCouponPlanResult>>>(Options(
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
    final value = ApiResponse<List<GetCouponPlanResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetCouponPlanResult>(
              (i) => GetCouponPlanResult.fromJson(i as Map<String, dynamic>))
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
              '/coupon/plan',
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
