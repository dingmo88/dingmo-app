import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_content.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiContent {
  factory ApiContent(Dio dio) = _ApiContent;

  @GET(Endpoints.contentThumbnails)
  Future<ApiResponse<List<GetContentThumbResult>>> getThumbnails(
      @Queries() GetContentThumbRequest request);
}

@JsonSerializable()
class GetContentThumbRequest {
  @JsonKey(name: "profile_id")
  final int profileId;

  @JsonKey(name: "page")
  final int page;

  @JsonKey(name: "size")
  final int size;

  GetContentThumbRequest({
    required this.profileId,
    required this.page,
    required this.size,
  });
  factory GetContentThumbRequest.fromJson(Map<String, dynamic> json) =>
      _$GetContentThumbRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetContentThumbRequestToJson(this);
}

@JsonSerializable()
class GetContentThumbResult {
  @JsonKey(name: "ct_id")
  final int contentId;

  @JsonKey(name: "ct_type")
  final int contentType;

  @JsonKey(name: "thumb_key")
  final String thumbKey;

  @JsonKey(name: "view_cnt")
  final int viewCnt;

  GetContentThumbResult(
      this.contentId, this.contentType, this.thumbKey, this.viewCnt);
  factory GetContentThumbResult.fromJson(Map<String, dynamic> json) =>
      _$GetContentThumbResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetContentThumbResultToJson(this);
}
