import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_profile_comp.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiProfileComp {
  factory ApiProfileComp(Dio dio) = _ApiProfileComp;

  @GET(Endpoints.profileMypage)
  Future<ApiResponse<GetCompMypageResult>> mypage();

  @GET(Endpoints.profileCompMyinfo)
  Future<ApiResponse<GetCompMyinfoResult>> getMyinfo();

  @GET(Endpoints.profileCompForm)
  Future<ApiResponse<GetCompProfileFormResult>> getForm();

  @PATCH(Endpoints.profileCompForm)
  Future<ApiBlankResponse> updateForm(@Body() PatchCompProfileRequest request);

  @GET(Endpoints.profileComp)
  Future<ApiResponse<GetCompProfileResult>> get(
      @Queries() GetCompProfileRequest request);

  @GET(Endpoints.profileCompGuest)
  Future<ApiResponse<GetCompProfileResult>> getGuest(
      @Queries() GetCompProfileRequest request);

  @GET(Endpoints.profileCompPictos)
  Future<ApiResponse<List<GetCompProfilePictosResult>>> getPictos(
      @Queries() GetCompProfilePictosRequest request);
}

@JsonSerializable()
class GetCompMyinfoResult {
  @JsonKey(name: "email")
  final String email;

  @JsonKey(name: "corp_name")
  final String corpName;

  @JsonKey(name: "ceo_name")
  final String ceoName;

  GetCompMyinfoResult(
    this.email,
    this.corpName,
    this.ceoName,
  );

  factory GetCompMyinfoResult.fromJson(Map<String, dynamic> json) =>
      _$GetCompMyinfoResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetCompMyinfoResultToJson(this);
}

@JsonSerializable()
class PatchCompProfileRequest {
  @JsonKey(name: "form_key")
  final String formKey;

  @JsonKey(name: "profi_img_key")
  String? profiImgKey;

  @JsonKey(name: "nickname")
  String? nickname;

  @JsonKey(name: "area")
  PatchCompProfileArea? area;

  @JsonKey(name: "new_pictos")
  List<NewCompProfilePictorial>? newPictos;

  @JsonKey(name: "deleted_pictos")
  List<CompProfilePictorial>? deletedPictos;

  @JsonKey(name: "picto_mains")
  List<CompProfilePictorialMain>? pictorialMains;

  @JsonKey(name: "intro")
  String? intro;

  @JsonKey(name: "addr")
  String? addr;

  @JsonKey(name: "addr_details")
  String? addrDetails;

  @JsonKey(name: "addr_x")
  String? addrX;

  @JsonKey(name: "addr_y")
  String? addrY;

  @JsonKey(name: "work_time")
  String? workTime;

  @JsonKey(name: "consult_allow")
  bool? consultAllow;

  @JsonKey(name: "consult_days")
  List<String>? consultDays;

  @JsonKey(name: "consult_open_time")
  String? consultOpenTime;

  @JsonKey(name: "consult_close_time")
  String? consultCloseTime;

  PatchCompProfileRequest({
    required this.formKey,
  });

  factory PatchCompProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchCompProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PatchCompProfileRequestToJson(this);
}

@JsonSerializable()
class GetCompProfilePictosResult {
  @JsonKey(name: "img_key")
  final String imgKey;

  @JsonKey(name: "thumb_key")
  final String? thumbKey;

  GetCompProfilePictosResult(this.imgKey, this.thumbKey);

  factory GetCompProfilePictosResult.fromJson(Map<String, dynamic> json) =>
      _$GetCompProfilePictosResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetCompProfilePictosResultToJson(this);
}

@JsonSerializable()
class GetCompProfilePictosRequest {
  @JsonKey(name: "profile_id")
  final int profileId;

  @JsonKey(name: "page")
  final int page;

  @JsonKey(name: "size")
  final int size;

  GetCompProfilePictosRequest({
    required this.profileId,
    required this.page,
    required this.size,
  });

  factory GetCompProfilePictosRequest.fromJson(Map<String, dynamic> json) =>
      _$GetCompProfilePictosRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetCompProfilePictosRequestToJson(this);
}

@JsonSerializable()
class GetCompProfileRequest {
  @JsonKey(name: "profile_id")
  final int profileId;

  GetCompProfileRequest({required this.profileId});

  factory GetCompProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$GetCompProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetCompProfileRequestToJson(this);
}

@JsonSerializable()
class GetCompMypageResult {
  @JsonKey(name: "profile_id")
  final int profileId;

  @JsonKey(name: "profi_img_key")
  final String? profileImgKey;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "comp_type")
  final int compType;

  @JsonKey(name: "consult_allow")
  final bool consultAllow;

  GetCompMypageResult(
    this.profileId,
    this.profileImgKey,
    this.nickname,
    this.compType,
    this.consultAllow,
  );

  factory GetCompMypageResult.fromJson(Map<String, dynamic> json) =>
      _$GetCompMypageResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetCompMypageResultToJson(this);
}

