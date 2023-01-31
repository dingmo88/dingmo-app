// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostCommentResult _$PostCommentResultFromJson(Map<String, dynamic> json) =>
    PostCommentResult(
      cmtId: json['cmt_id'] as int,
      profileId: json['profi_id'] as int,
      profileType: json['profi_type'] as int,
      profileImgKey: json['profi_img_key'] as String?,
      nickname: json['nickname'] as String,
      isSecret: json['is_secret'] as bool,
      content: json['content'] as String?,
      likeCnt: json['like_cnt'] as int,
      replyCnt: json['reply_cnt'] as int,
      createdDt: DateTime.parse(json['dt'] as String),
      isLike: json['is_like'] as bool,
    );

Map<String, dynamic> _$PostCommentResultToJson(PostCommentResult instance) =>
    <String, dynamic>{
      'cmt_id': instance.cmtId,
      'profi_id': instance.profileId,
      'profi_type': instance.profileType,
      'profi_img_key': instance.profileImgKey,
      'nickname': instance.nickname,
      'is_secret': instance.isSecret,
      'content': instance.content,
      'like_cnt': instance.likeCnt,
      'reply_cnt': instance.replyCnt,
      'dt': instance.createdDt.toIso8601String(),
      'is_like': instance.isLike,
    };

DeleteCommentRequest _$DeleteCommentRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteCommentRequest(
      commentId: json['comment_id'] as int,
    );

Map<String, dynamic> _$DeleteCommentRequestToJson(
        DeleteCommentRequest instance) =>
    <String, dynamic>{
      'comment_id': instance.commentId,
    };

PostCommentRequest _$PostCommentRequestFromJson(Map<String, dynamic> json) =>
    PostCommentRequest(
      contentId: json['ct_id'] as int,
      content: json['content'] as String,
      isSecret: json['secret'] as bool,
    );

Map<String, dynamic> _$PostCommentRequestToJson(PostCommentRequest instance) =>
    <String, dynamic>{
      'ct_id': instance.contentId,
      'content': instance.content,
      'secret': instance.isSecret,
    };

GetCommentResult _$GetCommentResultFromJson(Map<String, dynamic> json) =>
    GetCommentResult(
      cmtId: json['cmt_id'] as int,
      profileId: json['profi_id'] as int,
      profileType: json['profi_type'] as int,
      profileImgKey: json['profi_img_key'] as String?,
      nickname: json['nickname'] as String,
      isSecret: json['is_secret'] as bool,
      content: json['content'] as String?,
      likeCnt: json['like_cnt'] as int,
      replyCnt: json['reply_cnt'] as int,
      createdDt: DateTime.parse(json['dt'] as String),
      isLike: json['is_like'] as bool,
      isMine: json['is_mine'] as bool,
    );

Map<String, dynamic> _$GetCommentResultToJson(GetCommentResult instance) =>
    <String, dynamic>{
      'cmt_id': instance.cmtId,
      'profi_id': instance.profileId,
      'profi_type': instance.profileType,
      'profi_img_key': instance.profileImgKey,
      'nickname': instance.nickname,
      'is_secret': instance.isSecret,
      'content': instance.content,
      'like_cnt': instance.likeCnt,
      'reply_cnt': instance.replyCnt,
      'dt': instance.createdDt.toIso8601String(),
      'is_like': instance.isLike,
      'is_mine': instance.isMine,
    };

GetCommentListRequest _$GetCommentListRequestFromJson(
        Map<String, dynamic> json) =>
    GetCommentListRequest(
      contentId: json['content_id'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$GetCommentListRequestToJson(
        GetCommentListRequest instance) =>
    <String, dynamic>{
      'content_id': instance.contentId,
      'page': instance.page,
      'size': instance.size,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiComment implements ApiComment {
  _ApiComment(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<List<GetCommentResult>>> getList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetCommentResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/comment/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetCommentResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetCommentResult>(
              (i) => GetCommentResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetCommentResult>>> getGuestList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetCommentResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/comment/list/guest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetCommentResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetCommentResult>(
              (i) => GetCommentResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<PostCommentResult>> create(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<PostCommentResult>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/comment',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<PostCommentResult>.fromJson(
      _result.data!,
      (json) => PostCommentResult.fromJson(json as Map<String, dynamic>),
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
              '/comment',
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
