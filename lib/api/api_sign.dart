import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_sign.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiSign {
  factory ApiSign(Dio dio) = _ApiSign;

  @POST(Endpoints.signUpComp)
  Future<ApiBlankResponse> signUpComp(@Body() PostCompSignUpRequest request);

  @POST(Endpoints.signUpPlan)
  Future<ApiBlankResponse> signUpPlan(@Body() PostPlanSignUpRequest request);

  @POST(Endpoints.login)
  Future<ApiResponse<PostLoginResult>> login(@Body() PostLoginRequest request);

  @POST(Endpoints.resign)
  Future<ApiBlankResponse> resign();
}

@JsonSerializable()
class PostLoginResult {
  @JsonKey(name: "social_type")
  final int socialType;

  @JsonKey(name: "member_type")
  final int memberType;

  @JsonKey(name: "access_token")
  final String accessToken;

  PostLoginResult(
      {required this.memberType,
      required this.socialType,
      required this.accessToken});

  factory PostLoginResult.fromJson(Map<String, dynamic> json) =>
      _$PostLoginResultFromJson(json);
  Map<String, dynamic> toJson() => _$PostLoginResultToJson(this);
}

@JsonSerializable()
class PostLoginRequest {
  @JsonKey(name: "amp_uid")
  final String ampUid;

  PostLoginRequest({required this.ampUid});

  factory PostLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$PostLoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostLoginRequestToJson(this);
}

@JsonSerializable()
class PostCompSignUpRequest {
  @JsonKey(name: "amp_uid")
  final String ampUid;

  @JsonKey(name: "social_type")
  final int socialType;

  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "comp_reg_num")
  final String comRegNum;

  @JsonKey(name: "comp_type")
  final int compType;

  @JsonKey(name: "corp_name")
  final String corpName;

  @JsonKey(name: "ceo_name")
  final String ceoName;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "addr")
  final String address;

  @JsonKey(name: "addr_details")
  final String addressDetails;

  @JsonKey(name: "addr_x")
  final String addrX;

  @JsonKey(name: "addr_y")
  final String addrY;

  @JsonKey(name: "noti_event")
  final bool notiEvent;

  PostCompSignUpRequest({
    required this.ampUid,
    required this.socialType,
    required this.email,
    required this.comRegNum,
    required this.compType,
    required this.corpName,
    required this.ceoName,
    required this.nickname,
    required this.address,
    required this.addressDetails,
    required this.addrX,
    required this.addrY,
    required this.notiEvent,
  });

  factory PostCompSignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$PostCompSignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostCompSignUpRequestToJson(this);
}

@JsonSerializable()
class PostPlanSignUpRequest {
  @JsonKey(name: "amp_uid")
  final String ampUid;

  @JsonKey(name: "social_type")
  final int socialType;

  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "team_name")
  final String? teamName;

  @JsonKey(name: "phone")
  final String? phone;

  @JsonKey(name: "name")
  final String? name;

  @JsonKey(name: "nickname")
  final String? nickname;

  @JsonKey(name: "birth")
  final String birth;

  @JsonKey(name: "noti_event")
  final bool notiEvent;

  PostPlanSignUpRequest({
    required this.ampUid,
    required this.socialType,
    required this.email,
    required this.teamName,
    required this.phone,
    required this.name,
    required this.nickname,
    required this.birth,
    required this.notiEvent,
  });

  factory PostPlanSignUpRequest.fromJson(Map<String, dynamic> json) =>
      _$PostPlanSignUpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostPlanSignUpRequestToJson(this);
}
