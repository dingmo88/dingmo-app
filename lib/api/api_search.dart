import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_search.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiSearch {
  factory ApiSearch(Dio dio) = _ApiSearch;

  @GET(Endpoints.search)
  Future<ApiResponse<GetSearchResult>> get(@Queries() GetSearchRequest request);

  @GET(Endpoints.searchGuest)
  Future<ApiResponse<GetSearchResult>> getGuest(
      @Queries() GetSearchRequest request);

  @GET(Endpoints.searchHome)
  Future<ApiResponse<GetHomeResult>> getHome();

  @GET(Endpoints.searchHomeGuest)
  Future<ApiResponse<GetHomeResult>> getHomeGuest();

  @GET(Endpoints.searchContent)
  Future<ApiResponse<List<GetSearchContentResult>>> getContent(
      @Queries() GetSearchRequest request);

  @GET(Endpoints.searchContentGuest)
  Future<ApiResponse<List<GetSearchContentResult>>> getContentGuest(
      @Queries() GetSearchRequest request);

  @GET(Endpoints.searchContentIdxTag)
  Future<ApiResponse<List<GetSearchContentResult>>> getContentIdxTag(
      @Queries() GetSearchIdxTagRequest request);

  @GET(Endpoints.searchContentIdxTagGuest)
  Future<ApiResponse<List<GetSearchContentResult>>> getContentIdxTagGuest(
      @Queries() GetSearchIdxTagRequest request);

  @GET(Endpoints.searchProfile)
  Future<ApiResponse<List<GetSearchProfileResult>>> getProfile(
      @Queries() GetSearchProfileRequest request);

  @GET(Endpoints.searchProfileGuest)
  Future<ApiResponse<List<GetSearchProfileResult>>> getProfileGuest(
      @Queries() GetSearchProfileRequest request);

  @GET(Endpoints.searchProfileComp)
  Future<ApiResponse<List<GetSearchProfileResult>>> getProfileComp(
      @Queries() GetSearchCompProfileRequest request);

  @GET(Endpoints.searchProfileCompGuest)
  Future<ApiResponse<List<GetSearchProfileResult>>> getProfileCompGuest(
      @Queries() GetSearchCompProfileRequest request);

  // for review.
  @GET(Endpoints.searchReviewable)
  Future<ApiResponse<List<GetSearchReviewableResult>>> getReviewable(
      @Queries() GetSearchReviewableRequest request);

  @GET(Endpoints.searchContentPanel)
  Future<ApiResponse<GetSearchPanelResult>> getContentPanel();

  @GET(Endpoints.searchHistory)
  Future<ApiResponse<List<GetSearchHistoryResult>>> getHistory();

  @DELETE(Endpoints.searchHistory)
  Future<ApiBlankResponse> deleteHistory(@Body() DeleteHistoryRequest request);
}

@JsonSerializable()
class GetSearchProfileResult {
  @JsonKey(name: "is_mine")
  final bool isMine;

  @JsonKey(name: "profi_id")
  final int profileId;

  @JsonKey(name: "profi_img_key")
  final String? profiImgKey;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "thumbs")
  final List<GetSearchCompProfileThumb> thumbs;

  @JsonKey(name: "is_follow")
  final bool isFollow;

  GetSearchProfileResult(this.isMine, this.profileId, this.profiImgKey,
      this.nickname, this.thumbs, this.isFollow);

  factory GetSearchProfileResult.fromJson(Map<String, dynamic> json) =>
      _$GetSearchProfileResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchProfileResultToJson(this);
}

@JsonSerializable()
class DeleteHistoryRequest {
  @JsonKey(name: "history_id")
  final int historyId;

  DeleteHistoryRequest({required this.historyId});

  factory DeleteHistoryRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteHistoryRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteHistoryRequestToJson(this);
}

@JsonSerializable()
class GetSearchCompProfileThumb {
  @JsonKey(name: "ct_id")
  final int contentId;

  @JsonKey(name: "ct_type")
  final int contentType;

  @JsonKey(name: "thumb_key")
  final String thumbKey;

  @JsonKey(name: "view_cnt")
  final int viewCnt;

  GetSearchCompProfileThumb(
      this.contentId, this.contentType, this.thumbKey, this.viewCnt);

  factory GetSearchCompProfileThumb.fromJson(Map<String, dynamic> json) =>
      _$GetSearchCompProfileThumbFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchCompProfileThumbToJson(this);
}

@JsonSerializable()
class GetSearchCompProfileRequest {
  @JsonKey(name: "comp_type")
  final int compType;

  @JsonKey(name: "page")
  final int page;

