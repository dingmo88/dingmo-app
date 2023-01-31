import 'package:dingmo/api/commons/api_response.dart';
import 'package:dingmo/api/commons/page_request.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/endpoints.dart';

part 'api_board.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiBoard {
  factory ApiBoard(Dio dio) = _ApiBoard;

  @GET(Endpoints.contentBoard)
  Future<ApiResponse<GetBoardResult>> get(@Queries() GetBoardRequest request);

  @GET(Endpoints.contentBoardList)
  Future<ApiResponse<List<GetBoardResult>>> getList(
      @Queries() PageRequest request);

  @GET(Endpoints.contentBoardGuest)
  Future<ApiResponse<GetBoardResult>> getGuest(
      @Queries() GetBoardRequest request);

  @GET(Endpoints.contentBoardGuestList)
  Future<ApiResponse<List<GetBoardResult>>> getGuestList(
      @Queries() PageRequest request);

  @POST(Endpoints.contentBoardForm)
  Future<ApiBlankResponse> create(@Body() PostBoardRequest request);

  @GET(Endpoints.contentBoardForm)
  Future<ApiResponse<GetBoardFormResult>> getForm(
      @Queries() GetBoardRequest request);

  @PATCH(Endpoints.contentBoardForm)
  Future<ApiBlankResponse> update(@Body() PatchBoardRequest request);

  @DELETE(Endpoints.contentBoardForm)
  Future<ApiBlankResponse> delete(@Body() DeleteBoardRequest request);
}

@JsonSerializable()
class DeleteBoardRequest {
  @JsonKey(name: "content_id")
  final int contentId;

  DeleteBoardRequest({required this.contentId});

  factory DeleteBoardRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteBoardRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteBoardRequestToJson(this);
}

@JsonSerializable()
class PatchBoardRequest {
  @JsonKey(name: "form_key")
  final String formKey;

  @JsonKey(name: "thumb_key")
  final String? thumbKey;

  @JsonKey(name: "imgs")
  final List<BoardImage>? images;

  @JsonKey(name: "descr")
  final String? description;

  @JsonKey(name: "tag")
  final BoardTag? tag;

  PatchBoardRequest(
      {required this.formKey,
      this.thumbKey,
      this.images,
      this.description,
      this.tag});

  factory PatchBoardRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchBoardRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PatchBoardRequestToJson(this);
}

@JsonSerializable()
class GetBoardRequest {
  @JsonKey(name: "content_id")
  final int contentId;

  GetBoardRequest({required this.contentId});

  factory GetBoardRequest.fromJson(Map<String, dynamic> json) =>
      _$GetBoardRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetBoardRequestToJson(this);
}

@JsonSerializable()
class PostBoardRequest {
  @JsonKey(name: "thumb_key")
  final String thumbKey;

  @JsonKey(name: "imgs")
  final List<BoardImage> images;

  @JsonKey(name: "descr")
  final String description;

  @JsonKey(name: "tag")
  final BoardTag tag;

  PostBoardRequest(
      {required this.thumbKey,
      required this.images,
      required this.description,
      required this.tag});

  factory PostBoardRequest.fromJson(Map<String, dynamic> json) =>
      _$PostBoardRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostBoardRequestToJson(this);
}

@JsonSerializable()
class GetBoardFormResult {
  @JsonKey(name: "form_key")
  final String formKey;

  @JsonKey(name: "imgs")
  final List<BoardImage> images;

  @JsonKey(name: "descr")
  final String description;

  @JsonKey(name: "tag")
  final BoardTag tag;

  GetBoardFormResult(this.formKey, this.images, this.description, this.tag);

  factory GetBoardFormResult.fromJson(Map<String, dynamic> json) =>
      _$GetBoardFormResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetBoardFormResultToJson(this);
}

@JsonSerializable()
class GetBoardResult {
  @JsonKey(name: "ct_id")
  final int contentId;

  @JsonKey(name: "brd_id")
  final int boardId;

  @JsonKey(name: "profi_img_key")
  final String? profiImgKey;

  @JsonKey(name: "profi_nickname")
  final String nickname;

  @JsonKey(name: "descr")
  final String description;

  @JsonKey(name: "imgs")
  final List<BoardImage> images;

  @JsonKey(name: "dt")
  final DateTime createdDt;

  @JsonKey(name: "tags")
  final List<String> tags;

  @JsonKey(name: "mentions")
  final List<BoardMention> mentions;

  @JsonKey(name: "lik_cnt")
  final int likeCnt;

  @JsonKey(name: "cmt_cnt")
  final int commentCnt;

  @JsonKey(name: "is_like")
  final bool isLike;

  @JsonKey(name: "bmk_id")
  final int? bmkId;

  @JsonKey(name: "is_mine")
  final bool isMine;

  GetBoardResult(
      this.contentId,
      this.boardId,
      this.profiImgKey,
      this.nickname,
      this.description,
      this.images,
      this.createdDt,
      this.tags,
      this.mentions,
      this.likeCnt,
      this.commentCnt,
      this.isLike,
      this.bmkId,
      this.isMine);

  factory GetBoardResult.fromJson(Map<String, dynamic> json) =>
      _$GetBoardResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetBoardResultToJson(this);
}

@JsonSerializable()
class BoardTag {
  @JsonKey(name: "idx_tag")
  final int indexTag;

  @JsonKey(name: "tags")
  final List<String> tags;

  BoardTag({required this.indexTag, required this.tags});

  factory BoardTag.fromJson(Map<String, dynamic> json) =>
      _$BoardTagFromJson(json);
  Map<String, dynamic> toJson() => _$BoardTagToJson(this);
}

@JsonSerializable()
class BoardMention {
  @JsonKey(name: "profi_id")
  final int profileId;

  @JsonKey(name: "nickname")
  final String nickname;

  BoardMention({required this.profileId, required this.nickname});

  factory BoardMention.fromJson(Map<String, dynamic> json) =>
      _$BoardMentionFromJson(json);
  Map<String, dynamic> toJson() => _$BoardMentionToJson(this);
}

@JsonSerializable()
class BoardImage {
  @JsonKey(name: "img_key")
  final String imgKey;

  @JsonKey(name: "thumb_key")
  final String thumbKey;

  BoardImage({required this.imgKey, required this.thumbKey});

  factory BoardImage.fromJson(Map<String, dynamic> json) =>
      _$BoardImageFromJson(json);
  Map<String, dynamic> toJson() => _$BoardImageToJson(this);
}
