import 'package:dingmo/constants/type.dart';

class SearchResultItem {
  final List<SearchResultPlannerItem> planners;
  final List<SearchResultContentItem> contents;

  SearchResultItem({
    required this.planners,
    required this.contents,
  });
}

class SearchResultPlannerItem {
  final int profileId;
  final String profileUrl;
  final String nickname;

  SearchResultPlannerItem({
    required this.profileId,
    required this.profileUrl,
    required this.nickname,
  });
}

class SearchResultContentItem {
  final int contentId;
  final DingmoContentType contentType;
  final String thumbnailUrl;
  final String title;
  final int viewCount;
  final int bookmarkCount;
  int? bmkId;
  SearchResultContentItem({
    required this.contentId,
    required this.contentType,
    required this.thumbnailUrl,
    required this.title,
    required this.viewCount,
    required this.bookmarkCount,
    required this.bmkId,
  });
}
