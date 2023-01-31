// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_reply.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteReplyRequest _$DeleteReplyRequestFromJson(Map<String, dynamic> json) =>
    DeleteReplyRequest(
      replyId: json['reply_id'] as int,
    );

Map<String, dynamic> _$DeleteReplyRequestToJson(DeleteReplyRequest instance) =>
    <String, dynamic>{
      'reply_id': instance.replyId,
    };

PostReplyRequest _$PostReplyRequestFromJson(Map<String, dynamic> json) =>
    PostReplyRequest(
      contentId: json['ct_id'] as int,
      commentId: json['cmt_id'] as int,
      content: json['content'] as String,
      isSecret: json['secret'] as bool,
      mention: json['mention'] == null
          ? null
          : ReplyMention.fromJson(json['mention'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostReplyRequestToJson(PostReplyRequest instance) =>
    <String, dynamic>{
      'ct_id': instance.contentId,
      'cmt_id': instance.commentId,
      'content': instance.content,
      'secret': instance.isSecret,
      'mention': instance.mention,
    };

GetReplyRequest _$GetReplyRequestFromJson(Map<String, dynamic> json) =>
    GetReplyRequest(
      commentId: json['comment_id'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$GetReplyRequestToJson(GetReplyRequest instance) =>
    <String, dynamic>{
      'comment_id': instance.commentId,
      'page': instance.page,
      'size': instance.size,
    };

PostReplyResult _$PostReplyResultFromJson(Map<String, dynamic> json) =>
    PostReplyResult(
      json['cmt_id'] as int,
      json['at_cmt_id'] as int,
      json['mention'] == null
          ? null
          : ReplyMention.fromJson(json['mention'] as Map<String, dynamic>),
      json['profi_id'] as int,
      json['profi_type'] as int,
      json['profi_img_key'] as String?,
      json['nickname'] as String,
      json['is_secret'] as bool,
      json['content'] as String,
      json['like_cnt'] as int,
      DateTime.parse(json['dt'] as String),
      json['is_like'] as bool,
    );

Map<String, dynamic> _$PostReplyResultToJson(PostReplyResult instance) =>
    <String, dynamic>{
      'cmt_id': instance.replyId,
      'at_cmt_id': instance.atCommentId,
      'mention': instance.mention,
      'profi_id': instance.profileId,
      'profi_type': instance.profileType,
      'profi_img_key': instance.profileImgKey,
      'nickname': instance.nickname,
      'is_secret': instance.isSecret,
      'content': instance.content,
      'like_cnt': instance.likeCnt,
      'dt': instance.createdDt.toIso8601String(),
      'is_like': instance.isLike,
    };

GetReplyResult _$GetReplyResultFromJson(Map<String, dynamic> json) =>
    GetReplyResult(
      json['cmt_id'] as int,
      json['at_cmt_id'] as int,
      json['mention'] == null
          ? null
          : ReplyMention.fromJson(json['mention'] as Map<String, dynamic>),
      json['profi_id'] as int,
      json['profi_type'] as int,
      json['profi_img_key'] as String?,
      json['nickname'] as String,
      json['is_secret'] as bool,
      json['content'] as String,
      json['like_cnt'] as int,
      DateTime.parse(json['dt'] as String),
      json['is_like'] as bool,
      json['is_mine'] as bool,
    );

Map<String, dynamic> _$GetReplyResultToJson(GetReplyResult instance) =>
    <String, dynamic>{
      'cmt_id': instance.replyId,
      'at_cmt_id': instance.atCommentId,
      'mention': instance.mention,
      'profi_id': instance.profileId,
      'profi_type': instance.profileType,
      'profi_img_key': instance.profileImgKey,
      'nickname': instance.nickname,
      'is_secret': instance.isSecret,
      'content': instance.content,
      'like_cnt': instance.likeCnt,
      'dt': instance.createdDt.toIso8601String(),
      'is_like': instance.isLike,
      'is_mine': instance.isMine,
    };

ReplyMention _$ReplyMentionFromJson(Map<String, dynamic> json) => ReplyMention(
      atProfileId: json['at_profi_id'] as int,
      atProfileType: json['at_profi_type'] as int,
      atNickname: json['at_nickname'] as String,
    );

Map<String, dynamic> _$ReplyMentionToJson(ReplyMention instance) =>
    <String, dynamic>{
      'at_profi_id': instance.atProfileId,
      'at_profi_type': instance.atProfileType,
      'at_nickname': instance.atNickname,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiReply implements ApiReply {
  _ApiReply(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<List<GetReplyResult>>> getList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetReplyResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/reply/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetReplyResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetReplyResult>(
              (i) => GetReplyResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetReplyResult>>> getGuestList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetReplyResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/reply/list/guest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetReplyResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetReplyResult>(
              (i) => GetReplyResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<PostReplyResult>> create(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<PostReplyResult>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/reply',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<PostReplyResult>.fromJson(
      _result.data!,
      (json) => PostReplyResult.fromJson(json as Map<String, dynamic>),
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
              '/reply',
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
