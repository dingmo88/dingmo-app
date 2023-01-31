// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_sign.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLoginResult _$PostLoginResultFromJson(Map<String, dynamic> json) =>
    PostLoginResult(
      memberType: json['member_type'] as int,
      socialType: json['social_type'] as int,
      accessToken: json['access_token'] as String,
    );

Map<String, dynamic> _$PostLoginResultToJson(PostLoginResult instance) =>
    <String, dynamic>{
      'social_type': instance.socialType,
      'member_type': instance.memberType,
      'access_token': instance.accessToken,
    };

PostLoginRequest _$PostLoginRequestFromJson(Map<String, dynamic> json) =>
    PostLoginRequest(
      ampUid: json['amp_uid'] as String,
    );

Map<String, dynamic> _$PostLoginRequestToJson(PostLoginRequest instance) =>
    <String, dynamic>{
      'amp_uid': instance.ampUid,
    };

PostCompSignUpRequest _$PostCompSignUpRequestFromJson(
        Map<String, dynamic> json) =>
    PostCompSignUpRequest(
      ampUid: json['amp_uid'] as String,
      socialType: json['social_type'] as int,
      email: json['email'] as String,
      comRegNum: json['comp_reg_num'] as String,
      compType: json['comp_type'] as int,
      corpName: json['corp_name'] as String,
      ceoName: json['ceo_name'] as String,
      nickname: json['nickname'] as String,
      address: json['addr'] as String,
      addressDetails: json['addr_details'] as String,
      addrX: json['addr_x'] as String,
      addrY: json['addr_y'] as String,
      notiEvent: json['noti_event'] as bool,
    );

Map<String, dynamic> _$PostCompSignUpRequestToJson(
        PostCompSignUpRequest instance) =>
    <String, dynamic>{
      'amp_uid': instance.ampUid,
      'social_type': instance.socialType,
      'email': instance.email,
      'comp_reg_num': instance.comRegNum,
      'comp_type': instance.compType,
      'corp_name': instance.corpName,
      'ceo_name': instance.ceoName,
      'nickname': instance.nickname,
      'addr': instance.address,
      'addr_details': instance.addressDetails,
      'addr_x': instance.addrX,
      'addr_y': instance.addrY,
      'noti_event': instance.notiEvent,
    };

PostPlanSignUpRequest _$PostPlanSignUpRequestFromJson(
        Map<String, dynamic> json) =>
    PostPlanSignUpRequest(
      ampUid: json['amp_uid'] as String,
      socialType: json['social_type'] as int,
      email: json['email'] as String,
      teamName: json['team_name'] as String?,
      phone: json['phone'] as String?,
      name: json['name'] as String?,
      nickname: json['nickname'] as String?,
      birth: json['birth'] as String,
      notiEvent: json['noti_event'] as bool,
    );

Map<String, dynamic> _$PostPlanSignUpRequestToJson(
        PostPlanSignUpRequest instance) =>
    <String, dynamic>{
      'amp_uid': instance.ampUid,
      'social_type': instance.socialType,
      'email': instance.email,
      'team_name': instance.teamName,
      'phone': instance.phone,
      'name': instance.name,
      'nickname': instance.nickname,
      'birth': instance.birth,
      'noti_event': instance.notiEvent,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiSign implements ApiSign {
  _ApiSign(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiBlankResponse> signUpComp(request) async {
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
              '/sign/sign-up/comp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiBlankResponse> signUpPlan(request) async {
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
              '/sign/sign-up/plan',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<PostLoginResult>> login(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<PostLoginResult>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/sign/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<PostLoginResult>.fromJson(
      _result.data!,
      (json) => PostLoginResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiBlankResponse> resign() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiBlankResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/sign/resign',
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
