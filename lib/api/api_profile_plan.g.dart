// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_profile_plan.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PatchPlanMyinfoRequest _$PatchPlanMyinfoRequestFromJson(
        Map<String, dynamic> json) =>
    PatchPlanMyinfoRequest(
      teamName: json['team_name'] as String?,
      personal: json['personal'] == null
          ? null
          : PlanMyinfoPersonal.fromJson(
              json['personal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatchPlanMyinfoRequestToJson(
        PatchPlanMyinfoRequest instance) =>
    <String, dynamic>{
      'team_name': instance.teamName,
      'personal': instance.personal,
    };

GetPlanMyinfoResult _$GetPlanMyinfoResultFromJson(Map<String, dynamic> json) =>
    GetPlanMyinfoResult(
      json['email'] as String,
      json['phone'] as String,
      json['team_name'] as String?,
    );

Map<String, dynamic> _$GetPlanMyinfoResultToJson(
        GetPlanMyinfoResult instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'team_name': instance.teamName,
    };

PatchPlanProfileRequest _$PatchPlanProfileRequestFromJson(
        Map<String, dynamic> json) =>
    PatchPlanProfileRequest(
      formKey: json['form_key'] as String,
    )
      ..profiImgKey = json['profi_img_key'] as String?
      ..nickname = json['nickname'] as String?
      ..consultAllow = json['consult_allow'] as bool?
      ..area = json['area'] == null
          ? null
          : PatchPlanProfileArea.fromJson(json['area'] as Map<String, dynamic>)
      ..intro = json['intro'] as String?
      ..consultDays = (json['consult_days'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..consultOpenTime = json['consult_open_time'] as String?
      ..consultCloseTime = json['consult_close_time'] as String?;

Map<String, dynamic> _$PatchPlanProfileRequestToJson(
        PatchPlanProfileRequest instance) =>
    <String, dynamic>{
      'form_key': instance.formKey,
      'profi_img_key': instance.profiImgKey,
      'nickname': instance.nickname,
      'consult_allow': instance.consultAllow,
      'area': instance.area,
      'intro': instance.intro,
      'consult_days': instance.consultDays,
      'consult_open_time': instance.consultOpenTime,
      'consult_close_time': instance.consultCloseTime,
    };

GetPlanProfileRequest _$GetPlanProfileRequestFromJson(
        Map<String, dynamic> json) =>
    GetPlanProfileRequest(
      profileId: json['profile_id'] as int,
    );

Map<String, dynamic> _$GetPlanProfileRequestToJson(
        GetPlanProfileRequest instance) =>
    <String, dynamic>{
      'profile_id': instance.profileId,
    };

GetPlanProfileFormResult _$GetPlanProfileFormResultFromJson(
        Map<String, dynamic> json) =>
    GetPlanProfileFormResult(
      formKey: json['form_key'] as String,
      profiImgKey: json['profi_img_key'] as String?,
      nickname: json['nickname'] as String,
      consultAllow: json['consult_allow'] as bool,
      area: json['area'] == null
          ? null
          : GetPlanProfileArea.fromJson(json['area'] as Map<String, dynamic>),
      intro: json['intro'] as String?,
      consultDays: (json['consult_days'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      consultOpenTime: json['consult_open_time'] as String?,
      consultCloseTime: json['consult_close_time'] as String?,
    );

Map<String, dynamic> _$GetPlanProfileFormResultToJson(
        GetPlanProfileFormResult instance) =>
    <String, dynamic>{
      'form_key': instance.formKey,
      'profi_img_key': instance.profiImgKey,
      'nickname': instance.nickname,
      'consult_allow': instance.consultAllow,
      'area': instance.area,
      'intro': instance.intro,
      'consult_days': instance.consultDays,
      'consult_open_time': instance.consultOpenTime,
      'consult_close_time': instance.consultCloseTime,
    };

GetPlanMypageResult _$GetPlanMypageResultFromJson(Map<String, dynamic> json) =>
    GetPlanMypageResult(
      json['profile_id'] as int,
      json['profi_img_key'] as String?,
      json['nickname'] as String,
      json['consult_allow'] as bool,
    );

Map<String, dynamic> _$GetPlanMypageResultToJson(
        GetPlanMypageResult instance) =>
    <String, dynamic>{
      'profile_id': instance.profileId,
      'profi_img_key': instance.profileImgKey,
      'nickname': instance.nickname,
      'consult_allow': instance.consultAllow,
    };

GetPlanProfileResult _$GetPlanProfileResultFromJson(
        Map<String, dynamic> json) =>
    GetPlanProfileResult(
      json['is_mine'] as bool,
      json['profi_id'] as int,
      json['pprofi_id'] as int,
      json['profi_img_key'] as String?,
      json['nickname'] as String,
      json['intro'] as String?,
      json['active_area'] as String?,
      json['consult_allow'] as bool,
      (json['consult_days'] as List<dynamic>).map((e) => e as String).toList(),
      json['consult_open_time'] as String?,
      json['consult_close_time'] as String?,
      (json['ct_thumbs'] as List<dynamic>)
          .map((e) =>
              PlanProfileContentThumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetPlanProfileResultToJson(
        GetPlanProfileResult instance) =>
    <String, dynamic>{
      'is_mine': instance.isMine,
      'profi_id': instance.profileId,
      'pprofi_id': instance.pprofileId,
      'profi_img_key': instance.profileImgKey,
      'nickname': instance.nickname,
      'intro': instance.intro,
      'active_area': instance.activeArea,
      'consult_allow': instance.consultAllow,
      'consult_days': instance.consultDays,
      'consult_open_time': instance.consultOpenTime,
      'consult_close_time': instance.consultCloseTime,
      'ct_thumbs': instance.thumbnails,
    };

PlanProfileContentThumbnail _$PlanProfileContentThumbnailFromJson(
        Map<String, dynamic> json) =>
    PlanProfileContentThumbnail(
      contentId: json['ct_id'] as int,
      contentType: json['ct_type'] as int,
      thumbKey: json['thumb_key'] as String,
      viewCnt: json['view_cnt'] as int,
    );

Map<String, dynamic> _$PlanProfileContentThumbnailToJson(
        PlanProfileContentThumbnail instance) =>
    <String, dynamic>{
      'ct_id': instance.contentId,
      'ct_type': instance.contentType,
      'thumb_key': instance.thumbKey,
      'view_cnt': instance.viewCnt,
    };

PlanMyinfoPersonal _$PlanMyinfoPersonalFromJson(Map<String, dynamic> json) =>
    PlanMyinfoPersonal(
      json['phone'] as String,
      json['name'] as String,
      json['birth'] as String,
    );

Map<String, dynamic> _$PlanMyinfoPersonalToJson(PlanMyinfoPersonal instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'name': instance.name,
      'birth': instance.birth,
    };

GetPlanProfileArea _$GetPlanProfileAreaFromJson(Map<String, dynamic> json) =>
    GetPlanProfileArea(
      area1Id: json['area1_id'] as int,
      area2Id: json['area2_id'] as int,
      area1Name: json['area1_name'] as String,
      area2Name: json['area2_name'] as String,
    );

Map<String, dynamic> _$GetPlanProfileAreaToJson(GetPlanProfileArea instance) =>
    <String, dynamic>{
      'area1_id': instance.area1Id,
      'area2_id': instance.area2Id,
      'area1_name': instance.area1Name,
      'area2_name': instance.area2Name,
    };

PatchPlanProfileArea _$PatchPlanProfileAreaFromJson(
        Map<String, dynamic> json) =>
    PatchPlanProfileArea(
      area1Id: json['area1_id'] as int,
      area2Id: json['area2_id'] as int,
    );

Map<String, dynamic> _$PatchPlanProfileAreaToJson(
        PatchPlanProfileArea instance) =>
    <String, dynamic>{
      'area1_id': instance.area1Id,
      'area2_id': instance.area2Id,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiProfilePlan implements ApiProfilePlan {
  _ApiProfilePlan(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<GetPlanMypageResult>> mypage() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetPlanMypageResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/profile/mypage',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetPlanMypageResult>.fromJson(
      _result.data!,
      (json) => GetPlanMypageResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<GetPlanMyinfoResult>> getMyinfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetPlanMyinfoResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/profile/plan/myinfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetPlanMyinfoResult>.fromJson(
      _result.data!,
      (json) => GetPlanMyinfoResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiBlankResponse> updateMyinfo(request) async {
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
              '/profile/plan/myinfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<GetPlanProfileFormResult>> getForm() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetPlanProfileFormResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/profile/plan/form',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetPlanProfileFormResult>.fromJson(
      _result.data!,
      (json) => GetPlanProfileFormResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiBlankResponse> updateForm(request) async {
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
              '/profile/plan/form',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<GetPlanProfileResult>> get(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetPlanProfileResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/profile/plan',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetPlanProfileResult>.fromJson(
      _result.data!,
      (json) => GetPlanProfileResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<GetPlanProfileResult>> getGuest(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetPlanProfileResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/profile/plan/guest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetPlanProfileResult>.fromJson(
      _result.data!,
      (json) => GetPlanProfileResult.fromJson(json as Map<String, dynamic>),
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
