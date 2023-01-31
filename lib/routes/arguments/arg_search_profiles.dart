import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/constants/member.dart';

class SearchProfilesArgs {
  final MemberType memberType;
  final IdxTag? idxTag;
  final String? keyword;

  SearchProfilesArgs({
    required this.memberType,
    this.idxTag,
    this.keyword,
  });
}
