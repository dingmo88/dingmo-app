import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import 'commons/api_response.dart';
import 'commons/endpoints.dart';

part 'api_bmk_item.g.dart';

@RestApi(baseUrl: Endpoints.apiUrl)
abstract class ApiBmkItem {
  factory ApiBmkItem(Dio dio) = _ApiBmkItem;

  @POST(Endpoints.bookmarkItem)
  Future<ApiResponse<PostBmkItemResult>> create(
      @Body() PostBmkItemRequest request);

  @GET(Endpoints.bookmarkItemList)
  Future<ApiResponse<List<GetBmkItemResult>>> getList(
      @Queries() GetBmkItemRequest request);

  @PATCH(Endpoints.bookmarkItem)
  Future<ApiBlankResponse> update(@Body() PatchBmkItemRequest request);

  @DELETE(Endpoints.bookmarkItem)
  Future<ApiBlankResponse> delete(@Body() DeleteBmkItemRequest request);

  @DELETE(Endpoints.bookmarkItemMultiple)
  Future<ApiBlankResponse> deleteMultipe(@Body() DeleteBmkItemsRequest request);
}

@JsonSerializable()
class PostBmkItemResult {
  @JsonKey(name: "bmk_id")
  final int bmkId;

  PostBmkItemResult({required this.bmkId});
  factory PostBmkItemResult.fromJson(Map<String, dynamic> json) =>
      _$PostBmkItemResultFromJson(json);
  Map<String, dynamic> toJson() => _$PostBmkItemResultToJson(this);
}

@JsonSerializable()
class GetBmkItemRequest {
  @JsonKey(name: "fold_id")
  final int foldId;

  @JsonKey(name: "page")
  final int page;

  @JsonKey(name: "size")
  final int size;

  GetBmkItemRequest({
    required this.foldId,
    required this.page,
    required this.size,
  });
  factory GetBmkItemRequest.fromJson(Map<String, dynamic> json) =>
      _$GetBmkItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetBmkItemRequestToJson(this);
}

@JsonSerializable()
class GetBmkItemResult {
  @JsonKey(name: "item_id")
  final int bmkItemId;

  @JsonKey(name: "fold_id")
  final int bmkFolderId;

  @JsonKey(name: "ct_id")
  final int contentId;

  @JsonKey(name: "ct_type")
  final int contentType;

  @JsonKey(name: "ct_thumb_key")
  final String contentThumbKey;

  @JsonKey(name: "profi_type")
  final int profileType;

  @JsonKey(name: "comp_type")
  final int? compType;

  @JsonKey(name: "nickname")
  final String nickname;

  GetBmkItemResult(
    this.bmkItemId,
    this.bmkFolderId,
    this.contentId,
    this.contentType,
    this.contentThumbKey,
    this.profileType,
    this.compType,
    this.nickname,
  );
  factory GetBmkItemResult.fromJson(Map<String, dynamic> json) =>
      _$GetBmkItemResultFromJson(json);
  Map<String, dynamic> toJson() => _$GetBmkItemResultToJson(this);
}

@JsonSerializable()
class PostBmkItemRequest {
  @JsonKey(name: "bm_item_ct_id")
  final int contentId;

  @JsonKey(name: "bm_item_fold_id")
  final int bmkFolderId;

  PostBmkItemRequest({required this.contentId, required this.bmkFolderId});

  factory PostBmkItemRequest.fromJson(Map<String, dynamic> json) =>
      _$PostBmkItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PostBmkItemRequestToJson(this);
}

@JsonSerializable()
class PatchBmkItemRequest {
  @JsonKey(name: "fold_id")
  final int foldId;

  @JsonKey(name: "item_ids")
  final List<int> itemIds;

  PatchBmkItemRequest({required this.foldId, required this.itemIds});

  factory PatchBmkItemRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchBmkItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PatchBmkItemRequestToJson(this);
}

@JsonSerializable()
class DeleteBmkItemRequest {
  @JsonKey(name: "item_id")
  final int itemId;

  @JsonKey(name: "content_id")
  final int contentId;

  DeleteBmkItemRequest({
    required this.itemId,
    required this.contentId,
  });

  factory DeleteBmkItemRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteBmkItemRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteBmkItemRequestToJson(this);
}

@JsonSerializable()
class DeleteBmkItemsRequest {
  @JsonKey(name: "items")
  final List<DeleteBmkItemData> items;

  DeleteBmkItemsRequest({
    required this.items,
  });

  factory DeleteBmkItemsRequest.fromJson(Map<String, dynamic> json) =>
      _$DeleteBmkItemsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteBmkItemsRequestToJson(this);
}

@JsonSerializable()
class DeleteBmkItemData {
  @JsonKey(name: "item_id")
  final int itemId;

  @JsonKey(name: "content_id")
  final int contentId;

  DeleteBmkItemData({
    required this.itemId,
    required this.contentId,
  });

  factory DeleteBmkItemData.fromJson(Map<String, dynamic> json) =>
      _$DeleteBmkItemDataFromJson(json);
  Map<String, dynamic> toJson() => _$DeleteBmkItemDataToJson(this);
}
