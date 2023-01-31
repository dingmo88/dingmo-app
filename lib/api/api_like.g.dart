// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_like.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostLikeRequest _$PostLikeRequestFromJson(Map<String, dynamic> json) =>
    PostLikeRequest(
      likeType: json['like_type'] as int,
      atId: json['at_id'] as int,
      isLike: json['is_like'] as bool,
    );

Map<String, dynamic> _$PostLikeRequestToJson(PostLikeRequest instance) =>
    <String, dynamic>{
      'like_type': instance.likeType,
      'at_id': instance.atId,
      'is_like': instance.isLike,
    };

GetLikeResult _$GetLikeResultFromJson(Map<String, dynamic> json) =>
    GetLikeResult(
      json['lik_id'] as int,
      json['profi_id'] as int,
      json['profi_type'] as int,
      json['cprofi_type'] as int?,
      json['profi_img_key'] as String,
      json['profi_nick'] as String,
    );

Map<String, dynamic> _$GetLikeResultToJson(GetLikeResult instance) =>
    <String, dynamic>{
      'lik_id': instance.likeId,
      'profi_id': instance.profileId,
      'profi_type': instance.profileType,
      'cprofi_type': instance.cprofileType,
      'profi_img_key': instance.profileImgKey,
      'profi_nick': instance.nickname,
    };

GetLikeRequest _$GetLikeRequestFromJson(Map<String, dynamic> json) =>
    GetLikeRequest(
      contentId: json['content_id'] as int,
      page: PageRequest.fromJson(json['page'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetLikeRequestToJson(GetLikeRequest instance) =>
    <String, dynamic>{
      'content_id': instance.contentId,
      'page': instance.page,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiLike implements ApiLike {
  _ApiLike(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<List<GetLikeResult>>> getList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetLikeResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/like/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetLikeResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetLikeResult>(
              (i) => GetLikeResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiBlankResponse> submit(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiBlankResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/like',
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
