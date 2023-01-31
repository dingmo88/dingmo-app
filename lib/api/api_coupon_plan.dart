import 'package:dingmo/api/commons/page_request.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_coupon_plan.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiCouponPlan {
  factory ApiCouponPlan(Dio dio) = _ApiCouponPlan;

  @POST(Endpoints.couponPlan)
  Future<ApiBlankResponse> create(@Body() PostCouponPlanRequest request);

  @GET(Endpoints.couponCompList)
  Future<ApiResponse<List<GetCouponPlanResult>>> getList(
      @Queries() PageRequest request);

  @DELETE(Endpoints.couponPlan)
  Future<ApiBlankResponse> delete(@Body() DeleteCouponPlanRequest request);
}

@JsonSerializable()
class DeleteCouponPlanRequest {
  @JsonKey(name: "pcpon_id")
  final int couponId;

  DeleteCouponPlanRequest({required this.couponId});

  factory DeleteCouponPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteCouponPlanRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteCouponPlanRequestToJson(this);
}

@JsonSerializable()
class GetCouponPlanResult {
  @JsonKey(name: "pcpon_id")
  final int couponId;

  @JsonKey(name: "nick")
  final String nickname;

  @JsonKey(name: "exp_dt")
  final DateTime expDt;

  @JsonKey(name: "discnt")
  final int discount;
  GetCouponPlanResult(this.couponId, this.nickname, this.expDt, this.discount);

  factory GetCouponPlanResult.fromJson(Map<String, dynamic> json) =>
      _$GetCouponPlanResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetCouponPlanResultToJson(this);
}

@JsonSerializable()
class PostCouponPlanRequest {
  @JsonKey(name: "pprofi_id")
  final int cprofileId;

  @JsonKey(name: "discnt_amount")
  final int discntAmount;

  @JsonKey(name: "reg_dt")
  final DateTime regDt;

  @JsonKey(name: "exp_dt")
  final DateTime expDt;

  PostCouponPlanRequest(
      {required this.cprofileId,
      required this.discntAmount,
      required this.regDt,
      required this.expDt});

  factory PostCouponPlanRequest.fromJson(Map<String, dynamic> json) =>
      _$PostCouponPlanRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostCouponPlanRequestToJson(this);
}
