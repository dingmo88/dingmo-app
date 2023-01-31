import 'package:dingmo/api/commons/page_request.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_like.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiLike {
  factory ApiLike(Dio dio) = _ApiLike;

  @GET(Endpoints.likeList)
  Future<ApiResponse<List<GetLikeResult>>> getList(
      @Queries() GetLikeRequest request);

  @POST(Endpoints.like)
  Future<ApiBlankResponse> submit(@Body() PostLikeRequest request);
}

@JsonSerializable()
class PostLikeRequest {
  @JsonKey(name: "like_type")
  final int likeType;

  @JsonKey(name: "at_id")
  final int atId;

  @JsonKey(name: "is_like")
  final bool isLike;

  PostLikeRequest(
      {required this.likeType, required this.atId, required this.isLike});

  factory PostLikeRequest.fromJson(Map<String, dynamic> json) =>
      _$PostLikeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostLikeRequestToJson(this);
}

@JsonSerializable()
class GetLikeResult {
  @JsonKey(name: "lik_id")
  final int likeId;

  @JsonKey(name: "profi_id")
  final int profileId;

  @JsonKey(name: "profi_type")
  final int profileType;

  @JsonKey(name: "cprofi_type")
  final int? cprofileType;

  @JsonKey(name: "profi_img_key")
  final String profileImgKey;

  @JsonKey(name: "profi_nick")
  final String nickname;

  GetLikeResult(this.likeId, this.profileId, this.profileType,
      this.cprofileType, this.profileImgKey, this.nickname);

  factory GetLikeResult.fromJson(Map<String, dynamic> json) =>
      _$GetLikeResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetLikeResultToJson(this);
}

@JsonSerializable()
class GetLikeRequest {
  @JsonKey(name: "content_id")
  final int contentId;

  @JsonKey(name: "page")
  final PageRequest page;

  GetLikeRequest({required this.contentId, required this.page});

  factory GetLikeRequest.fromJson(Map<String, dynamic> json) =>
      _$GetLikeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetLikeRequestToJson(this);
}
