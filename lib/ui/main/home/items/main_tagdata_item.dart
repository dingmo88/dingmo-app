import 'package:dingmo/constants/type.dart';

class MainTagDataItem {
  final int idxTag;
  final String title;
  final List<MainTagContentItem> contents;

  MainTagDataItem({
    required this.idxTag,
    required this.title,
    required this.contents,
  });
}

class MainTagContentItem {
  final int contentId;
  final DingmoContentType type;
  final String thumbnailUrl;
  final String title;
  final int viewCount;

  MainTagContentItem({
    required this.contentId,
    required this.type,
    required this.thumbnailUrl,
    required this.title,
    required this.viewCount,
  });
}
