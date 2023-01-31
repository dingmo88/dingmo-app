import 'package:dingmo/api/commons/api_response.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/endpoints.dart';

part 'api_exists.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiExists {
  factory ApiExists(Dio dio) = _ApiExists;

  @POST(Endpoints.existsEmail)
  Future<ApiResponse<PostEmailExistsResult>> email(
      @Body() PostEmailExistsRequest request);

  @POST(Endpoints.existsNickname)
  Future<ApiResponse<PostNicknameExistsResult>> nickname(
      @Body() PostNicknameExistsRequest request);
}

@JsonSerializable()
class PostEmailExistsRequest {
  @JsonKey(name: "email")
  final String email;

  PostEmailExistsRequest({required this.email});

  factory PostEmailExistsRequest.fromJson(Map<String, dynamic> json) =>
      _$PostEmailExistsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostEmailExistsRequestToJson(this);
}

@JsonSerializable()
class PostNicknameExistsRequest {
  @JsonKey(name: "nickname")
  final String nickname;

  PostNicknameExistsRequest({required this.nickname});

  factory PostNicknameExistsRequest.fromJson(Map<String, dynamic> json) =>
      _$PostNicknameExistsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostNicknameExistsRequestToJson(this);
}

@JsonSerializable()
class PostEmailExistsResult {
  @JsonKey(name: "exists")
  final bool exists;

  @JsonKey(name: "social_type")
  final int socialType;

  PostEmailExistsResult({required this.exists, required this.socialType});

  factory PostEmailExistsResult.fromJson(Map<String, dynamic> json) =>
      _$PostEmailExistsResultFromJson(json);
  Map<String, dynamic> toJson() => _$PostEmailExistsResultToJson(this);
}

@JsonSerializable()
class PostNicknameExistsResult {
  @JsonKey(name: "exists")
  final bool exists;

  PostNicknameExistsResult({required this.exists});

  factory PostNicknameExistsResult.fromJson(Map<String, dynamic> json) =>
      _$PostNicknameExistsResultFromJson(json);
  Map<String, dynamic> toJson() => _$PostNicknameExistsResultToJson(this);
}
