import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_bmk_folder.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiBmkFolder {
  factory ApiBmkFolder(Dio dio) = _ApiBmkFolder;

  @POST(Endpoints.bookmarkFolder)
  Future<ApiResponse<PostBmkFolderResult>> create(
      @Body() PostBmkFolderRequest request);

  @GET(Endpoints.bookmarkFolderList)
  Future<ApiResponse<List<GetBmkFolderResult>>> getList();

  @PATCH(Endpoints.bookmarkFolder)
  Future<ApiBlankResponse> update(@Body() PatchBmkFolderRequest request);

  @DELETE(Endpoints.bookmarkFolder)
  Future<ApiBlankResponse> delete(@Body() DeleteBmkFolderRequest request);
}

@JsonSerializable()
class PostBmkFolderResult {
  @JsonKey(name: "fold_id")
  final int foldId;

  @JsonKey(name: "fold_thumb_key")
  final String? foldThumbKey;

  @JsonKey(name: "fold_name")
  final String foldName;

  @JsonKey(name: "is_secret")
  final bool isSecret;

  PostBmkFolderResult(
      this.foldId, this.foldThumbKey, this.foldName, this.isSecret);
  factory PostBmkFolderResult.fromJson(Map<String, dynamic> json) =>
      _$PostBmkFolderResultFromJson(json);
  Map<String, dynamic> toJson() => _$PostBmkFolderResultToJson(this);
}

@JsonSerializable()
class GetBmkFolderResult {
  @JsonKey(name: "fold_id")
  final int foldId;

  @JsonKey(name: "fold_thumb_key")
  final String? foldThumbKey;

  @JsonKey(name: "fold_name")
  final String foldName;

  @JsonKey(name: "is_secret")
  final bool isSecret;

  GetBmkFolderResult(
      this.foldId, this.foldThumbKey, this.foldName, this.isSecret);
  factory GetBmkFolderResult.fromJson(Map<String, dynamic> json) =>
      _$GetBmkFolderResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetBmkFolderResultToJson(this);
}

@JsonSerializable()
class PostBmkFolderRequest {
  @JsonKey(name: "fold_name")
  final String folderName;

  @JsonKey(name: "fold_secret")
  final bool isSecret;

  PostBmkFolderRequest({required this.folderName, required this.isSecret});

  factory PostBmkFolderRequest.fromJson(Map<String, dynamic> json) =>
      _$PostBmkFolderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostBmkFolderRequestToJson(this);
}

@JsonSerializable()
class PatchBmkFolderRequest {
  @JsonKey(name: "fold_id")
  final int foldId;

  @JsonKey(name: "fold_name")
  final String? folderName;

  @JsonKey(name: "fold_secret")
  final bool? isSecret;

  PatchBmkFolderRequest(
      {required this.foldId, required this.folderName, required this.isSecret});

  factory PatchBmkFolderRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchBmkFolderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PatchBmkFolderRequestToJson(this);
}

@JsonSerializable()
class DeleteBmkFolderRequest {
  @JsonKey(name: "fold_id")
  final int folderId;

  DeleteBmkFolderRequest({
    required this.folderId,
  });

  factory DeleteBmkFolderRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteBmkFolderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteBmkFolderRequestToJson(this);
}
