import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/http.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_third_party.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiThirdParty {
  factory ApiThirdParty(Dio dio) = _ApiThirdParty;

  @POST(Endpoints.thirdPartyCertCorp)
  Future<ApiResponse<PostCertCorpResult>> certCorp(
      @Body() PostCertCorpRequest request);

  @POST(Endpoints.thirdPartyCertPerson)
  Future<ApiResponse<PostCertPersonResult>> certPerson(
      @Body() PostCertPersonRequest request);

  @GET(Endpoints.thirdPartySearchAddress)
  Future<ApiResponse<List<GetSearchAddressInfo>>> searchAddress(
      @Queries() GetSearchAddressRequest request);
}

@JsonSerializable()
class GetSearchAddressRequest {
  @JsonKey(name: "address")
  final String address;

  GetSearchAddressRequest({required this.address});

  factory GetSearchAddressRequest.fromJson(Map<String, dynamic> json) =>
      _$GetSearchAddressRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchAddressRequestToJson(this);
}

@JsonSerializable()
class PostCertPersonRequest {
  @JsonKey(name: "imp_uid")
  final String impUid;

  PostCertPersonRequest({required this.impUid});

  factory PostCertPersonRequest.fromJson(Map<String, dynamic> json) =>
      _$PostCertPersonRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostCertPersonRequestToJson(this);
}

@JsonSerializable()
class PostCertPersonResult {
  @JsonKey(name: "phone")
  final String phone;

  @JsonKey(name: "name")
  final String name;

  @JsonKey(name: "birthday")
  final String birthDay;

  PostCertPersonResult(
      {required this.phone, required this.name, required this.birthDay});

  factory PostCertPersonResult.fromJson(Map<String, dynamic> json) =>
      _$PostCertPersonResultFromJson(json);
  Map<String, dynamic> toJson() => _$PostCertPersonResultToJson(this);
}

@JsonSerializable()
class PostCertCorpResult {
  @JsonKey(name: "validated")
  final bool validated;

  PostCertCorpResult({required this.validated});

  factory PostCertCorpResult.fromJson(Map<String, dynamic> json) =>
      _$PostCertCorpResultFromJson(json);
  Map<String, dynamic> toJson() => _$PostCertCorpResultToJson(this);
}

@JsonSerializable()
class PostCertCorpRequest {
  @JsonKey(name: "b_no")
  final String bNo;

  PostCertCorpRequest({required this.bNo});

  factory PostCertCorpRequest.fromJson(Map<String, dynamic> json) =>
      _$PostCertCorpRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostCertCorpRequestToJson(this);
}

@JsonSerializable()
class PostCertCorpData {
  @JsonKey(name: "b_no")
  final String bNo;

  @JsonKey(name: "b_stt")
  final String bStatus;

  @JsonKey(name: "b_stt_cd")
  final String bStatusCode;

  @JsonKey(name: "tax_type")
  final String taxType;

  @JsonKey(name: "tax_type_cd")
  final String taxTypeCode;

  @JsonKey(name: "end_dt")
  final String endDt;

  @JsonKey(name: "utcc_yn")
  final String utccYn;

  @JsonKey(name: "tax_type_change_dt")
  final String taxTypeChangeDt;

  @JsonKey(name: "invoice_apply_dt")
  final String invoiceApplyDt;

  PostCertCorpData(
      {required this.bNo,
      required this.bStatus,
      required this.bStatusCode,
      required this.taxType,
      required this.taxTypeCode,
      required this.endDt,
      required this.utccYn,
      required this.taxTypeChangeDt,
      required this.invoiceApplyDt});

  factory PostCertCorpData.fromJson(Map<String, dynamic> json) =>
      _$PostCertCorpDataFromJson(json);
  Map<String, dynamic> toJson() => _$PostCertCorpDataToJson(this);
}

@JsonSerializable()
class GetSearchAddressInfo {
  @JsonKey(name: "roadAddress")
  String roadAddress;

  @JsonKey(name: "jibunAddress")
  String jibunAddress;

  @JsonKey(name: "x")
  String x;

  @JsonKey(name: "y")
  String y;

  GetSearchAddressInfo({
    required this.roadAddress,
    required this.jibunAddress,
    required this.x,
    required this.y,
  });

  factory GetSearchAddressInfo.fromJson(Map<String, dynamic> json) =>
      _$GetSearchAddressInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GetSearchAddressInfoToJson(this);
}
