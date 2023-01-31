// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_profile_comp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCompMyinfoResult _$GetCompMyinfoResultFromJson(Map<String, dynamic> json) =>
    GetCompMyinfoResult(
      json['email'] as String,
      json['corp_name'] as String,
      json['ceo_name'] as String,
    );

Map<String, dynamic> _$GetCompMyinfoResultToJson(
        GetCompMyinfoResult instance) =>
    <String, dynamic>{
      'email': instance.email,
      'corp_name': instance.corpName,
      'ceo_name': instance.ceoName,
    };

PatchCompProfileRequest _$PatchCompProfileRequestFromJson(
        Map<String, dynamic> json) =>
    PatchCompProfileRequest(
      formKey: json['form_key'] as String,
    )
      ..profiImgKey = json['profi_img_key'] as String?
      ..nickname = json['nickname'] as String?
      ..area = json['area'] == null
          ? null
          : PatchCompProfileArea.fromJson(json['area'] as Map<String, dynamic>)
      ..newPictos = (json['new_pictos'] as List<dynamic>?)
          ?.map((e) =>
              NewCompProfilePictorial.fromJson(e as Map<String, dynamic>))
          .toList()
      ..deletedPictos = (json['deleted_pictos'] as List<dynamic>?)
          ?.map((e) => CompProfilePictorial.fromJson(e as Map<String, dynamic>))
          .toList()
      ..pictorialMains = (json['picto_mains'] as List<dynamic>?)
          ?.map((e) =>
              CompProfilePictorialMain.fromJson(e as Map<String, dynamic>))
          .toList()
      ..intro = json['intro'] as String?
      ..addr = json['addr'] as String?
      ..addrDetails = json['addr_details'] as String?
      ..addrX = json['addr_x'] as String?
      ..addrY = json['addr_y'] as String?
      ..workTime = json['work_time'] as String?
      ..consultAllow = json['consult_allow'] as bool?
      ..consultDays = (json['consult_days'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..consultOpenTime = json['consult_open_time'] as String?
      ..consultCloseTime = json['consult_close_time'] as String?;

Map<String, dynamic> _$PatchCompProfileRequestToJson(
        PatchCompProfileRequest instance) =>
    <String, dynamic>{
      'form_key': instance.formKey,
      'profi_img_key': instance.profiImgKey,
      'nickname': instance.nickname,
      'area': instance.area,
      'new_pictos': instance.newPictos,
      'deleted_pictos': instance.deletedPictos,
      'picto_mains': instance.pictorialMains,
      'intro': instance.intro,
      'addr': instance.addr,
      'addr_details': instance.addrDetails,
      'addr_x': instance.addrX,
      'addr_y': instance.addrY,
      'work_time': instance.workTime,
      'consult_allow': instance.consultAllow,
      'consult_days': instance.consultDays,
      'consult_open_time': instance.consultOpenTime,
      'consult_close_time': instance.consultCloseTime,
    };

GetCompProfilePictosResult _$GetCompProfilePictosResultFromJson(
        Map<String, dynamic> json) =>
    GetCompProfilePictosResult(
      json['img_key'] as String,
      json['thumb_key'] as String?,
    );

Map<String, dynamic> _$GetCompProfilePictosResultToJson(
        GetCompProfilePictosResult instance) =>
    <String, dynamic>{
      'img_key': instance.imgKey,
      'thumb_key': instance.thumbKey,
    };

GetCompProfilePictosRequest _$GetCompProfilePictosRequestFromJson(
        Map<String, dynamic> json) =>
    GetCompProfilePictosRequest(
      profileId: json['profile_id'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$GetCompProfilePictosRequestToJson(
        GetCompProfilePictosRequest instance) =>
    <String, dynamic>{
      'profile_id': instance.profileId,
      'page': instance.page,
      'size': instance.size,
    };

GetCompProfileRequest _$GetCompProfileRequestFromJson(
        Map<String, dynamic> json) =>
    GetCompProfileRequest(
      profileId: json['profile_id'] as int,
    );

Map<String, dynamic> _$GetCompProfileRequestToJson(
        GetCompProfileRequest instance) =>
    <String, dynamic>{
      'profile_id': instance.profileId,
    };

GetCompMypageResult _$GetCompMypageResultFromJson(Map<String, dynamic> json) =>
    GetCompMypageResult(
      json['profile_id'] as int,
      json['profi_img_key'] as String?,
      json['nickname'] as String,
      json['comp_type'] as int,
      json['consult_allow'] as bool,
    );

Map<String, dynamic> _$GetCompMypageResultToJson(
        GetCompMypageResult instance) =>
    <String, dynamic>{
      'profile_id': instance.profileId,
      'profi_img_key': instance.profileImgKey,
      'nickname': instance.nickname,
      'comp_type': instance.compType,
      'consult_allow': instance.consultAllow,
    };

GetCompProfileFormResult _$GetCompProfileFormResultFromJson(
        Map<String, dynamic> json) =>
    GetCompProfileFormResult(
      formKey: json['form_key'] as String,
      profiImgKey: json['profi_img_key'] as String?,
      nickname: json['nickname'] as String,
      area: json['area'] == null
          ? null
          : GetCompProfileArea.fromJson(json['area'] as Map<String, dynamic>),
      consultAllow: json['consult_allow'] as bool,
      pictorials: (json['pictorials'] as List<dynamic>?)
          ?.map((e) => CompProfilePictorial.fromJson(e as Map<String, dynamic>))
          .toList(),
      pictorialMains: (json['picto_mains'] as List<dynamic>?)
          ?.map((e) =>
              CompProfilePictorialMain.fromJson(e as Map<String, dynamic>))
          .toList(),
      intro: json['intro'] as String?,
      addr: json['addr'] as String?,
      addrDetails: json['addr_details'] as String?,
      workTime: json['work_time'] as String?,
      consultDays: (json['consult_days'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      consultOpenTime: json['consult_open_time'] as String?,
      consultCloseTime: json['consult_close_time'] as String?,
    );

Map<String, dynamic> _$GetCompProfileFormResultToJson(
        GetCompProfileFormResult instance) =>
    <String, dynamic>{
      'form_key': instance.formKey,
      'profi_img_key': instance.profiImgKey,
      'nickname': instance.nickname,
      'consult_allow': instance.consultAllow,
      'area': instance.area,
      'pictorials': instance.pictorials,
      'picto_mains': instance.pictorialMains,
      'intro': instance.intro,
      'addr': instance.addr,
      'addr_details': instance.addrDetails,
      'work_time': instance.workTime,
      'consult_days': instance.consultDays,
      'consult_open_time': instance.consultOpenTime,
      'consult_close_time': instance.consultCloseTime,
    };

GetCompProfileResult _$GetCompProfileResultFromJson(
        Map<String, dynamic> json) =>
    GetCompProfileResult(
      json['is_mine'] as bool,
      json['profi_id'] as int,
      json['cprofi_id'] as int,
      json['profi_img_key'] as String?,
      json['nickname'] as String,
      json['intro'] as String?,
      json['addr'] as String?,
      json['addr_details'] as String?,
      json['addr_x'] as String?,
      json['addr_y'] as String?,
      json['work_time'] as String?,
      json['cprofi_type'] as int,
      json['review_cnt'] as int,
      json['consult_allow'] as bool,
      (json['consult_days'] as List<dynamic>).map((e) => e as String).toList(),
      json['consult_open_time'] as String?,
      json['consult_close_time'] as String?,
      (json['main_pictos'] as List<dynamic>)
          .map((e) =>
              CompProfilePictorialMain.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['ct_thumbs'] as List<dynamic>)
          .map((e) =>
              CompProfileContentThumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['is_follow'] as bool,
    );

Map<String, dynamic> _$GetCompProfileResultToJson(
        GetCompProfileResult instance) =>
    <String, dynamic>{
      'is_mine': instance.isMine,
      'profi_id': instance.profileId,
      'cprofi_id': instance.cprofileId,
      'profi_img_key': instance.profileImgKey,
      'nickname': instance.nickname,
      'intro': instance.intro,
      'addr': instance.addr,
      'addr_details': instance.addrDetails,
      'addr_x': instance.addrX,
      'addr_y': instance.addrY,
      'work_time': instance.workTime,
      'cprofi_type': instance.compType,
      'review_cnt': instance.reviewCnt,
      'consult_allow': instance.consultAllow,
      'consult_days': instance.consultDays,
      'consult_open_time': instance.consultOpenTime,
      'consult_close_time': instance.consultCloseTime,
      'main_pictos': instance.mainPictoImgKeys,
      'ct_thumbs': instance.thumbnails,
      'is_follow': instance.isFollow,
    };

CompProfileReview _$CompProfileReviewFromJson(Map<String, dynamic> json) =>
    CompProfileReview(
      reviewId: json['rv_id'] as int,
      reviewRate: json['rate'] as int,
      reviewType: json['rv_type'] as int,
      description: json['descr'] as String,
      content: json['content'] as String,
      viewCnt: json['view_cnt'] as int,
      cmtCnt: json['cmt_cnt'] as int,
      likeCnt: json['lik_cnt'] as int,
      dateCreated: json['dt'] as String,
      isLike: json['is_like'] as bool,
    );

Map<String, dynamic> _$CompProfileReviewToJson(CompProfileReview instance) =>
    <String, dynamic>{
      'rv_id': instance.reviewId,
      'rate': instance.reviewRate,
      'rv_type': instance.reviewType,
      'descr': instance.description,
      'content': instance.content,
      'view_cnt': instance.viewCnt,
      'cmt_cnt': instance.cmtCnt,
      'lik_cnt': instance.likeCnt,
      'dt': instance.dateCreated,
      'is_like': instance.isLike,
    };

CompProfileContentThumbnail _$CompProfileContentThumbnailFromJson(
        Map<String, dynamic> json) =>
    CompProfileContentThumbnail(
      contentId: json['ct_id'] as int,
      contentType: json['ct_type'] as int,
      thumbKey: json['thumb_key'] as String,
      viewCnt: json['view_cnt'] as int,
    );

Map<String, dynamic> _$CompProfileContentThumbnailToJson(
        CompProfileContentThumbnail instance) =>
    <String, dynamic>{
      'ct_id': instance.contentId,
      'ct_type': instance.contentType,
      'thumb_key': instance.thumbKey,
      'view_cnt': instance.viewCnt,
    };

CompProfilePictorialMain _$CompProfilePictorialMainFromJson(
        Map<String, dynamic> json) =>
    CompProfilePictorialMain(
      imgKey: json['img_key'] as String,
    );

Map<String, dynamic> _$CompProfilePictorialMainToJson(
        CompProfilePictorialMain instance) =>
    <String, dynamic>{
      'img_key': instance.imgKey,
    };

GetCompProfileArea _$GetCompProfileAreaFromJson(Map<String, dynamic> json) =>
    GetCompProfileArea(
      area1Id: json['area1_id'] as int,
      area2Id: json['area2_id'] as int,
      area1Name: json['area1_name'] as String,
      area2Name: json['area2_name'] as String,
    );

Map<String, dynamic> _$GetCompProfileAreaToJson(GetCompProfileArea instance) =>
    <String, dynamic>{
      'area1_id': instance.area1Id,
      'area2_id': instance.area2Id,
      'area1_name': instance.area1Name,
      'area2_name': instance.area2Name,
    };

PatchCompProfileArea _$PatchCompProfileAreaFromJson(
        Map<String, dynamic> json) =>
    PatchCompProfileArea(
      area1Id: json['area1_id'] as int,
      area2Id: json['area2_id'] as int,
    );

Map<String, dynamic> _$PatchCompProfileAreaToJson(
        PatchCompProfileArea instance) =>
    <String, dynamic>{
      'area1_id': instance.area1Id,
      'area2_id': instance.area2Id,
    };

CompProfilePictorial _$CompProfilePictorialFromJson(
        Map<String, dynamic> json) =>
    CompProfilePictorial(
      json['picto_id'] as int,
      json['img_key'] as String,
      json['thumb_key'] as String,
      json['is_main'] as bool,
      json['main_prior'] as int,
    );

Map<String, dynamic> _$CompProfilePictorialToJson(
        CompProfilePictorial instance) =>
    <String, dynamic>{
      'picto_id': instance.pictoId,
      'img_key': instance.imgKey,
      'thumb_key': instance.thumbKey,
      'is_main': instance.isMain,
      'main_prior': instance.priority,
    };

NewCompProfilePictorial _$NewCompProfilePictorialFromJson(
        Map<String, dynamic> json) =>
    NewCompProfilePictorial(
      imgKey: json['img_key'] as String,
      thumbKey: json['thumb_key'] as String,
    );

Map<String, dynamic> _$NewCompProfilePictorialToJson(
        NewCompProfilePictorial instance) =>
    <String, dynamic>{
      'img_key': instance.imgKey,
      'thumb_key': instance.thumbKey,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiProfileComp implements ApiProfileComp {
  _ApiProfileComp(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<GetCompMypageResult>> mypage() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetCompMypageResult>>(Options(
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
    final value = ApiResponse<GetCompMypageResult>.fromJson(
      _result.data!,
      (json) => GetCompMypageResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<GetCompMyinfoResult>> getMyinfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetCompMyinfoResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/profile/comp/myinfo',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetCompMyinfoResult>.fromJson(
      _result.data!,
      (json) => GetCompMyinfoResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<GetCompProfileFormResult>> getForm() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetCompProfileFormResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/profile/comp/form',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetCompProfileFormResult>.fromJson(
      _result.data!,
      (json) => GetCompProfileFormResult.fromJson(json as Map<String, dynamic>),
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
              '/profile/comp/form',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<GetCompProfileResult>> get(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetCompProfileResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/profile/comp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetCompProfileResult>.fromJson(
      _result.data!,
      (json) => GetCompProfileResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<GetCompProfileResult>> getGuest(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetCompProfileResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/profile/comp/guest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetCompProfileResult>.fromJson(
      _result.data!,
      (json) => GetCompProfileResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetCompProfilePictosResult>>> getPictos(
      request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetCompProfilePictosResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/profile/comp/pictos',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetCompProfilePictosResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetCompProfilePictosResult>((i) =>
              GetCompProfilePictosResult.fromJson(i as Map<String, dynamic>))
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
