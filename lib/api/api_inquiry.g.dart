// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_inquiry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostInquiryRequest _$PostInquiryRequestFromJson(Map<String, dynamic> json) =>
    PostInquiryRequest(
      title: json['title'] as int,
      content: json['content'] as String,
      images: (json['imgs'] as List<dynamic>?)
          ?.map((e) => InquiryImage.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostInquiryRequestToJson(PostInquiryRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'imgs': instance.images,
    };

GetInquiryResult _$GetInquiryResultFromJson(Map<String, dynamic> json) =>
    GetInquiryResult(
      json['inq_id'] as int,
      json['title'] as String,
      json['content'] as String,
      (json['imgs'] as List<dynamic>)
          .map((e) => InquiryImage.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['reply'] as String?,
      DateTime.parse(json['inq_dt'] as String),
    );

Map<String, dynamic> _$GetInquiryResultToJson(GetInquiryResult instance) =>
    <String, dynamic>{
      'inq_id': instance.inqId,
      'title': instance.title,
      'content': instance.content,
      'imgs': instance.images,
      'reply': instance.reply,
      'inq_dt': instance.createdDt.toIso8601String(),
    };

InquiryImage _$InquiryImageFromJson(Map<String, dynamic> json) => InquiryImage(
      imageKey: json['img_key'] as String,
    );

Map<String, dynamic> _$InquiryImageToJson(InquiryImage instance) =>
    <String, dynamic>{
      'img_key': instance.imageKey,
    };

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiInquiry implements ApiInquiry {
  _ApiInquiry(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://dev.dingmo.co.kr/api';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<ApiResponse<List<GetInquiryResult>>> getList(request) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.addAll(request.toJson());
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ApiResponse<List<GetInquiryResult>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/inquiry/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ApiResponse<List<GetInquiryResult>>.fromJson(
      _result.data!,
      (json) => (json as List<dynamic>)
          .map<GetInquiryResult>(
              (i) => GetInquiryResult.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
    return value;
  }

  @override
  Future<ApiBlankResponse> create(request) async {
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
              '/inquiry',
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
