import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_area.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiArea {
  factory ApiArea(Dio dio) = _ApiArea;

  @GET(Endpoints.areaFirstList)
  Future<ApiResponse<List<GetAreaResult>>> getAreaFirstList();

  @GET(Endpoints.areaSecondList)
  Future<ApiResponse<List<GetAreaResult>>> getAreaSecondList(
      @Queries() GetAreaSecondRequest request);
}

@JsonSerializable()
class GetAreaSecondRequest {
  @JsonKey(name: "area1_id")
  final int area1Id;

  GetAreaSecondRequest({required this.area1Id});

  factory GetAreaSecondRequest.fromJson(Map<String, dynamic> json) =>
      _$GetAreaSecondRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetAreaSecondRequestToJson(this);
}

@JsonSerializable()
class GetAreaResult {
  @JsonKey(name: "area_id")
  final int areaId;

  @JsonKey(name: "area_name")
  final String areaName;

  GetAreaResult({required this.areaId, required this.areaName});

  factory GetAreaResult.fromJson(Map<String, dynamic> json) =>
      _$GetAreaResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetAreaResultToJson(this);
}
