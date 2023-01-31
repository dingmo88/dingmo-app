import 'package:dingmo/api/commons/page_request.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_point.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiPoint {
  factory ApiPoint(Dio dio) = _ApiPoint;

  @GET(Endpoints.pointList)
  Future<ApiResponse<List<GetPointResult>>> getList(
      @Queries() PageRequest request);
}

@JsonSerializable()
class GetPointResult {
  @JsonKey(name: "pt_id")
  final int pointId;

  @JsonKey(name: "pt_amount")
  final int amount;

  @JsonKey(name: "pt_type")
  final int type;

  GetPointResult(this.pointId, this.amount, this.type);

  factory GetPointResult.fromJson(Map<String, dynamic> json) =>
      _$GetPointResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetPointResultToJson(this);
}
