import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_comment.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiComment {
  factory ApiComment(Dio dio) = _ApiComment;

  @GET(Endpoints.commentList)
  Future<ApiResponse<List<GetCommentResult>>> getList(
      @Queries() GetCommentListRequest request);

  @GET(Endpoints.commentListGuest)
  Future<ApiResponse<List<GetCommentResult>>> getGuestList(
      @Queries() GetCommentListRequest request);

  @POST(Endpoints.comment)
  Future<ApiResponse<PostCommentResult>> create(
      @Body() PostCommentRequest request);

  @DELETE(Endpoints.comment)
  Future<ApiBlankResponse> delete(@Body() DeleteCommentRequest request);
}

@JsonSerializable()
class PostCommentResult {
  @JsonKey(name: "cmt_id")
  final int cmtId;

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
  final String? content;

  @JsonKey(name: "like_cnt")
  final int likeCnt;

  @JsonKey(name: "reply_cnt")
  final int replyCnt;

  @JsonKey(name: "dt")
  final DateTime createdDt;

  @JsonKey(name: "is_like")
  final bool isLike;

  PostCommentResult(
      {required this.cmtId,
      required this.profileId,
      required this.profileType,
      required this.profileImgKey,
      required this.nickname,
      required this.isSecret,
      this.content,
      required this.likeCnt,
      required this.replyCnt,
      required this.createdDt,
      required this.isLike});

  factory PostCommentResult.fromJson(Map<String, dynamic> json) =>
      _$PostCommentResultFromJson(json);
  Map<String, dynamic> toJson() => _$PostCommentResultToJson(this);
}

@JsonSerializable()
class DeleteCommentRequest {
  @JsonKey(name: "comment_id")
  final int commentId;

  DeleteCommentRequest({required this.commentId});

  factory DeleteCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteCommentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteCommentRequestToJson(this);
}

@JsonSerializable()
class PostCommentRequest {
  @JsonKey(name: "ct_id")
  final int contentId;

  @JsonKey(name: "content")
  final String content;

  @JsonKey(name: "secret")
  final bool isSecret;

  PostCommentRequest(
      {required this.contentId, required this.content, required this.isSecret});

  factory PostCommentRequest.fromJson(Map<String, dynamic> json) =>
      _$PostCommentRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostCommentRequestToJson(this);
}

@JsonSerializable()
class GetCommentResult {
  @JsonKey(name: "cmt_id")
  final int cmtId;

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
  final String? content;

  @JsonKey(name: "like_cnt")
  final int likeCnt;

  @JsonKey(name: "reply_cnt")
  final int replyCnt;

  @JsonKey(name: "dt")
  final DateTime createdDt;

  @JsonKey(name: "is_like")
  final bool isLike;

  @JsonKey(name: "is_mine")
  final bool isMine;

  GetCommentResult({
    required this.cmtId,
    required this.profileId,
    required this.profileType,
    required this.profileImgKey,
    required this.nickname,
    required this.isSecret,
    this.content,
    required this.likeCnt,
    required this.replyCnt,
    required this.createdDt,
    required this.isLike,
    required this.isMine,
  });

  factory GetCommentResult.fromJson(Map<String, dynamic> json) =>
      _$GetCommentResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetCommentResultToJson(this);
}

@JsonSerializable()
class GetCommentListRequest {
  @JsonKey(name: "content_id")
  final int contentId;

  @JsonKey(name: "page")
  final int page;

  @JsonKey(name: "size")
  final int size;

  GetCommentListRequest({
    required this.contentId,
    required this.page,
    required this.size,
  });

  factory GetCommentListRequest.fromJson(Map<String, dynamic> json) =>
      _$GetCommentListRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetCommentListRequestToJson(this);
}
