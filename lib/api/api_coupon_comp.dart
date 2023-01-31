import 'package:dingmo/api/commons/page_request.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_coupon_comp.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiCouponComp {
  factory ApiCouponComp(Dio dio) = _ApiCouponComp;

  @POST(Endpoints.couponComp)
  Future<ApiBlankResponse> create(@Body() PostCouponCompRequest request);

  @GET(Endpoints.couponCompList)
  Future<ApiResponse<List<GetCouponCompResult>>> getList(
      @Queries() PageRequest request);

  @DELETE(Endpoints.couponComp)
  Future<ApiBlankResponse> delete(@Body() DeleteCouponCompRequest request);
}

@JsonSerializable()
class DeleteCouponCompRequest {
  @JsonKey(name: "ccpon_id")
  final int couponId;

  DeleteCouponCompRequest({required this.couponId});

  factory DeleteCouponCompRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteCouponCompRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteCouponCompRequestToJson(this);
}

@JsonSerializable()
class GetCouponCompResult {
  @JsonKey(name: "ccpon_id")
  final int couponId;

  @JsonKey(name: "nick")
  final String nickname;

  @JsonKey(name: "exp_dt")
  final DateTime expDt;

  @JsonKey(name: "discnt")
  final int discount;
  GetCouponCompResult(this.couponId, this.nickname, this.expDt, this.discount);

  factory GetCouponCompResult.fromJson(Map<String, dynamic> json) =>
      _$GetCouponCompResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetCouponCompResultToJson(this);
}

@JsonSerializable()
class PostCouponCompRequest {
  @JsonKey(name: "cprofi_id")
  final int cprofileId;

  @JsonKey(name: "discnt_amount")
  final int discntAmount;

  @JsonKey(name: "reg_dt")
  final DateTime regDt;

  @JsonKey(name: "exp_dt")
  final DateTime expDt;

  PostCouponCompRequest(
      {required this.cprofileId,
      required this.discntAmount,
      required this.regDt,
      required this.expDt});

  factory PostCouponCompRequest.fromJson(Map<String, dynamic> json) =>
      _$PostCouponCompRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostCouponCompRequestToJson(this);
}