  @JsonKey(name: "size")
  final int size;

  GetSearchCompProfileRequest(
      {required this.compType, required this.page, required this.size});

  factory GetSearchCompProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$GetSearchCompProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchCompProfileRequestToJson(this);
}

@JsonSerializable()
class GetSearchProfileRequest {
  @JsonKey(name: "profi_type")
  final int memberType;

  @JsonKey(name: "keyword")
  final String? keyword;

  @JsonKey(name: "page")
  final int page;

  @JsonKey(name: "size")
  final int size;

  GetSearchProfileRequest(
      {required this.memberType,
      required this.keyword,
      required this.page,
      required this.size});

  factory GetSearchProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$GetSearchProfileRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchProfileRequestToJson(this);
}

@JsonSerializable()
class GetHomeResult {
  @JsonKey(name: "banners")
  final List<HomeBanner> banners;

  @JsonKey(name: "planners")
  final List<HomePlanSimple> planners;

  @JsonKey(name: "contents")
  final List<HomeContentsWithTag> contents;

  GetHomeResult(this.banners, this.planners, this.contents);

  factory GetHomeResult.fromJson(Map<String, dynamic> json) =>
      _$GetHomeResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetHomeResultToJson(this);
}

@JsonSerializable()
class HomeBanner {
  @JsonKey(name: "bann_id")
  final int bannId;

  @JsonKey(name: "bann_img_key")
  final String bannImgKey;

  HomeBanner({required this.bannId, required this.bannImgKey});

  factory HomeBanner.fromJson(Map<String, dynamic> json) =>
      _$HomeBannerFromJson(json);
  Map<String, dynamic> toJson() => _$HomeBannerToJson(this);
}

@JsonSerializable()
class HomePlanSimple {
  @JsonKey(name: "profi_id")
  final int profileId;

  @JsonKey(name: "profi_img_key")
  final String? profileImgKey;

  @JsonKey(name: "nickname")
  final String nickname;

  HomePlanSimple(
      {required this.profileId, this.profileImgKey, required this.nickname});

  factory HomePlanSimple.fromJson(Map<String, dynamic> json) =>
      _$HomePlanSimpleFromJson(json);
  Map<String, dynamic> toJson() => _$HomePlanSimpleToJson(this);
}

@JsonSerializable()
class HomeContentsWithTag {
  @JsonKey(name: "idx_tag")
  final int idxTag;

  @JsonKey(name: "contents")
  final List<HomeContents> contents;

  HomeContentsWithTag({required this.idxTag, required this.contents});

  factory HomeContentsWithTag.fromJson(Map<String, dynamic> json) =>
      _$HomeContentsWithTagFromJson(json);
  Map<String, dynamic> toJson() => _$HomeContentsWithTagToJson(this);
}

@JsonSerializable()
class HomeContents {
  @JsonKey(name: "ct_id")
  final int contentId;

  @JsonKey(name: "ct_type")
  final int contentType;

  @JsonKey(name: "summary")
  final String summary;

  @JsonKey(name: "thumb_key")
  final String thumbKey;

  @JsonKey(name: "view_cnt")
  final int viewCnt;

  @JsonKey(name: "is_like")
  final bool isLike;

  HomeContents(
      {required this.contentId,
      required this.contentType,
      required this.summary,
      required this.thumbKey,
      required this.viewCnt,
      required this.isLike});

  factory HomeContents.fromJson(Map<String, dynamic> json) =>
      _$HomeContentsFromJson(json);
  Map<String, dynamic> toJson() => _$HomeContentsToJson(this);
}

@JsonSerializable()
class GetSearchPanelResult {
  @JsonKey(name: "popular_kwds")
  final List<String> popularKeywords;

  @JsonKey(name: "contents")
  final List<SearchPanelContentSimple> contents;

  GetSearchPanelResult(
    this.popularKeywords,
    this.contents,
  );

  factory GetSearchPanelResult.fromJson(Map<String, dynamic> json) =>
      _$GetSearchPanelResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchPanelResultToJson(this);
}

@JsonSerializable()
class GetSearchResult {
  @JsonKey(name: "planners")
  final List<SearchPlannerSimple> planners;

  @JsonKey(name: "contents")
  final List<GetSearchContentResult> contents;

  GetSearchResult(
    this.planners,
    this.contents,
  );

  factory GetSearchResult.fromJson(Map<String, dynamic> json) =>
      _$GetSearchResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchResultToJson(this);
}

@JsonSerializable()
class GetSearchHistoryResult {
  @JsonKey(name: "history_id")
  final int historyId;

  @JsonKey(name: "keyword")
  final String keyword;

