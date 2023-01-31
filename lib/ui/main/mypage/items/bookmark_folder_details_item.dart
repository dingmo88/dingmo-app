import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';

import '../../../../constants/idx_tag.dart';

class BookmarkFolderDetailsItem {
  final int itemId;
  final int foldId;
  final int contentId;
  final DingmoContentType contentType;
  final String thumbnailUrl;
  final MemberType memberType;
  final IdxTag? compType;
  final String nickname;
  bool isSelected = false;

  BookmarkFolderDetailsItem({
    required this.itemId,
    required this.foldId,
    required this.contentId,
    required this.contentType,
    required this.thumbnailUrl,
    required this.memberType,
    required this.compType,
    required this.nickname,
  });
}
