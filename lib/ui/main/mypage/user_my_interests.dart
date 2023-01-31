import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/ui/main/home/items/planner_details_item.dart';
import 'package:dingmo/ui/main/home/widgets/search_profile_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/infinity_list.dart';
import 'package:flutter/material.dart';

class UserMyInterestsPage extends StatefulWidget {
  const UserMyInterestsPage({Key? key}) : super(key: key);

  @override
  State<UserMyInterestsPage> createState() => _UserMyInterestsPageState();
}

class _UserMyInterestsPageState extends State<UserMyInterestsPage> {
  int index = 0;

  int maxContentLoad = 5;
  int currentContentLoad = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars.defaultAppBar(context, title: "나의 관심업체"),
        body: InfinityListWidget<SearchProfileItem>(
          onLoad: getPlanners,
          pageSize: 10,
          itemBuilder: (context, item, index) {
            return SearchProfileItemWidget(item: item);
          },
        ));
  }

  Future<List<SearchProfileItem>> getPlanners(int startIdx, int pageSize) {
    return Future.delayed(const Duration(seconds: 1), () {
      if (currentContentLoad >= maxContentLoad) {
        return [];
      } else {
        currentContentLoad++;
      }

      final List<SearchProfileItem> contents = [];

      for (int idx = startIdx; idx < startIdx + pageSize; idx++) {
        final List<ProfileDetailsPreviewItem> previewList = [];
        for (int idx2 = 0; idx2 < 10; idx2++) {
          previewList.add(ProfileDetailsPreviewItem(
              contentId: 0,
              viewCount: 0,
              thumbnailUrl:
                  "https://picsum.photos/id/${567 + idx2 + (idx * 10)}/105/105",
              contentType: idx2 % 3 == 0
                  ? DingmoContentType.reels
                  : DingmoContentType.feed));
        }
        contents.add(SearchProfileItem(
          isMine: false,
          isFollow: false,
          profileId: 1,
          idxTag: IdxTag.coma,
          memberType: MemberType.user,
          nickname: "플래너 ${idx + 1}",
          profileUrl: "https://picsum.photos/id/${567 + idx}/40/40",
          previews: previewList,
        ));
      }
      return contents;
    });
  }
}