  GetSearchHistoryResult(
    this.historyId,
    this.keyword,
  );

  factory GetSearchHistoryResult.fromJson(Map<String, dynamic> json) =>
      _$GetSearchHistoryResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchHistoryResultToJson(this);
}

@JsonSerializable()
class GetSearchReviewableResult {
  @JsonKey(name: "cprofi_id")
  final int cprofileId;

  @JsonKey(name: "profi_img_key")
  final String? profileImgKey;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "comp_type")
  final int compType;

  GetSearchReviewableResult(
      this.cprofileId, this.profileImgKey, this.nickname, this.compType);

  factory GetSearchReviewableResult.fromJson(Map<String, dynamic> json) =>
      _$GetSearchReviewableResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchReviewableResultToJson(this);
}

@JsonSerializable()
class GetSearchReviewableRequest {
  @JsonKey(name: "keyword")
  final int keyword;

  @JsonKey(name: "page")
  final String page;

  GetSearchReviewableRequest({required this.keyword, required this.page});

  factory GetSearchReviewableRequest.fromJson(Map<String, dynamic> json) =>
      _$GetSearchReviewableRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchReviewableRequestToJson(this);
}

@JsonSerializable()
class GetSearchIdxTagRequest {
  @JsonKey(name: "idx_tag")
  final int idxTag;

  @JsonKey(name: "page")
  final int page;

  @JsonKey(name: "size")
  final int size;

  GetSearchIdxTagRequest(
      {required this.idxTag, required this.page, required this.size});

  factory GetSearchIdxTagRequest.fromJson(Map<String, dynamic> json) =>
      _$GetSearchIdxTagRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchIdxTagRequestToJson(this);
}

@JsonSerializable()
class GetSearchRequest {
  @JsonKey(name: "keyword")
  final String keyword;

  @JsonKey(name: "area1_id")
  final int area1Id;

  @JsonKey(name: "area2_id")
  final int area2Id;

  @JsonKey(name: "page")
  final int page;

  @JsonKey(name: "size")
  final int size;

  GetSearchRequest(
      {required this.keyword,
      required this.area1Id,
      required this.area2Id,
      required this.page,
      required this.size});

  factory GetSearchRequest.fromJson(Map<String, dynamic> json) =>
      _$GetSearchRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchRequestToJson(this);
}

@JsonSerializable()
class SearchPlannerSimple {
  @JsonKey(name: "profi_id")
  final int profileId;

  @JsonKey(name: "profi_img_key")
  final String? profileImgKey;

  @JsonKey(name: "nickname")
  final String nickname;

  SearchPlannerSimple(
      {required this.profileId, this.profileImgKey, required this.nickname});

  factory SearchPlannerSimple.fromJson(Map<String, dynamic> json) =>
      _$SearchPlannerSimpleFromJson(json);
  Map<String, dynamic> toJson() => _$SearchPlannerSimpleToJson(this);
}

@JsonSerializable()
class SearchPanelContentSimple {
  @JsonKey(name: "ct_id")
  final int contentId;

  @JsonKey(name: "ct_type")
  final int contentType;

  @JsonKey(name: "nickname")
  final String nickname;

  @JsonKey(name: "thumb_key")
  final String thumbImgKey;

  @JsonKey(name: "summary")
  final String summary;

  SearchPanelContentSimple({
    required this.contentId,
    required this.contentType,
    required this.nickname,
    required this.thumbImgKey,
    required this.summary,
  });

  factory SearchPanelContentSimple.fromJson(Map<String, dynamic> json) =>
      _$SearchPanelContentSimpleFromJson(json);
  Map<String, dynamic> toJson() => _$SearchPanelContentSimpleToJson(this);
}

@JsonSerializable()
class GetSearchContentResult {
  @JsonKey(name: "ct_id")
  final int contentId;

  @JsonKey(name: "ct_type")
  final int contentType;

  @JsonKey(name: "thumb_key")
  final String thumbImgKey;

  @JsonKey(name: "summary")
  final String summary;

  @JsonKey(name: "view_cnt")
  final int viewCnt;

  @JsonKey(name: "bmk_cnt")
  final int bmkCnt;

  @JsonKey(name: "bmk_id")
  final int? bmkId;

  GetSearchContentResult(
      {required this.contentId,
      required this.contentType,
      required this.thumbImgKey,
      required this.summary,
      required this.viewCnt,
      required this.bmkCnt,
      required this.bmkId});

  factory GetSearchContentResult.fromJson(Map<String, dynamic> json) =>
      _$GetSearchContentResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchContentResultToJson(this);
}
