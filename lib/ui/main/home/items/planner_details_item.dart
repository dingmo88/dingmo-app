import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/constants/member.dart';

import '../../../../constants/type.dart';

class SearchProfileItem {
  final bool isMine;
  final int profileId;
  final MemberType memberType;
  final IdxTag? idxTag;
  final String profileUrl;
  final String nickname;
  final List<ProfileDetailsPreviewItem> previews;
  bool isFollow;

  SearchProfileItem({
    required this.isMine,
    required this.profileId,
    required this.memberType,
    required this.idxTag,
    required this.profileUrl,
    required this.nickname,
    required this.previews,
    required this.isFollow,
  });
}

class ProfileDetailsPreviewItem {
  final int contentId;
  final DingmoContentType contentType;
  final String thumbnailUrl;
  final int viewCount;

  ProfileDetailsPreviewItem({
    required this.contentId,
    required this.contentType,
    required this.thumbnailUrl,
    required this.viewCount,
  });
}
