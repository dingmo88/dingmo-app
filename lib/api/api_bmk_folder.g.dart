// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_bmk_folder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostBmkFolderResult _$PostBmkFolderResultFromJson(Map<String, dynamic> json) =>
    PostBmkFolderResult(
      json['fold_id'] as int,
      json['fold_thumb_key'] as String?,
      json['fold_name'] as String,
      json['is_secret'] as bool,
    );

Map<String, dynamic> _$PostBmkFolderResultToJson(
        PostBmkFolderResult instance) =>
    <String, dynamic>{
      'fold_id': instance.foldId,
      'fold_thumb_key': instance.foldThumbKey,
      'fold_name': instance.foldName,
      'is_secret': instance.isSecret,
    };

GetBmkFolderResult _$GetBmkFolderResultFromJson(Map<String, dynamic> json) =>
    GetBmkFolderResult(
      json['fold_id'] as int,
      json['fold_thumb_key'] as String?,
      json['fold_name'] as String,
      json['is_secret'] as bool,
    );

Map<String, dynamic> _$GetBmkFolderResultToJson(GetBmkFolderResult instance) =>
    <String, dynamic>{
      'fold_id': instance.foldId,
      'fold_thumb_key': instance.foldThumbKey,
      'fold_name': instance.foldName,
      'is_secret': instance.isSecret,
    };

PostBmkFolderRequest _$PostBmkFolderRequestFromJson(
        Map<String, dynamic> json) =>
    PostBmkFolderRequest(
      folderName: json['fold_name'] as String,
      isSecret: json['fold_secret'] as bool,
    );

Map<String, dynamic> _$PostBmkFolderRequestToJson(
        PostBmkFolderRequest instance) =>
    <String, dynamic>{
      'fold_name': instance.folderName,
      'fold_secret': instance.isSecret,
    };

PatchBmkFolderRequest _$PatchBmkFolderRequestFromJson(
        Map<String, dynamic> json) =>
    PatchBmkFolderRequest(
      foldId: json['fold_id'] as int,
      folderName: json['fold_name'] as String?,
      isSecret: json['fold_secret'] as bool?,
    );

Map<String, dynamic> _$PatchBmkFolderRequestToJson(
        PatchBmkFolderRequest instance) =>
    <String, dynamic>{
      'fold_id': instance.foldId,
      'fold_name': instance.folderName,
      'fold_secret': instance.isSecret,
    };

DeleteBmkFolderRequest _$DeleteBmkFolderRequestFromJson(
        Map<String, dynamic> json) =>
    DeleteBmkFolderRequest(
      folderId: json['fold_id'] as int,
    );

Map<String, dynamic> _$DeleteBmkFolderRequestToJson(
        DeleteBmkFolderRequest instance) =>
    <String, dynamic>{
      'fold_id': instance.folderId,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiBmkFolder implements ApiBmkFolder {
  _ApiBmkFolder(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<PostBmkFolderResult>> create(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(request.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<PostBmkFolderResult>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/bookmark/folder',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<PostBmkFolderResult>.fromJson(
      _result.data!,
      (json) => PostBmkFolderResult.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<ApiResponse<List<GetBmkFolderResult>>> getList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetBmkFolderResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/bookmark/folder/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetBmkFolderResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetBmkFolderResult>(
              (i) => GetBmkFolderResult.fromJson(i as Map<String, dynamic>))
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
              '/bookmark/folder',
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
              '/bookmark/folder',
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
