import 'package:dingmo/api/commons/page_request.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_banner.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiBanner {
  factory ApiBanner(Dio dio) = _ApiBanner;

  @GET(Endpoints.bannerList)
  Future<ApiResponse<List<GetBannerResult>>> getList(
      @Queries() PageRequest request);
}

@JsonSerializable()
class GetBannerResult {
  @JsonKey(name: "bann_id")
  final int bannId;

  @JsonKey(name: "bann_img_key")
  final String bannImgKey;

  GetBannerResult({required this.bannId, required this.bannImgKey});

  factory GetBannerResult.fromJson(Map<String, dynamic> json) =>
      _$GetBannerResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetBannerResultToJson(this);
}
