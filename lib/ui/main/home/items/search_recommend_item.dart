import 'package:dingmo/constants/type.dart';

class SearchRecommendItem {
  final List<String> tags;
  final List<SearchRecommendFeedItem> feeds;

  SearchRecommendItem({required this.tags, required this.feeds});
}

class SearchRecommendFeedItem {
  int contentId;
  DingmoContentType contentType;
  String thumbUrl;
  String nickname;
  String description;

  SearchRecommendFeedItem({
    required this.contentId,
    required this.contentType,
    required this.thumbUrl,
    required this.nickname,
    required this.description,
  });
}
