import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable()
class ApiBlankResponse {
  final int code;
  final String message;
  final BlankResult result;
  ApiBlankResponse(this.code, this.message, this.result);

  factory ApiBlankResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiBlankResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiBlankResponseToJson(this);
}

@JsonSerializable()
class BlankResult {
  BlankResult();

  factory BlankResult.fromJson(Map<String, dynamic> json) =>
      _$BlankResultFromJson(json);
  Map<String, dynamic> toJson() => _$BlankResultToJson(this);
}

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<Result> {
  final int code;
  final String message;
  final Result result;

  ApiResponse(this.code, this.message, this.result);

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    Result Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson<Result>(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(Result value) toJsonT) =>
      _$ApiResponseToJson<Result>(this, toJsonT);
}

@JsonSerializable()
class ApiErrorResponse {
  final int code;
  final String error;
  final String message;

  ApiErrorResponse(this.code, this.error, this.message);

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ApiErrorResponseToJson(this);
}
