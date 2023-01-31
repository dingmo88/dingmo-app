import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_reply.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiReply {
  factory ApiReply(Dio dio) = _ApiReply;

  @GET(Endpoints.replyList)
  Future<ApiResponse<List<GetReplyResult>>> getList(
      @Queries() GetReplyRequest request);

  @GET(Endpoints.replyListGuest)
  Future<ApiResponse<List<GetReplyResult>>> getGuestList(
      @Queries() GetReplyRequest request);

  @POST(Endpoints.reply)
  Future<ApiResponse<PostReplyResult>> create(@Body() PostReplyRequest request);

  @DELETE(Endpoints.reply)
  Future<ApiBlankResponse> delete(@Body() DeleteReplyRequest request);
}

@JsonSerializable()
class DeleteReplyRequest {
  @JsonKey(name: "reply_id")
  final int replyId;

  DeleteReplyRequest({required this.replyId});

  factory DeleteReplyRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteReplyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteReplyRequestToJson(this);
}

@JsonSerializable()
class PostReplyRequest {
  @JsonKey(name: "ct_id")
  final int contentId;

  @JsonKey(name: "cmt_id")
  final int commentId;

  @JsonKey(name: "content")
  final String content;

  @JsonKey(name: "secret")
  final bool isSecret;

  @JsonKey(name: "mention")
  final ReplyMention? mention;

  PostReplyRequest(
      {required this.contentId,
      required this.commentId,
      required this.content,
      required this.isSecret,
      required this.mention});

  factory PostReplyRequest.fromJson(Map<String, dynamic> json) =>
      _$PostReplyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostReplyRequestToJson(this);
}

@JsonSerializable()
class GetReplyRequest {
  @JsonKey(name: "comment_id")
  final int commentId;

  @JsonKey(name: "page")
  final int page;

  @JsonKey(name: "size")
  final int size;

  GetReplyRequest(
      {required this.commentId, required this.page, required this.size});

  factory GetReplyRequest.fromJson(Map<String, dynamic> json) =>
      _$GetReplyRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetReplyRequestToJson(this);
}

@JsonSerializable()
class PostReplyResult {
  @JsonKey(name: "cmt_id")
  final int replyId;

  @JsonKey(name: "at_cmt_id")
  final int atCommentId;

  @JsonKey(name: "mention")
  final ReplyMention? mention;

  @JsonKey(name: "profi_id")
  final int profileId;

  @JsonKey(name: "profi_type")
  final int profileType;

  @JsonKey(name: "profi_img_key")
  final String? profileImgKey;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "is_secret")
  final bool isSecret;

  @JsonKey(name: "content")
  final String content;

  @JsonKey(name: "like_cnt")
  final int likeCnt;

  @JsonKey(name: "dt")
  final DateTime createdDt;

  @JsonKey(name: "is_like")
  final bool isLike;

  PostReplyResult(
      this.replyId,
      this.atCommentId,
      this.mention,
      this.profileId,
      this.profileType,
      this.profileImgKey,
      this.nickname,
      this.isSecret,
      this.content,
      this.likeCnt,
      this.createdDt,
      this.isLike);

  factory PostReplyResult.fromJson(Map<String, dynamic> json) =>
      _$PostReplyResultFromJson(json);
  Map<String, dynamic> toJson() => _$PostReplyResultToJson(this);
}

@JsonSerializable()
class GetReplyResult {
  @JsonKey(name: "cmt_id")
  final int replyId;

  @JsonKey(name: "at_cmt_id")
  final int atCommentId;

  @JsonKey(name: "mention")
  final ReplyMention? mention;

  @JsonKey(name: "profi_id")
  final int profileId;

  @JsonKey(name: "profi_type")
  final int profileType;

  @JsonKey(name: "profi_img_key")
  final String? profileImgKey;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "is_secret")
  final bool isSecret;

  @JsonKey(name: "content")
  final String content;

  @JsonKey(name: "like_cnt")
  final int likeCnt;

  @JsonKey(name: "dt")
  final DateTime createdDt;

  @JsonKey(name: "is_like")
  final bool isLike;

  @JsonKey(name: "is_mine")
  final bool isMine;

  GetReplyResult(
    this.replyId,
    this.atCommentId,
    this.mention,
    this.profileId,
    this.profileType,
    this.profileImgKey,
    this.nickname,
    this.isSecret,
    this.content,
    this.likeCnt,
    this.createdDt,
    this.isLike,
    this.isMine,
  );

  factory GetReplyResult.fromJson(Map<String, dynamic> json) =>
      _$GetReplyResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetReplyResultToJson(this);
}

@JsonSerializable()
class ReplyMention {
  @JsonKey(name: "at_profi_id")
  final int atProfileId;

  @JsonKey(name: "at_profi_type")
  final int atProfileType;

  @JsonKey(name: "at_nickname")
  final String atNickname;

  ReplyMention(
      {required this.atProfileId,
      required this.atProfileType,
      required this.atNickname});

  factory ReplyMention.fromJson(Map<String, dynamic> json) =>
      _$ReplyMentionFromJson(json);
  Map<String, dynamic> toJson() => _$ReplyMentionToJson(this);
}
