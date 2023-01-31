import 'package:dingmo/api/commons/page_request.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_notice.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiNotice {
  factory ApiNotice(Dio dio) = _ApiNotice;

  @GET(Endpoints.noticeList)
  Future<ApiResponse<List<GetNoticeResult>>> getList(
      @Queries() PageRequest request);
}

@JsonSerializable()
class GetNoticeResult {
  @JsonKey(name: "notice_id")
  final int noticeId;

  @JsonKey(name: "notice_content")
  final String content;

  GetNoticeResult({required this.noticeId, required this.content});

  factory GetNoticeResult.fromJson(Map<String, dynamic> json) =>
      _$GetNoticeResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetNoticeResultToJson(this);
}
