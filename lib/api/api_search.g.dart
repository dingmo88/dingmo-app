// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetSearchProfileResult _$GetSearchProfileResultFromJson(
        Map<String, dynamic> json) =>
    GetSearchProfileResult(
      json['is_mine'] as bool,
      json['profi_id'] as int,
      json['profi_img_key'] as String?,
      json['nickname'] as String,
      (json['thumbs'] as List<dynamic>)
          .map((e) =>
              GetSearchCompProfileThumb.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['is_follow'] as bool,
    );

Map<String, dynamic> _$GetSearchProfileResultToJson(
        GetSearchProfileResult instance) =>
    <String, dynamic>{
      'is_mine': instance.isMine,
      'profi_id': instance.profileId,
      'profi_img_key': instance.profiImgKey,
      'nickname': instance.nickname,
      'thumbs': instance.thumbs,
      'is_follow': instance.isFollow,
    };

DeleteHistoryRequest _$DeleteHistoryRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteHistoryRequest(
      historyId: json['history_id'] as int,
    );

Map<String, dynamic> _$DeleteHistoryRequestToJson(
        DeleteHistoryRequest instance) =>
    <String, dynamic>{
      'history_id': instance.historyId,
    };

GetSearchCompProfileThumb _$GetSearchCompProfileThumbFromJson(
        Map<String, dynamic> json) =>
    GetSearchCompProfileThumb(
      json['ct_id'] as int,
      json['ct_type'] as int,
      json['thumb_key'] as String,
      json['view_cnt'] as int,
    );

Map<String, dynamic> _$GetSearchCompProfileThumbToJson(
        GetSearchCompProfileThumb instance) =>
    <String, dynamic>{
      'ct_id': instance.contentId,
      'ct_type': instance.contentType,
      'thumb_key': instance.thumbKey,
      'view_cnt': instance.viewCnt,
    };

GetSearchCompProfileRequest _$GetSearchCompProfileRequestFromJson(
        Map<String, dynamic> json) =>
    GetSearchCompProfileRequest(
      compType: json['comp_type'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$GetSearchCompProfileRequestToJson(
        GetSearchCompProfileRequest instance) =>
    <String, dynamic>{
      'comp_type': instance.compType,
      'page': instance.page,
      'size': instance.size,
    };

GetSearchProfileRequest _$GetSearchProfileRequestFromJson(
        Map<String, dynamic> json) =>
    GetSearchProfileRequest(
      memberType: json['profi_type'] as int,
      keyword: json['keyword'] as String?,
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$GetSearchProfileRequestToJson(
        GetSearchProfileRequest instance) =>
    <String, dynamic>{
      'profi_type': instance.memberType,
      'keyword': instance.keyword,
      'page': instance.page,
      'size': instance.size,
    };

GetHomeResult _$GetHomeResultFromJson(Map<String, dynamic> json) =>
    GetHomeResult(
      (json['banners'] as List<dynamic>)
          .map((e) => HomeBanner.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['planners'] as List<dynamic>)
          .map((e) => HomePlanSimple.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['contents'] as List<dynamic>)
          .map((e) => HomeContentsWithTag.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetHomeResultToJson(GetHomeResult instance) =>
    <String, dynamic>{
      'banners': instance.banners,
      'planners': instance.planners,
      'contents': instance.contents,
    };

HomeBanner _$HomeBannerFromJson(Map<String, dynamic> json) => HomeBanner(
      bannId: json['bann_id'] as int,
      bannImgKey: json['bann_img_key'] as String,
    );

Map<String, dynamic> _$HomeBannerToJson(HomeBanner instance) =>
    <String, dynamic>{
      'bann_id': instance.bannId,
      'bann_img_key': instance.bannImgKey,
    };

HomePlanSimple _$HomePlanSimpleFromJson(Map<String, dynamic> json) =>
    HomePlanSimple(
      profileId: json['profi_id'] as int,
      profileImgKey: json['profi_img_key'] as String?,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$HomePlanSimpleToJson(HomePlanSimple instance) =>
    <String, dynamic>{
      'profi_id': instance.profileId,
      'profi_img_key': instance.profileImgKey,
      'nickname': instance.nickname,
    };

HomeContentsWithTag _$HomeContentsWithTagFromJson(Map<String, dynamic> json) =>
    HomeContentsWithTag(
      idxTag: json['idx_tag'] as int,
      contents: (json['contents'] as List<dynamic>)
          .map((e) => HomeContents.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HomeContentsWithTagToJson(
        HomeContentsWithTag instance) =>
    <String, dynamic>{
      'idx_tag': instance.idxTag,
      'contents': instance.contents,
    };

HomeContents _$HomeContentsFromJson(Map<String, dynamic> json) => HomeContents(
      contentId: json['ct_id'] as int,
      contentType: json['ct_type'] as int,
      summary: json['summary'] as String,
      thumbKey: json['thumb_key'] as String,
      viewCnt: json['view_cnt'] as int,
      isLike: json['is_like'] as bool,
    );

Map<String, dynamic> _$HomeContentsToJson(HomeContents instance) =>
    <String, dynamic>{
      'ct_id': instance.contentId,
      'ct_type': instance.contentType,
      'summary': instance.summary,
      'thumb_key': instance.thumbKey,
      'view_cnt': instance.viewCnt,
      'is_like': instance.isLike,
    };

GetSearchPanelResult _$GetSearchPanelResultFromJson(
        Map<String, dynamic> json) =>
    GetSearchPanelResult(
      (json['popular_kwds'] as List<dynamic>).map((e) => e as String).toList(),
      (json['contents'] as List<dynamic>)
          .map((e) =>
              SearchPanelContentSimple.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSearchPanelResultToJson(
        GetSearchPanelResult instance) =>
    <String, dynamic>{
      'popular_kwds': instance.popularKeywords,
      'contents': instance.contents,
    };

GetSearchResult _$GetSearchResultFromJson(Map<String, dynamic> json) =>
    GetSearchResult(
      (json['planners'] as List<dynamic>)
          .map((e) => SearchPlannerSimple.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['contents'] as List<dynamic>)
          .map(
              (e) => GetSearchContentResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetSearchResultToJson(GetSearchResult instance) =>
    <String, dynamic>{
      'planners': instance.planners,
      'contents': instance.contents,
    };

GetSearchHistoryResult _$GetSearchHistoryResultFromJson(
        Map<String, dynamic> json) =>
    GetSearchHistoryResult(
      json['history_id'] as int,
      json['keyword'] as String,
    );

Map<String, dynamic> _$GetSearchHistoryResultToJson(
        GetSearchHistoryResult instance) =>
    <String, dynamic>{
      'history_id': instance.historyId,
      'keyword': instance.keyword,
    };

GetSearchReviewableResult _$GetSearchReviewableResultFromJson(
        Map<String, dynamic> json) =>
    GetSearchReviewableResult(
      json['cprofi_id'] as int,
      json['profi_img_key'] as String?,
      json['nickname'] as String,
      json['comp_type'] as int,
    );

Map<String, dynamic> _$GetSearchReviewableResultToJson(
        GetSearchReviewableResult instance) =>
    <String, dynamic>{
      'cprofi_id': instance.cprofileId,
      'profi_img_key': instance.profileImgKey,
      'nickname': instance.nickname,
      'comp_type': instance.compType,
    };

GetSearchReviewableRequest _$GetSearchReviewableRequestFromJson(
        Map<String, dynamic> json) =>
    GetSearchReviewableRequest(
      keyword: json['keyword'] as int,
      page: json['page'] as String,
    );

Map<String, dynamic> _$GetSearchReviewableRequestToJson(
        GetSearchReviewableRequest instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'page': instance.page,
    };

GetSearchIdxTagRequest _$GetSearchIdxTagRequestFromJson(
        Map<String, dynamic> json) =>
    GetSearchIdxTagRequest(
      idxTag: json['idx_tag'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$GetSearchIdxTagRequestToJson(
        GetSearchIdxTagRequest instance) =>
    <String, dynamic>{
      'idx_tag': instance.idxTag,
      'page': instance.page,
      'size': instance.size,
    };

GetSearchRequest _$GetSearchRequestFromJson(Map<String, dynamic> json) =>
    GetSearchRequest(
      keyword: json['keyword'] as String,
      area1Id: json['area1_id'] as int,
      area2Id: json['area2_id'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$GetSearchRequestToJson(GetSearchRequest instance) =>
    <String, dynamic>{
      'keyword': instance.keyword,
      'area1_id': instance.area1Id,
      'area2_id': instance.area2Id,
      'page': instance.page,
      'size': instance.size,
    };

SearchPlannerSimple _$SearchPlannerSimpleFromJson(Map<String, dynamic> json) =>
    SearchPlannerSimple(
      profileId: json['profi_id'] as int,
      profileImgKey: json['profi_img_key'] as String?,
      nickname: json['nickname'] as String,
    );

Map<String, dynamic> _$SearchPlannerSimpleToJson(
        SearchPlannerSimple instance) =>
    <String, dynamic>{
      'profi_id': instance.profileId,
      'profi_img_key': instance.profileImgKey,
      'nickname': instance.nickname,
    };

SearchPanelContentSimple _$SearchPanelContentSimpleFromJson(
        Map<String, dynamic> json) =>
    SearchPanelContentSimple(
      contentId: json['ct_id'] as int,
      contentType: json['ct_type'] as int,
      nickname: json['nickname'] as String,
      thumbImgKey: json['thumb_key'] as String,
      summary: json['summary'] as String,
    );

Map<String, dynamic> _$SearchPanelContentSimpleToJson(
        SearchPanelContentSimple instance) =>
    <String, dynamic>{
      'ct_id': instance.contentId,
      'ct_type': instance.contentType,
      'nickname': instance.nickname,
      'thumb_key': instance.thumbImgKey,
      'summary': instance.summary,
    };

GetSearchContentResult _$GetSearchContentResultFromJson(
        Map<String, dynamic> json) =>
    GetSearchContentResult(
      contentId: json['ct_id'] as int,
      contentType: json['ct_type'] as int,
      thumbImgKey: json['thumb_key'] as String,
      summary: json['summary'] as String,
      viewCnt: json['view_cnt'] as int,
      bmkCnt: json['bmk_cnt'] as int,
      bmkId: json['bmk_id'] as int?,
    );

Map<String, dynamic> _$GetSearchContentResultToJson(
        GetSearchContentResult instance) =>
    <String, dynamic>{
      'ct_id': instance.contentId,
      'ct_type': instance.contentType,
      'thumb_key': instance.thumbImgKey,
      'summary': instance.summary,
      'view_cnt': instance.viewCnt,
      'bmk_cnt': instance.bmkCnt,
      'bmk_id': instance.bmkId,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiSearch implements ApiSearch {
  _ApiSearch(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<GetSearchResult>> get(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetSearchResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetSearchResult>.fromJson(
      _result.data!,
      (json) => GetSearchResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<GetSearchResult>> getGuest(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetSearchResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/guest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetSearchResult>.fromJson(
      _result.data!,
      (json) => GetSearchResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<GetHomeResult>> getHome() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetHomeResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/home',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetHomeResult>.fromJson(
      _result.data!,
      (json) => GetHomeResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<GetHomeResult>> getHomeGuest() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetHomeResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/home/guest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetHomeResult>.fromJson(
      _result.data!,
      (json) => GetHomeResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetSearchContentResult>>> getContent(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetSearchContentResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/content',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetSearchContentResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetSearchContentResult>(
              (i) => GetSearchContentResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetSearchContentResult>>> getContentGuest(
      request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetSearchContentResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/content/guest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetSearchContentResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetSearchContentResult>(
              (i) => GetSearchContentResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetSearchContentResult>>> getContentIdxTag(
      request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetSearchContentResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/content/idx-tag',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetSearchContentResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetSearchContentResult>(
              (i) => GetSearchContentResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetSearchContentResult>>> getContentIdxTagGuest(
      request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetSearchContentResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/content/idx-tag/guest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetSearchContentResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetSearchContentResult>(
              (i) => GetSearchContentResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetSearchProfileResult>>> getProfile(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetSearchProfileResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/profile',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetSearchProfileResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetSearchProfileResult>(
              (i) => GetSearchProfileResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetSearchProfileResult>>> getProfileGuest(
      request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetSearchProfileResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/profile/guest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetSearchProfileResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetSearchProfileResult>(
              (i) => GetSearchProfileResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetSearchProfileResult>>> getProfileComp(
      request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetSearchProfileResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/profile/comp',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetSearchProfileResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetSearchProfileResult>(
              (i) => GetSearchProfileResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetSearchProfileResult>>> getProfileCompGuest(
      request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetSearchProfileResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/profile/comp/guest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetSearchProfileResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetSearchProfileResult>(
              (i) => GetSearchProfileResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetSearchReviewableResult>>> getReviewable(
      request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetSearchReviewableResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/reviewable',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetSearchReviewableResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetSearchReviewableResult>((i) =>
              GetSearchReviewableResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiResponse<GetSearchPanelResult>> getContentPanel() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<GetSearchPanelResult>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/content/panel',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<GetSearchPanelResult>.fromJson(
      _result.data!,
      (json) => GetSearchPanelResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetSearchHistoryResult>>> getHistory() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetSearchHistoryResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/history',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetSearchHistoryResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetSearchHistoryResult>(
              (i) => GetSearchHistoryResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiBlankResponse> deleteHistory(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiBlankResponse>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/history',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
