import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_profile_plan.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiProfilePlan {
  factory ApiProfilePlan(Dio dio) = _ApiProfilePlan;

  @GET(Endpoints.profileMypage)
  Future<ApiResponse<GetPlanMypageResult>> mypage();

  @GET(Endpoints.profilePlanMyinfo)
  Future<ApiResponse<GetPlanMyinfoResult>> getMyinfo();

  @PATCH(Endpoints.profilePlanMyinfo)
  Future<ApiBlankResponse> updateMyinfo(@Body() PatchPlanMyinfoRequest request);

  @GET(Endpoints.profilePlanForm)
  Future<ApiResponse<GetPlanProfileFormResult>> getForm();

  @PATCH(Endpoints.profilePlanForm)
  Future<ApiBlankResponse> updateForm(@Body() PatchPlanProfileRequest request);

  @GET(Endpoints.profilePlan)
  Future<ApiResponse<GetPlanProfileResult>> get(
      @Queries() GetPlanProfileRequest request);

  @GET(Endpoints.profilePlanGuest)
  Future<ApiResponse<GetPlanProfileResult>> getGuest(
      @Queries() GetPlanProfileRequest request);
}

@JsonSerializable()
class PatchPlanMyinfoRequest {
  @JsonKey(name: "team_name")
  final String? teamName;

  @JsonKey(name: "personal")
  final PlanMyinfoPersonal? personal;

  PatchPlanMyinfoRequest({
    this.teamName,
    this.personal,
  });

  factory PatchPlanMyinfoRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchPlanMyinfoRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PatchPlanMyinfoRequestToJson(this);
}

@JsonSerializable()
class GetPlanMyinfoResult {
  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "phone")
  final String phone;

  @JsonKey(name: "team_name")
  final String? teamName;

  GetPlanMyinfoResult(this.email, this.phone, this.teamName);

  factory GetPlanMyinfoResult.fromJson(Map<String, dynamic> json) =>
      _$GetPlanMyinfoResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetPlanMyinfoResultToJson(this);
}

@JsonSerializable()
class PatchPlanProfileRequest {
  @JsonKey(name: "form_key")
  final String formKey;

  @JsonKey(name: "profi_img_key")
  String? profiImgKey;

  @JsonKey(name: "nickname")
  String? nickname;

  @JsonKey(name: "consult_allow")
  bool? consultAllow;

  @JsonKey(name: "area")
  PatchPlanProfileArea? area;

  @JsonKey(name: "intro")
  String? intro;

  @JsonKey(name: "consult_days")
  List<String>? consultDays;

  @JsonKey(name: "consult_open_time")
  String? consultOpenTime;

  @JsonKey(name: "consult_close_time")
  String? consultCloseTime;

  PatchPlanProfileRequest({
    required this.formKey,
  });

  factory PatchPlanProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchPlanProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PatchPlanProfileRequestToJson(this);
}

@JsonSerializable()
class GetPlanProfileRequest {
  @JsonKey(name: "profile_id")
  final int profileId;

  GetPlanProfileRequest({required this.profileId});

  factory GetPlanProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$GetPlanProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetPlanProfileRequestToJson(this);
}

@JsonSerializable()
class GetPlanProfileFormResult {
  @JsonKey(name: "form_key")
  final String formKey;

  @JsonKey(name: "profi_img_key")
  final String? profiImgKey;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "consult_allow")
  final bool consultAllow;

  @JsonKey(name: "area")
  final GetPlanProfileArea? area;

  @JsonKey(name: "intro")
  final String? intro;

  @JsonKey(name: "consult_days")
  final List<String>? consultDays;

  @JsonKey(name: "consult_open_time")
  final String? consultOpenTime;

  @JsonKey(name: "consult_close_time")
  final String? consultCloseTime;

  GetPlanProfileFormResult(
      {required this.formKey,
      required this.profiImgKey,
      required this.nickname,
      required this.consultAllow,
      required this.area,
      required this.intro,
      required this.consultDays,
      required this.consultOpenTime,
      required this.consultCloseTime});

  factory GetPlanProfileFormResult.fromJson(Map<String, dynamic> json) =>
      _$GetPlanProfileFormResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetPlanProfileFormResultToJson(this);
}

@JsonSerializable()
class GetPlanMypageResult {
  @JsonKey(name: "profile_id")
  final int profileId;

