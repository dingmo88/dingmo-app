import 'user_profile_content_item.dart';

class UserProfileItem {
  final String profileUrl;
  final String nickname;
  final List<UserProfileContentItem> bookmarks;
  final List<UserProfileContentItem> uploads;

  UserProfileItem({
    required this.profileUrl,
    required this.nickname,
    required this.bookmarks,
    required this.uploads,
  });
}
