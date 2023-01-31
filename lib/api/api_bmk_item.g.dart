// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_bmk_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostBmkItemResult _$PostBmkItemResultFromJson(Map<String, dynamic> json) =>
    PostBmkItemResult(
      bmkId: json['bmk_id'] as int,
    );

Map<String, dynamic> _$PostBmkItemResultToJson(PostBmkItemResult instance) =>
    <String, dynamic>{
      'bmk_id': instance.bmkId,
    };

GetBmkItemRequest _$GetBmkItemRequestFromJson(Map<String, dynamic> json) =>
    GetBmkItemRequest(
      foldId: json['fold_id'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
    );

Map<String, dynamic> _$GetBmkItemRequestToJson(GetBmkItemRequest instance) =>
    <String, dynamic>{
      'fold_id': instance.foldId,
      'page': instance.page,
      'size': instance.size,
    };

GetBmkItemResult _$GetBmkItemResultFromJson(Map<String, dynamic> json) =>
    GetBmkItemResult(
      json['item_id'] as int,
      json['fold_id'] as int,
      json['ct_id'] as int,
      json['ct_type'] as int,
      json['ct_thumb_key'] as String,
      json['profi_type'] as int,
      json['comp_type'] as int?,
      json['nickname'] as String,
    );

Map<String, dynamic> _$GetBmkItemResultToJson(GetBmkItemResult instance) =>
    <String, dynamic>{
      'item_id': instance.bmkItemId,
      'fold_id': instance.bmkFolderId,
      'ct_id': instance.contentId,
      'ct_type': instance.contentType,
      'ct_thumb_key': instance.contentThumbKey,
      'profi_type': instance.profileType,
      'comp_type': instance.compType,
      'nickname': instance.nickname,
    };

PostBmkItemRequest _$PostBmkItemRequestFromJson(Map<String, dynamic> json) =>
    PostBmkItemRequest(
      contentId: json['bm_item_ct_id'] as int,
      bmkFolderId: json['bm_item_fold_id'] as int,
    );

Map<String, dynamic> _$PostBmkItemRequestToJson(PostBmkItemRequest instance) =>
    <String, dynamic>{
      'bm_item_ct_id': instance.contentId,
      'bm_item_fold_id': instance.bmkFolderId,
    };

PatchBmkItemRequest _$PatchBmkItemRequestFromJson(Map<String, dynamic> json) =>
    PatchBmkItemRequest(
      foldId: json['fold_id'] as int,
      itemIds:
          (json['item_ids'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$PatchBmkItemRequestToJson(
        PatchBmkItemRequest instance) =>
    <String, dynamic>{
      'fold_id': instance.foldId,
      'item_ids': instance.itemIds,
    };

DeleteBmkItemRequest _$DeleteBmkItemRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteBmkItemRequest(
      itemId: json['item_id'] as int,
      contentId: json['content_id'] as int,
    );

Map<String, dynamic> _$DeleteBmkItemRequestToJson(
        DeleteBmkItemRequest instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'content_id': instance.contentId,
    };

DeleteBmkItemsRequest _$DeleteBmkItemsRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteBmkItemsRequest(
      items: (json['items'] as List<dynamic>)
          .map((e) => DeleteBmkItemData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DeleteBmkItemsRequestToJson(
        DeleteBmkItemsRequest instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

DeleteBmkItemData _$DeleteBmkItemDataFromJson(Map<String, dynamic> json) =>
    DeleteBmkItemData(
      itemId: json['item_id'] as int,
      contentId: json['content_id'] as int,
    );

Map<String, dynamic> _$DeleteBmkItemDataToJson(DeleteBmkItemData instance) =>
    <String, dynamic>{
      'item_id': instance.itemId,
      'content_id': instance.contentId,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiBmkItem implements ApiBmkItem {
  _ApiBmkItem(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<PostBmkItemResult>> create(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<PostBmkItemResult>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/bookmark/item',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<PostBmkItemResult>.fromJson(
      _result.data!,
      (json) => PostBmkItemResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetBmkItemResult>>> getList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetBmkItemResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/bookmark/item/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetBmkItemResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetBmkItemResult>(
              (i) => GetBmkItemResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiBlankResponse> update(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ApiBlankResponse>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/bookmark/item',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiBlankResponse> delete(request) async {
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
              '/bookmark/item',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiBlankResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ApiBlankResponse> deleteMultipe(request) async {
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
              '/bookmark/item/multiple',
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