@JsonSerializable()
class GetCompProfileFormResult {
  @JsonKey(name: "form_key")
  final String formKey;

  @JsonKey(name: "profi_img_key")
  final String? profiImgKey;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "consult_allow")
  final bool consultAllow;

  @JsonKey(name: "area")
  final GetCompProfileArea? area;

  @JsonKey(name: "pictorials")
  final List<CompProfilePictorial>? pictorials;

  @JsonKey(name: "picto_mains")
  final List<CompProfilePictorialMain>? pictorialMains;

  @JsonKey(name: "intro")
  final String? intro;

  @JsonKey(name: "addr")
  final String? addr;

  @JsonKey(name: "addr_details")
  final String? addrDetails;

  @JsonKey(name: "work_time")
  final String? workTime;

  @JsonKey(name: "consult_days")
  final List<String>? consultDays;

  @JsonKey(name: "consult_open_time")
  final String? consultOpenTime;

  @JsonKey(name: "consult_close_time")
  final String? consultCloseTime;

  GetCompProfileFormResult(
      {required this.formKey,
      required this.profiImgKey,
      required this.nickname,
      required this.area,
      required this.consultAllow,
      required this.pictorials,
      required this.pictorialMains,
      required this.intro,
      required this.addr,
      required this.addrDetails,
      required this.workTime,
      required this.consultDays,
      required this.consultOpenTime,
      required this.consultCloseTime});

  factory GetCompProfileFormResult.fromJson(Map<String, dynamic> json) =>
      _$GetCompProfileFormResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetCompProfileFormResultToJson(this);
}

@JsonSerializable()
class GetCompProfileResult {
  @JsonKey(name: "is_mine")
  final bool isMine;

  @JsonKey(name: "profi_id")
  final int profileId;

  @JsonKey(name: "cprofi_id")
  final int cprofileId;

  @JsonKey(name: "profi_img_key")
  final String? profileImgKey;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "intro")
  final String? intro;

  @JsonKey(name: "addr")
  final String? addr;

  @JsonKey(name: "addr_details")
  final String? addrDetails;

  @JsonKey(name: "addr_x")
  final String? addrX;

  @JsonKey(name: "addr_y")
  final String? addrY;

  @JsonKey(name: "work_time")
  final String? workTime;

  @JsonKey(name: "cprofi_type")
  final int compType;

  @JsonKey(name: "review_cnt")
  final int reviewCnt;

  @JsonKey(name: "consult_allow")
  final bool consultAllow;

  @JsonKey(name: "consult_days")
  final List<String> consultDays;

  @JsonKey(name: "consult_open_time")
  final String? consultOpenTime;

  @JsonKey(name: "consult_close_time")
  final String? consultCloseTime;

  @JsonKey(name: "main_pictos")
  final List<CompProfilePictorialMain> mainPictoImgKeys;

  @JsonKey(name: "ct_thumbs")
  final List<CompProfileContentThumbnail> thumbnails;

  // @JsonKey(name: "reviews")
  // final String reviews;

  @JsonKey(name: "is_follow")
  final bool isFollow;

  GetCompProfileResult(
    this.isMine,
    this.profileId,
    this.cprofileId,
    this.profileImgKey,
    this.nickname,
    this.intro,
    this.addr,
    this.addrDetails,
    this.addrX,
    this.addrY,
    this.workTime,
    this.compType,
    this.reviewCnt,
    this.consultAllow,
    this.consultDays,
    this.consultOpenTime,
    this.consultCloseTime,
    this.mainPictoImgKeys,
    this.thumbnails,
    // this.reviews
    this.isFollow,
  );

  factory GetCompProfileResult.fromJson(Map<String, dynamic> json) =>
      _$GetCompProfileResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetCompProfileResultToJson(this);
}

@JsonSerializable()
class CompProfileReview {
  @JsonKey(name: "rv_id")
  final int reviewId;

  @JsonKey(name: "rate")
  final int reviewRate;

  @JsonKey(name: "rv_type")
  final int reviewType;

  @JsonKey(name: "descr")
  final String description;

  @JsonKey(name: "content")
  final String content;

  @JsonKey(name: "view_cnt")
  final int viewCnt;

  @JsonKey(name: "cmt_cnt")
  final int cmtCnt;

  @JsonKey(name: "lik_cnt")
  final int likeCnt;

  @JsonKey(name: "dt")
  final String dateCreated;

  @JsonKey(name: "is_like")
  final bool isLike;

