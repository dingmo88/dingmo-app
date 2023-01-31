import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_setting.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiSetting {
  factory ApiSetting(Dio dio) = _ApiSetting;

  @GET(Endpoints.setting)
  Future<ApiResponse<GetSettingResult>> get();

  @PATCH(Endpoints.setting)
  Future<ApiBlankResponse> update(@Body() PatchSettingRequest request);
}

@JsonSerializable()
class PatchSettingRequest {
  @JsonKey(name: "noti_cmt")
  final bool? notiCmt;

  @JsonKey(name: "noti_lik")
  final bool? notiLike;

  @JsonKey(name: "noti_inq")
  final bool? notiInquiry;

  @JsonKey(name: "noti_mention")
  final bool? notiMention;

  @JsonKey(name: "noti_push")
  final bool? notiPush;

  PatchSettingRequest(this.notiCmt, this.notiLike, this.notiInquiry,
      this.notiMention, this.notiPush);

  factory PatchSettingRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchSettingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PatchSettingRequestToJson(this);
}

@JsonSerializable()
class GetSettingResult {
  @JsonKey(name: "noti_cmt")
  final bool notiCmt;

  @JsonKey(name: "noti_lik")
  final bool notiLike;

  @JsonKey(name: "noti_inq")
  final bool notiInquiry;

  @JsonKey(name: "noti_mention")
  final bool notiMention;

  @JsonKey(name: "noti_push")
  final bool notiPush;

  GetSettingResult(this.notiCmt, this.notiLike, this.notiInquiry,
      this.notiMention, this.notiPush);

  factory GetSettingResult.fromJson(Map<String, dynamic> json) =>
      _$GetSettingResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetSettingResultToJson(this);
}
