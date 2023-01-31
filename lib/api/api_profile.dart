import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_profile.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiProfile {
  factory ApiProfile(Dio dio) = _ApiProfile;

  @GET(Endpoints.profileMyAreaExists)
  Future<ApiResponse<GetMyAreaExistsResult>> myAreaExists();
}

@JsonSerializable()
class GetMyAreaExistsResult {
  @JsonKey(name: "exists")
  final bool exists;

  GetMyAreaExistsResult(this.exists);

  factory GetMyAreaExistsResult.fromJson(Map<String, dynamic> json) =>
      _$GetMyAreaExistsResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetMyAreaExistsResultToJson(this);
}
