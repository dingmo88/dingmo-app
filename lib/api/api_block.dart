import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_block.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiBlock {
  factory ApiBlock(Dio dio) = _ApiBlock;

  @POST(Endpoints.block)
  Future<ApiBlankResponse> submit(@Body() PostBlockRequest request);
}

@JsonSerializable()
class PostBlockRequest {
  @JsonKey(name: "at_profi_id")
  final int atProfileId;

  @JsonKey(name: "enabled")
  final bool enabled;

  PostBlockRequest({required this.atProfileId, required this.enabled});

  factory PostBlockRequest.fromJson(Map<String, dynamic> json) =>
      _$PostBlockRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostBlockRequestToJson(this);
}
