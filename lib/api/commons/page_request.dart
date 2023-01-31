import 'package:json_annotation/json_annotation.dart';

part 'page_request.g.dart';

// request object for list paging
@JsonSerializable()
class PageRequest {
  final int size;
  int page;
  PageRequest({this.size = 10, this.page = 1});

  factory PageRequest.fromJson(Map<String, dynamic> json) =>
      _$PageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$PageRequestToJson(this);
}
