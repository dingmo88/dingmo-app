import 'package:dingmo/api/commons/page_request.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_inquiry.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiInquiry {
  factory ApiInquiry(Dio dio) = _ApiInquiry;

  @GET(Endpoints.inquiryList)
  Future<ApiResponse<List<GetInquiryResult>>> getList(
      @Queries() PageRequest request);

  @POST(Endpoints.inquiry)
  Future<ApiBlankResponse> create(@Body() PostInquiryRequest request);
}

@JsonSerializable()
class PostInquiryRequest {
  @JsonKey(name: "title")
  final int title;

  @JsonKey(name: "content")
  final String content;

  @JsonKey(name: "imgs")
  final List<InquiryImage>? images;

  PostInquiryRequest({required this.title, required this.content, this.images});

  factory PostInquiryRequest.fromJson(Map<String, dynamic> json) =>
      _$PostInquiryRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostInquiryRequestToJson(this);
}

@JsonSerializable()
class GetInquiryResult {
  @JsonKey(name: "inq_id")
  final int inqId;

  @JsonKey(name: "title")
  final String title;

  @JsonKey(name: "content")
  final String content;

  @JsonKey(name: "imgs")
  final List<InquiryImage> images;

  @JsonKey(name: "reply")
  final String? reply;

  @JsonKey(name: "inq_dt")
  final DateTime createdDt;

  GetInquiryResult(this.inqId, this.title, this.content, this.images,
      this.reply, this.createdDt);

  factory GetInquiryResult.fromJson(Map<String, dynamic> json) =>
      _$GetInquiryResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetInquiryResultToJson(this);
}

@JsonSerializable()
class InquiryImage {
  @JsonKey(name: "img_key")
  final String imageKey;

  InquiryImage({
    required this.imageKey,
  });

  factory InquiryImage.fromJson(Map<String, dynamic> json) =>
      _$InquiryImageFromJson(json);
  Map<String, dynamic> toJson() => _$InquiryImageToJson(this);
}
