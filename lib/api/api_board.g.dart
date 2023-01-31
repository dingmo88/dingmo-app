// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_board.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteBoardRequest _$DeleteBoardRequestFromJson(Map<String, dynamic> json) =>
    DeleteBoardRequest(
      contentId: json['content_id'] as int,
    );

Map<String, dynamic> _$DeleteBoardRequestToJson(DeleteBoardRequest instance) =>
    <String, dynamic>{
      'content_id': instance.contentId,
    };

PatchBoardRequest _$PatchBoardRequestFromJson(Map<String, dynamic> json) =>
    PatchBoardRequest(
      formKey: json['form_key'] as String,
      thumbKey: json['thumb_key'] as String?,
      images: (json['imgs'] as List<dynamic>?)
          ?.map((e) => BoardImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['descr'] as String?,
      tag: json['tag'] == null
          ? null
          : BoardTag.fromJson(json['tag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PatchBoardRequestToJson(PatchBoardRequest instance) =>
    <String, dynamic>{
      'form_key': instance.formKey,
      'thumb_key': instance.thumbKey,
      'imgs': instance.images,
      'descr': instance.description,
      'tag': instance.tag,
    };

GetBoardRequest _$GetBoardRequestFromJson(Map<String, dynamic> json) =>
    GetBoardRequest(
      contentId: json['content_id'] as int,
    );

Map<String, dynamic> _$GetBoardRequestToJson(GetBoardRequest instance) =>
    <String, dynamic>{
      'content_id': instance.contentId,
    };

PostBoardRequest _$PostBoardRequestFromJson(Map<String, dynamic> json) =>
    PostBoardRequest(
      thumbKey: json['thumb_key'] as String,
      images: (json['imgs'] as List<dynamic>)
          .map((e) => BoardImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      description: json['descr'] as String,
      tag: BoardTag.fromJson(json['tag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostBoardRequestToJson(PostBoardRequest instance) =>
    <String, dynamic>{
      'thumb_key': instance.thumbKey,
      'imgs': instance.images,
      'descr': instance.description,
      'tag': instance.tag,
    };

GetBoardFormResult _$GetBoardFormResultFromJson(Map<String, dynamic> json) =>
    GetBoardFormResult(
      json['form_key'] as String,
      (json['imgs'] as List<dynamic>)
          .map((e) => BoardImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['descr'] as String,
      BoardTag.fromJson(json['tag'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBoardFormResultToJson(GetBoardFormResult instance) =>
    <String, dynamic>{
      'form_key': instance.formKey,
      'imgs': instance.images,
      'descr': instance.description,
      'tag': instance.tag,
    };

GetBoardResult _$GetBoardResultFromJson(Map<String, dynamic> json) =>
    GetBoardResult(
      json['ct_id'] as int,
      json['brd_id'] as int,
      json['profi_img_key'] as String?,
      json['profi_nickname'] as String,
      json['descr'] as String,
      (json['imgs'] as List<dynamic>)
          .map((e) => BoardImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      DateTime.parse(json['dt'] as String),
      (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      (json['mentions'] as List<dynamic>)
          .map((e) => BoardMention.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['lik_cnt'] as int,
      json['cmt_cnt'] as int,
      json['is_like'] as bool,
      json['bmk_id'] as int?,
      json['is_mine'] as bool,
    );

Map<String, dynamic> _$GetBoardResultToJson(GetBoardResult instance) =>
    <String, dynamic>{
      'ct_id': instance.contentId,
      'brd_id': instance.boardId,
      'profi_img_key': instance.profiImgKey,
      'profi_nickname': instance.nickname,
      'descr': instance.description,
      'imgs': instance.images,
      'dt': instance.createdDt.toIso8601String(),
      'tags': instance.tags,
      'mentions': instance.mentions,
      'lik_cnt': instance.likeCnt,
      'cmt_cnt': instance.commentCnt,
      'is_like': instance.isLike,
      'bmk_id': instance.bmkId,
      'is_mine': instance.isMine,
    };

BoardTag _$BoardTagFromJson(Map<String, dynamic> json) => BoardTag(
      indexTag: json['idx_tag'] as int,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BoardTagToJson(BoardTag instance) => <String, dynamic>{
      'idx_tag': instance.indexTag,
      'tags': instance.tags,
    };

BoardMention _$BoardMentionFromJson(Map<String, dynamic> json) => BoardMention(
      profileId: json['profi_id'] as int,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$BoardMentionToJson(BoardMention instance) =>
    <String, dynamic>{
      'profi_id': instance.profileId,
      'nickname': instance.nickname,
    };

BoardImage _$BoardImageFromJson(Map<String, dynamic> json) => BoardImage(
      imgKey: json['img_key'] as String,
      thumbKey: json['thumb_key'] as String,
    );

Map<String, dynamic> _$BoardImageToJson(BoardImage instance) =>
    <String, dynamic>{
      'img_key': instance.imgKey,
      'thumb_key': instance.thumbKey,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiBoard implements ApiBoard {
  _ApiBoard(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<GetBoardResult>> get(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetBoardResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/content/board',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetBoardResult>.fromJson(
      _result.data!,
      (json) => GetBoardResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetBoardResult>>> getList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetBoardResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/content/board/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetBoardResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetBoardResult>(
              (i) => GetBoardResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<GetBoardResult>> getGuest(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetBoardResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/content/board/guest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetBoardResult>.fromJson(
      _result.data!,
      (json) => GetBoardResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetBoardResult>>> getGuestList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetBoardResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/content/board/guest/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetBoardResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetBoardResult>(
              (i) => GetBoardResult.fromJson(i as Map<String, dynamic>))
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
              '/content/board/form',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiResponse<GetBoardFormResult>> getForm(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetBoardFormResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/content/board/form',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetBoardFormResult>.fromJson(
      _result.data!,
      (json) => GetBoardFormResult.fromJson(json as Map<String, dynamic>),
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
              '/content/board/form',
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
              '/content/board/form',
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
