import 'package:dingmo/constants/type.dart';

class UserProfileContentItem {
  String thumbUrl;
  DingmoContentType type;
  int viewCount;

  UserProfileContentItem(
      {required this.thumbUrl, required this.type, required this.viewCount});
}
