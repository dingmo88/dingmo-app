// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_third_party.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSearchAddressRequest _$GetSearchAddressRequestFromJson(
        Map<String, dynamic> json) =>
    GetSearchAddressRequest(
      address: json['address'] as String,
    );

Map<String, dynamic> _$GetSearchAddressRequestToJson(
        GetSearchAddressRequest instance) =>
    <String, dynamic>{
      'address': instance.address,
    };

PostCertPersonRequest _$PostCertPersonRequestFromJson(
        Map<String, dynamic> json) =>
    PostCertPersonRequest(
      impUid: json['imp_uid'] as String,
    );

Map<String, dynamic> _$PostCertPersonRequestToJson(
        PostCertPersonRequest instance) =>
    <String, dynamic>{
      'imp_uid': instance.impUid,
    };

PostCertPersonResult _$PostCertPersonResultFromJson(
        Map<String, dynamic> json) =>
    PostCertPersonResult(
      phone: json['phone'] as String,
      name: json['name'] as String,
      birthDay: json['birthday'] as String,
    );

Map<String, dynamic> _$PostCertPersonResultToJson(
        PostCertPersonResult instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'name': instance.name,
      'birthday': instance.birthDay,
    };

PostCertCorpResult _$PostCertCorpResultFromJson(Map<String, dynamic> json) =>
    PostCertCorpResult(
      validated: json['validated'] as bool,
    );

Map<String, dynamic> _$PostCertCorpResultToJson(PostCertCorpResult instance) =>
    <String, dynamic>{
      'validated': instance.validated,
    };

PostCertCorpRequest _$PostCertCorpRequestFromJson(Map<String, dynamic> json) =>
    PostCertCorpRequest(
      bNo: json['b_no'] as String,
    );

Map<String, dynamic> _$PostCertCorpRequestToJson(
        PostCertCorpRequest instance) =>
    <String, dynamic>{
      'b_no': instance.bNo,
    };

PostCertCorpData _$PostCertCorpDataFromJson(Map<String, dynamic> json) =>
    PostCertCorpData(
      bNo: json['b_no'] as String,
      bStatus: json['b_stt'] as String,
      bStatusCode: json['b_stt_cd'] as String,
      taxType: json['tax_type'] as String,
      taxTypeCode: json['tax_type_cd'] as String,
      endDt: json['end_dt'] as String,
      utccYn: json['utcc_yn'] as String,
      taxTypeChangeDt: json['tax_type_change_dt'] as String,
      invoiceApplyDt: json['invoice_apply_dt'] as String,
    );

Map<String, dynamic> _$PostCertCorpDataToJson(PostCertCorpData instance) =>
    <String, dynamic>{
      'b_no': instance.bNo,
      'b_stt': instance.bStatus,
      'b_stt_cd': instance.bStatusCode,
      'tax_type': instance.taxType,
      'tax_type_cd': instance.taxTypeCode,
      'end_dt': instance.endDt,
      'utcc_yn': instance.utccYn,
      'tax_type_change_dt': instance.taxTypeChangeDt,
      'invoice_apply_dt': instance.invoiceApplyDt,
    };

GetSearchAddressInfo _$GetSearchAddressInfoFromJson(
        Map<String, dynamic> json) =>
    GetSearchAddressInfo(
      roadAddress: json['roadAddress'] as String,
      jibunAddress: json['jibunAddress'] as String,
      x: json['x'] as String,
      y: json['y'] as String,
    );

Map<String, dynamic> _$GetSearchAddressInfoToJson(
        GetSearchAddressInfo instance) =>
    <String, dynamic>{
      'roadAddress': instance.roadAddress,
      'jibunAddress': instance.jibunAddress,
      'x': instance.x,
      'y': instance.y,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiThirdParty implements ApiThirdParty {
  _ApiThirdParty(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<PostCertCorpResult>> certCorp(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<PostCertCorpResult>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/third-party/cert/corp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<PostCertCorpResult>.fromJson(
      _result.data!,
      (json) => PostCertCorpResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<PostCertPersonResult>> certPerson(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<PostCertPersonResult>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/third-party/cert/person',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<PostCertPersonResult>.fromJson(
      _result.data!,
      (json) => PostCertPersonResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetSearchAddressInfo>>> searchAddress(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetSearchAddressInfo>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/third-party/search/address',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetSearchAddressInfo>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetSearchAddressInfo>(
              (i) => GetSearchAddressInfo.fromJson(i as Map<String, dynamic>))
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
