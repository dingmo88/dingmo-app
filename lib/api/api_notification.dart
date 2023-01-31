import 'package:dingmo/api/commons/page_request.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_notification.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiNotification {
  factory ApiNotification(Dio dio) = _ApiNotification;

  @GET(Endpoints.noticeList)
  Future<ApiResponse<List<GetNotificationResult>>> getList(
      @Queries() PageRequest request);
}

@JsonSerializable()
class GetNotificationResult {
  @JsonKey(name: "noti_id")
  final int notiId;

  @JsonKey(name: "noti_type")
  final int notiType;

  @JsonKey(name: "noti_msg")
  final String message;

  @JsonKey(name: "noti_dt")
  final DateTime createdDt;

  GetNotificationResult(
      this.notiId, this.notiType, this.message, this.createdDt);

  factory GetNotificationResult.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetNotificationResultToJson(this);
}
