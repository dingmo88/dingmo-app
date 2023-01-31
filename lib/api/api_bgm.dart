import 'package:dingmo/api/commons/page_request.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_bgm.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiBgm {
  factory ApiBgm(Dio dio) = _ApiBgm;

  @GET(Endpoints.bgmList)
  Future<ApiResponse<List<GetBgmResult>>> getAreaFirstList(
      @Queries() PageRequest request);
}

@JsonSerializable()
class GetBgmResult {
  @JsonKey(name: "bgm_id")
  final int bgmId;

  @JsonKey(name: "bgm_img_key")
  final String bgmImgKey;

  GetBgmResult({required this.bgmId, required this.bgmImgKey});

  factory GetBgmResult.fromJson(Map<String, dynamic> json) =>
      _$GetBgmResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetBgmResultToJson(this);
}