  @JsonKey(name: "profi_img_key")
  final String? profileImgKey;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "consult_allow")
  final bool consultAllow;

  GetPlanMypageResult(
    this.profileId,
    this.profileImgKey,
    this.nickname,
    this.consultAllow,
  );

  factory GetPlanMypageResult.fromJson(Map<String, dynamic> json) =>
      _$GetPlanMypageResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetPlanMypageResultToJson(this);
}

@JsonSerializable()
class GetPlanProfileResult {
  @JsonKey(name: "is_mine")
  final bool isMine;

  @JsonKey(name: "profi_id")
  final int profileId;

  @JsonKey(name: "pprofi_id")
  final int pprofileId;

  @JsonKey(name: "profi_img_key")
  final String? profileImgKey;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "intro")
  final String? intro;

  @JsonKey(name: "active_area")
  final String? activeArea;

  @JsonKey(name: "consult_allow")
  final bool consultAllow;

  @JsonKey(name: "consult_days")
  final List<String> consultDays;

  @JsonKey(name: "consult_open_time")
  final String? consultOpenTime;

  @JsonKey(name: "consult_close_time")
  final String? consultCloseTime;

  @JsonKey(name: "ct_thumbs")
  final List<PlanProfileContentThumbnail> thumbnails;

  // @JsonKey(name: "review_cnt")
  // final int reviewCnt;

  // @JsonKey(name: "reviews")
  // final String reviews;

  GetPlanProfileResult(
      this.isMine,
      this.profileId,
      this.pprofileId,
      this.profileImgKey,
      this.nickname,
      this.intro,
      this.activeArea,
      this.consultAllow,
      this.consultDays,
      this.consultOpenTime,
      this.consultCloseTime,
      this.thumbnails);

  factory GetPlanProfileResult.fromJson(Map<String, dynamic> json) =>
      _$GetPlanProfileResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetPlanProfileResultToJson(this);
}

@JsonSerializable()
class PlanProfileContentThumbnail {
  @JsonKey(name: "ct_id")
  final int contentId;

  @JsonKey(name: "ct_type")
  final int contentType;

  @JsonKey(name: "thumb_key")
  final String thumbKey;

  @JsonKey(name: "view_cnt")
  final int viewCnt;

  PlanProfileContentThumbnail(
      {required this.contentId,
      required this.contentType,
      required this.thumbKey,
      required this.viewCnt});

  factory PlanProfileContentThumbnail.fromJson(Map<String, dynamic> json) =>
      _$PlanProfileContentThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$PlanProfileContentThumbnailToJson(this);
}

@JsonSerializable()
class PlanMyinfoPersonal {
  @JsonKey(name: "phone")
  final String phone;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "birth")
  final String birth;

  PlanMyinfoPersonal(this.phone, this.name, this.birth);

  factory PlanMyinfoPersonal.fromJson(Map<String, dynamic> json) =>
      _$PlanMyinfoPersonalFromJson(json);
  Map<String, dynamic> toJson() => _$PlanMyinfoPersonalToJson(this);
}

@JsonSerializable()
class GetPlanProfileArea {
  @JsonKey(name: "area1_id")
  final int area1Id;

  @JsonKey(name: "area2_id")
  final int area2Id;

  @JsonKey(name: "area1_name")
  final String area1Name;

  @JsonKey(name: "area2_name")
  final String area2Name;

  GetPlanProfileArea({
    required this.area1Id,
    required this.area2Id,
    required this.area1Name,
    required this.area2Name,
  });

  factory GetPlanProfileArea.fromJson(Map<String, dynamic> json) =>
      _$GetPlanProfileAreaFromJson(json);
  Map<String, dynamic> toJson() => _$GetPlanProfileAreaToJson(this);
}

@JsonSerializable()
class PatchPlanProfileArea {
  @JsonKey(name: "area1_id")
  final int area1Id;

  @JsonKey(name: "area2_id")
  final int area2Id;

  PatchPlanProfileArea({
    required this.area1Id,
    required this.area2Id,
  });

  factory PatchPlanProfileArea.fromJson(Map<String, dynamic> json) =>
      _$PatchPlanProfileAreaFromJson(json);
  Map<String, dynamic> toJson() => _$PatchPlanProfileAreaToJson(this);
}
