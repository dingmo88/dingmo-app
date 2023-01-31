import 'package:dingmo/ui/upload/feeds/items/search_mention.dart';

class FeedUploadMentionItem {
  String profileUrl;
  String nickname;
  String categoryName;

  FeedUploadMentionItem(
      {required this.profileUrl,
      required this.nickname,
      required this.categoryName});

  factory FeedUploadMentionItem.from(SearchMentionItem item) =>
      FeedUploadMentionItem(
          profileUrl: item.profileUrl,
          nickname: item.nickname,
          categoryName: item.categoryName);
}
