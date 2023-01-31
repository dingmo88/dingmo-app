import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_search.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/api/commons/page_request.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/main/home/items/planner_details_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/infinity_list.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

import 'widgets/search_profile_item.dart';

class SearchProfilesPage extends StatefulWidget {
  final MemberType memberType;
  final IdxTag? idxTag;
  final String? keyword;
  const SearchProfilesPage(
      {Key? key, required this.memberType, this.idxTag, this.keyword})
      : super(key: key);

  @override
  State<SearchProfilesPage> createState() => _SearchProfilesPageState();
}

class _SearchProfilesPageState extends State<SearchProfilesPage> {
  int maxContentLoad = 5;
  int currentContentLoad = 1;

  final PageRequest _pageReq = PageRequest(page: 0, size: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars.defaultAppBar(context,
            title: widget.memberType != MemberType.comp
                ? "더보기"
                : idxTagToString(widget.idxTag!)),
        body: InfinityListWidget<SearchProfileItem>(
          onLoad: _getProfiles,
          pageSize: 10,
          itemBuilder: (context, item, index) {
            return Container(
              color: index % 2 == 0 ? Colors.white : AppColors.greyWhite,
              child: SearchProfileItemWidget(item: item),
            );
          },
        ));
  }

  Future<List<SearchProfileItem>> _getProfiles(int page, int size) async {
    // ignore: prefer_typing_uninitialized_variables
    final request;

    if (widget.memberType == MemberType.comp) {
      request = GetSearchCompProfileRequest(
          compType: idxTagToValue(widget.idxTag)!,
          page: ++_pageReq.page,
          size: _pageReq.size);
    } else {
      request = GetSearchProfileRequest(
          memberType: memberTypeToValue(widget.memberType),
          keyword: widget.keyword,
          page: ++_pageReq.page,
          size: _pageReq.size);
    }

    try {
      final result = (getIt<MemberInfo>().isGuest()
              ? (widget.memberType == MemberType.comp
                  ? await getIt<ApiSearch>().getProfileCompGuest(request)
                  : await getIt<ApiSearch>().getProfileGuest(request))
              : (widget.memberType == MemberType.comp
                  ? await getIt<ApiSearch>().getProfileComp(request)
                  : await getIt<ApiSearch>().getProfile(request)))
          .result;

      return result
          .map(
            (e) => SearchProfileItem(
                isMine: e.isMine,
                profileId: e.profileId,
                idxTag: widget.idxTag,
                memberType: widget.memberType,
                profileUrl: path.join(Endpoints.imgUrl, e.profiImgKey),
                nickname: e.nickname,
                previews: e.thumbs
                    .map((e) => ProfileDetailsPreviewItem(
                        contentId: e.contentId,
                        contentType: valueToCtType(e.contentType)!,
                        thumbnailUrl: path.join(Endpoints.imgUrl, e.thumbKey),
                        viewCount: e.viewCnt))
                    .toList(),
                isFollow: e.isFollow),
          )
          .toList();
    } catch (e) {
      safePrint("exception: $e");
    }

    return [];
  }
}
