import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_follow.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiFollow {
  factory ApiFollow(Dio dio) = _ApiFollow;

  @POST(Endpoints.follow)
  Future<ApiBlankResponse> submit(@Body() PostFollowRequest request);
}

@JsonSerializable()
class PostFollowRequest {
  @JsonKey(name: "at_profi_id")
  final int atProfileId;

  @JsonKey(name: "enabled")
  final bool enabled;

  PostFollowRequest({required this.atProfileId, required this.enabled});

  factory PostFollowRequest.fromJson(Map<String, dynamic> json) =>
      _$PostFollowRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostFollowRequestToJson(this);
}
