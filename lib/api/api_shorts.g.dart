// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_shorts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteShortsRequest _$DeleteShortsRequestFromJson(Map<String, dynamic> json) =>
    DeleteShortsRequest(
      contentId: json['content_id'] as int,
    );

Map<String, dynamic> _$DeleteShortsRequestToJson(
        DeleteShortsRequest instance) =>
    <String, dynamic>{
      'content_id': instance.contentId,
    };

PatchShortsRequest _$PatchShortsRequestFromJson(Map<String, dynamic> json) =>
    PatchShortsRequest(
      formKey: json['form_key'] as String,
      descr: json['descr'] as String?,
      thumb: json['thumb'] == null
          ? null
          : EditedShortsThumbnail.fromJson(
              json['thumb'] as Map<String, dynamic>),
      tag: json['tag'] == null
          ? null
          : ShortsTag.fromJson(json['tag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatchShortsRequestToJson(PatchShortsRequest instance) =>
    <String, dynamic>{
      'form_key': instance.formKey,
      'descr': instance.descr,
      'thumb': instance.thumb,
      'tag': instance.tag,
    };

GetShortsRequest _$GetShortsRequestFromJson(Map<String, dynamic> json) =>
    GetShortsRequest(
      contentId: json['content_id'] as int,
    );

Map<String, dynamic> _$GetShortsRequestToJson(GetShortsRequest instance) =>
    <String, dynamic>{
      'content_id': instance.contentId,
    };

GetShortsFormRequest _$GetShortsFormRequestFromJson(
        Map<String, dynamic> json) =>
    GetShortsFormRequest(
      contentId: json['content_id'] as int,
    );

Map<String, dynamic> _$GetShortsFormRequestToJson(
        GetShortsFormRequest instance) =>
    <String, dynamic>{
      'content_id': instance.contentId,
    };

PostShortsRequest _$PostShortsRequestFromJson(Map<String, dynamic> json) =>
    PostShortsRequest(
      thumbKey: json['thumb_key'] as String,
      thumbKeys: (json['thumb_keys'] as List<dynamic>)
          .map((e) => ShortsThumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      m3u8FileKey: json['m3u8_file_key'] as String,
      description: json['descr'] as String,
      tag: ShortsTag.fromJson(json['tag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostShortsRequestToJson(PostShortsRequest instance) =>
    <String, dynamic>{
      'thumb_key': instance.thumbKey,
      'thumb_keys': instance.thumbKeys,
      'm3u8_file_key': instance.m3u8FileKey,
      'descr': instance.description,
      'tag': instance.tag,
    };

GetShortsFormResult _$GetShortsFormResultFromJson(Map<String, dynamic> json) =>
    GetShortsFormResult(
      json['form_key'] as String,
      (json['thumbs'] as List<dynamic>)
          .map((e) => ShortsThumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['descr'] as String,
      ShortsTag.fromJson(json['tag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetShortsFormResultToJson(
        GetShortsFormResult instance) =>
    <String, dynamic>{
      'form_key': instance.formKey,
      'thumbs': instance.thumbs,
      'descr': instance.descr,
      'tag': instance.tag,
    };

GetShortsResult _$GetShortsResultFromJson(Map<String, dynamic> json) =>
    GetShortsResult(
      json['ct_id'] as int,
      json['shts_id'] as int,
      json['profi_id'] as int,
      json['profi_type'] as int,
      json['profi_img_key'] as String?,
      json['thumb_img_key'] as String,
      json['m3u8_key'] as String,
      json['nickname'] as String,
      (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      json['descr'] as String,
      json['lik_cnt'] as int,
      json['cmt_cnt'] as int,
      json['bmk_cnt'] as int,
      json['share_cnt'] as int,
      json['is_like'] as bool,
      json['is_mine'] as bool,
      json['bmk_id'] as int?,
    );

Map<String, dynamic> _$GetShortsResultToJson(GetShortsResult instance) =>
    <String, dynamic>{
      'ct_id': instance.contentId,
      'shts_id': instance.shortsId,
      'profi_id': instance.profileId,
      'profi_type': instance.profileType,
      'profi_img_key': instance.profileImgKey,
      'thumb_img_key': instance.thumbImgKey,
      'm3u8_key': instance.m3u8Key,
      'nickname': instance.nickname,
      'tags': instance.tags,
      'descr': instance.description,
      'lik_cnt': instance.likeCnt,
      'cmt_cnt': instance.commentCnt,
      'bmk_cnt': instance.boomkmarkCnt,
      'share_cnt': instance.shareCnt,
      'is_like': instance.isLike,
      'is_mine': instance.isMine,
      'bmk_id': instance.bmkId,
    };

EditedShortsThumbnail _$EditedShortsThumbnailFromJson(
        Map<String, dynamic> json) =>
    EditedShortsThumbnail(
      selectedThumb: ShortsThumbnail.fromJson(
          json['selected_thumb'] as Map<String, dynamic>),
      thumbs: (json['thumbs'] as List<dynamic>)
          .map((e) => ShortsThumbnail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EditedShortsThumbnailToJson(
        EditedShortsThumbnail instance) =>
    <String, dynamic>{
      'selected_thumb': instance.selectedThumb,
      'thumbs': instance.thumbs,
    };

ShortsThumbnail _$ShortsThumbnailFromJson(Map<String, dynamic> json) =>
    ShortsThumbnail(
      imgKey: json['img_key'] as String,
      isSelected: json['is_selected'] as bool,
    );

Map<String, dynamic> _$ShortsThumbnailToJson(ShortsThumbnail instance) =>
    <String, dynamic>{
      'img_key': instance.imgKey,
      'is_selected': instance.isSelected,
    };

ShortsTag _$ShortsTagFromJson(Map<String, dynamic> json) => ShortsTag(
      idxTag: json['idx_tag'] as int,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ShortsTagToJson(ShortsTag instance) => <String, dynamic>{
      'idx_tag': instance.idxTag,
      'tags': instance.tags,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiShorts implements ApiShorts {
  _ApiShorts(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<GetShortsResult>> get(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetShortsResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/content/shorts',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetShortsResult>.fromJson(
      _result.data!,
      (json) => GetShortsResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetShortsResult>>> getList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetShortsResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/content/shorts/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetShortsResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetShortsResult>(
              (i) => GetShortsResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<GetShortsResult>> getGuest(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetShortsResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/content/shorts/guest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetShortsResult>.fromJson(
      _result.data!,
      (json) => GetShortsResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetShortsResult>>> getGuestList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetShortsResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/content/shorts/guest/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetShortsResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetShortsResult>(
              (i) => GetShortsResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

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
              '/content/shorts/form',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<GetShortsFormResult>> getForm(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetShortsFormResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/content/shorts/form',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetShortsFormResult>.fromJson(
      _result.data!,
      (json) => GetShortsFormResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiBlankResponse> update(request) async {
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
              '/content/shorts/form',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
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
              '/content/shorts/form',
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
