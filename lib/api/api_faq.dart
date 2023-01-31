import 'package:dingmo/api/commons/page_request.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_faq.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiFaq {
  factory ApiFaq(Dio dio) = _ApiFaq;

  @GET(Endpoints.faqList)
  Future<ApiResponse<List<GetFaqResult>>> getList(
      @Queries() PageRequest request);
}

@JsonSerializable()
class GetFaqResult {
  @JsonKey(name: "bann_id")
  final int bannId;

  @JsonKey(name: "bann_img_key")
  final String bannImgKey;

  GetFaqResult({required this.bannId, required this.bannImgKey});

  factory GetFaqResult.fromJson(Map<String, dynamic> json) =>
      _$GetFaqResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetFaqResultToJson(this);
}
