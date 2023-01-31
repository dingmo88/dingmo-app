import '../../../../constants/type.dart';

class UserInterestPlanItem {
  final String profileUrl;
  final String nickname;
  final List<UserInterestPlanPreviewItem> previews;

  UserInterestPlanItem({
    required this.profileUrl,
    required this.nickname,
    required this.previews,
  });
}

class UserInterestPlanPreviewItem {
  String thumbnailUrl;
  DingmoContentType type;
  int viewCount;

  UserInterestPlanPreviewItem({
    required this.thumbnailUrl,
    required this.type,
    this.viewCount = 0,
  });
}