  CompProfileReview(
      {required this.reviewId,
      required this.reviewRate,
      required this.reviewType,
      required this.description,
      required this.content,
      required this.viewCnt,
      required this.cmtCnt,
      required this.likeCnt,
      required this.dateCreated,
      required this.isLike});

  factory CompProfileReview.fromJson(Map<String, dynamic> json) =>
      _$CompProfileReviewFromJson(json);
  Map<String, dynamic> toJson() => _$CompProfileReviewToJson(this);
}

// @JsonSerializable()
// class CompProfileReviewContent {
//   @JsonKey(name: "rls_id")
//   final int reelsId;

//   @JsonKey(name: "rls_thumb_key")
//   final int reelsThumbKey;

//   @JsonKey(name: "brd_id")
//   final String boardId;

//   @JsonKey(name: "brd_imgs")
//   final int viewCnt;

//   CompProfileReviewContent(
//       {required this.contentId,
//       required this.contentType,
//       required this.thumbImgKey,
//       required this.viewCnt});

//   factory CompProfileReviewContent.fromJson(Map<String, dynamic> json) =>
//       _$CompProfileReviewContentFromJson(json);
//   Map<String, dynamic> toJson() => _$CompProfileReviewContentToJson(this);
// }

@JsonSerializable()
class CompProfileContentThumbnail {
  @JsonKey(name: "ct_id")
  final int contentId;

  @JsonKey(name: "ct_type")
  final int contentType;

  @JsonKey(name: "thumb_key")
  final String thumbKey;

  @JsonKey(name: "view_cnt")
  final int viewCnt;

  CompProfileContentThumbnail(
      {required this.contentId,
      required this.contentType,
      required this.thumbKey,
      required this.viewCnt});

  factory CompProfileContentThumbnail.fromJson(Map<String, dynamic> json) =>
      _$CompProfileContentThumbnailFromJson(json);
  Map<String, dynamic> toJson() => _$CompProfileContentThumbnailToJson(this);
}

@JsonSerializable()
class CompProfilePictorialMain {
  @JsonKey(name: "img_key")
  final String imgKey;

  CompProfilePictorialMain({required this.imgKey});

  factory CompProfilePictorialMain.fromJson(Map<String, dynamic> json) =>
      _$CompProfilePictorialMainFromJson(json);
  Map<String, dynamic> toJson() => _$CompProfilePictorialMainToJson(this);
}

@JsonSerializable()
class GetCompProfileArea {
  @JsonKey(name: "area1_id")
  final int area1Id;

  @JsonKey(name: "area2_id")
  final int area2Id;

  @JsonKey(name: "area1_name")
  final String area1Name;

  @JsonKey(name: "area2_name")
  final String area2Name;

  GetCompProfileArea({
    required this.area1Id,
    required this.area2Id,
    required this.area1Name,
    required this.area2Name,
  });

  factory GetCompProfileArea.fromJson(Map<String, dynamic> json) =>
      _$GetCompProfileAreaFromJson(json);
  Map<String, dynamic> toJson() => _$GetCompProfileAreaToJson(this);
}

@JsonSerializable()
class PatchCompProfileArea {
  @JsonKey(name: "area1_id")
  final int area1Id;

  @JsonKey(name: "area2_id")
  final int area2Id;

  PatchCompProfileArea({
    required this.area1Id,
    required this.area2Id,
  });

  factory PatchCompProfileArea.fromJson(Map<String, dynamic> json) =>
      _$PatchCompProfileAreaFromJson(json);
  Map<String, dynamic> toJson() => _$PatchCompProfileAreaToJson(this);
}

@JsonSerializable()
class CompProfilePictorial {
  @JsonKey(name: "picto_id")
  final int pictoId;

  @JsonKey(name: "img_key")
  final String imgKey;

  @JsonKey(name: "thumb_key")
  final String thumbKey;

  @JsonKey(name: "is_main")
  bool isMain;

  @JsonKey(name: "main_prior")
  int priority;

  CompProfilePictorial(
    this.pictoId,
    this.imgKey,
    this.thumbKey,
    this.isMain,
    this.priority,
  );

  factory CompProfilePictorial.fromJson(Map<String, dynamic> json) =>
      _$CompProfilePictorialFromJson(json);
  Map<String, dynamic> toJson() => _$CompProfilePictorialToJson(this);
}

@JsonSerializable()
class NewCompProfilePictorial {
  @JsonKey(name: "img_key")
  final String imgKey;

  @JsonKey(name: "thumb_key")
  final String thumbKey;

  NewCompProfilePictorial({required this.imgKey, required this.thumbKey});

  factory NewCompProfilePictorial.fromJson(Map<String, dynamic> json) =>
      _$NewCompProfilePictorialFromJson(json);
  Map<String, dynamic> toJson() => _$NewCompProfilePictorialToJson(this);
}
