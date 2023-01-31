import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_shorts.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiShorts {
  factory ApiShorts(Dio dio) = _ApiShorts;

  @GET(Endpoints.contentShorts)
  Future<ApiResponse<GetShortsResult>> get(@Queries() GetShortsRequest request);

  @GET(Endpoints.contentShortsList)
  Future<ApiResponse<List<GetShortsResult>>> getList();

  @GET(Endpoints.contentShortsGuest)
  Future<ApiResponse<GetShortsResult>> getGuest(
      @Queries() GetShortsRequest request);

  @GET(Endpoints.contentShortsGuestList)
  Future<ApiResponse<List<GetShortsResult>>> getGuestList();

  @POST(Endpoints.contentShortsForm)
  Future<ApiBlankResponse> create(@Body() PostShortsRequest request);

  @GET(Endpoints.contentShortsForm)
  Future<ApiResponse<GetShortsFormResult>> getForm(
      @Queries() GetShortsFormRequest request);

  @PATCH(Endpoints.contentShortsForm)
  Future<ApiBlankResponse> update(@Body() PatchShortsRequest request);

  @DELETE(Endpoints.contentShortsForm)
  Future<ApiBlankResponse> delete(@Body() DeleteShortsRequest request);
}

@JsonSerializable()
class DeleteShortsRequest {
  @JsonKey(name: "content_id")
  final int contentId;

  DeleteShortsRequest({required this.contentId});

  factory DeleteShortsRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteShortsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteShortsRequestToJson(this);
}

@JsonSerializable()
class PatchShortsRequest {
  @JsonKey(name: "form_key")
  final String formKey;

  @JsonKey(name: "descr")
  final String? descr;

  @JsonKey(name: "thumb")
  final EditedShortsThumbnail? thumb;

  @JsonKey(name: "tag")
  final ShortsTag? tag;

  PatchShortsRequest(
      {required this.formKey, required this.descr, this.thumb, this.tag});

  factory PatchShortsRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchShortsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PatchShortsRequestToJson(this);
}

@JsonSerializable()
class GetShortsRequest {
  @JsonKey(name: "content_id")
  final int contentId;

  GetShortsRequest({required this.contentId});

  factory GetShortsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetShortsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetShortsRequestToJson(this);
}

@JsonSerializable()
class GetShortsFormRequest {
  @JsonKey(name: "content_id")
  final int contentId;

  GetShortsFormRequest({required this.contentId});

  factory GetShortsFormRequest.fromJson(Map<String, dynamic> json) =>
      _$GetShortsFormRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetShortsFormRequestToJson(this);
}

@JsonSerializable()
class PostShortsRequest {
  @JsonKey(name: "thumb_key")
  final String thumbKey;

  @JsonKey(name: "thumb_keys")
  final List<ShortsThumbnail> thumbKeys;

  @JsonKey(name: "m3u8_file_key")
  final String m3u8FileKey;

  @JsonKey(name: "descr")
  final String description;

  @JsonKey(name: "tag")
  final ShortsTag tag;

  PostShortsRequest(
      {required this.thumbKey,
      required this.thumbKeys,
      required this.m3u8FileKey,
      required this.description,
      required this.tag});

  factory PostShortsRequest.fromJson(Map<String, dynamic> json) =>
      _$PostShortsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostShortsRequestToJson(this);
}

@JsonSerializable()
class GetShortsFormResult {
  @JsonKey(name: "form_key")
  final String formKey;

  @JsonKey(name: "thumbs")
  final List<ShortsThumbnail> thumbs;

  @JsonKey(name: "descr")
  final String descr;

  @JsonKey(name: "tag")
  final ShortsTag tag;

  GetShortsFormResult(
    this.formKey,
    this.thumbs,
    this.descr,
    this.tag,
  );

  factory GetShortsFormResult.fromJson(Map<String, dynamic> json) =>
      _$GetShortsFormResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetShortsFormResultToJson(this);
}

@JsonSerializable()
class GetShortsResult {
  @JsonKey(name: "ct_id")
  final int contentId;

  @JsonKey(name: "shts_id")
  final int shortsId;

  @JsonKey(name: "profi_id")
  final int profileId;

  @JsonKey(name: "profi_type")
  final int profileType;

  @JsonKey(name: "profi_img_key")
  final String? profileImgKey;

  @JsonKey(name: "thumb_img_key")
  final String thumbImgKey;

  @JsonKey(name: "m3u8_key")
  final String m3u8Key;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "tags")
  final List<String> tags;

  @JsonKey(name: "descr")
  final String description;

  @JsonKey(name: "lik_cnt")
  int likeCnt;

  @JsonKey(name: "cmt_cnt")
  int commentCnt;

  @JsonKey(name: "bmk_cnt")
  int boomkmarkCnt;

  @JsonKey(name: "share_cnt")
  int shareCnt;

  @JsonKey(name: "is_like")
  bool isLike;

  @JsonKey(name: "is_mine")
  bool isMine;

  @JsonKey(name: "bmk_id")
  int? bmkId;

  GetShortsResult(
    this.contentId,
    this.shortsId,
    this.profileId,
    this.profileType,
    this.profileImgKey,
    this.thumbImgKey,
    this.m3u8Key,
    this.nickname,
    this.tags,
    this.description,
    this.likeCnt,
    this.commentCnt,
    this.boomkmarkCnt,
    this.shareCnt,
    this.isLike,
    this.isMine,
    this.bmkId,
  );

  factory GetShortsResult.fromJson(Map<String, dynamic> json) =>
      _$GetShortsResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetShortsResultToJson(this);
}

@JsonSerializable()
class EditedShortsThumbnail {
  @JsonKey(name: "selected_thumb")
  final ShortsThumbnail selectedThumb;

  @JsonKey(name: "thumbs")
  final List<ShortsThumbnail> thumbs;

  EditedShortsThumbnail({required this.selectedThumb, required this.thumbs});

  factory EditedShortsThumbnail.fromJson(Map<String, dynamic> json) =>
      _$EditedShortsThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$EditedShortsThumbnailToJson(this);
}

@JsonSerializable()
class ShortsThumbnail {
  @JsonKey(name: "img_key")
  final String imgKey;

  @JsonKey(name: "is_selected")
  bool isSelected;

  ShortsThumbnail({required this.imgKey, required this.isSelected});

  factory ShortsThumbnail.fromJson(Map<String, dynamic> json) =>
      _$ShortsThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$ShortsThumbnailToJson(this);
}

@JsonSerializable()
class ShortsTag {
  @JsonKey(name: "idx_tag")
  final int idxTag;

  @JsonKey(name: "tags")
  final List<String> tags;

  ShortsTag({required this.idxTag, required this.tags});

  factory ShortsTag.fromJson(Map<String, dynamic> json) =>
      _$ShortsTagFromJson(json);
  Map<String, dynamic> toJson() => _$ShortsTagToJson(this);
}
