import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/infinity_list.dart';
import 'package:flutter/material.dart';

import '../../profile/compOrPlan/items/comp_profile_item.dart';
import '../../profile/compOrPlan/widgets/review_item.dart';

class UserMyReviewsPage extends StatefulWidget {
  const UserMyReviewsPage({Key? key}) : super(key: key);

  @override
  State<UserMyReviewsPage> createState() => _UserMyReviewsPageState();
}

class _UserMyReviewsPageState extends State<UserMyReviewsPage> {
  int maxContentLoad = 5;
  int currentContentLoad = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(
        context,
        title: "내가 남긴 업체 후기",
      ),
      body: InfinityListWidget<ReviewItem>(
        pageSize: 10,
        onLoad: getReviewList,
        itemBuilder: (context, item, index) =>
            ReviewItemWidget(item: item, type: ReviewItemType.inList),
      ),
    );
  }

  Future<List<ReviewItem>> getReviewList(int startIdx, int pageSize) {
    return Future.delayed(const Duration(seconds: 1), () {
      if (currentContentLoad >= maxContentLoad) {
        return [];
      } else {
        currentContentLoad++;
      }
      final List<ReviewItem> contents = [];

      for (int idx = startIdx; idx < startIdx + pageSize; idx++) {
        contents.add(ReviewItem(
            profileUrl: "https://picsum.photos/id/${555 + idx}/240/240",
            nickname: "김우리 ${idx + 1}",
            dateCreated: "2022.04.23",
            stars: idx % 5 + 1,
            comment:
                "제가 입어본 드레스 중에 제일 마음에 쏙 들었어요. 강추하는 몇 안되는 예쁜 곳이에요. 완전 만족스럽습니다. ${idx + 1}",
            imgUrls: [
              "https://picsum.photos/id/${611 + idx}/120/120",
              "https://picsum.photos/id/${622 + idx}/120/120",
              "https://picsum.photos/id/${633 + idx}/120/120",
              "https://picsum.photos/id/${644 + idx}/120/120",
              "https://picsum.photos/id/${655 + idx}/120/120",
              "https://picsum.photos/id/${666 + idx}/120/120",
              "https://picsum.photos/id/${677 + idx}/120/120",
              "https://picsum.photos/id/${688 + idx}/120/120",
              "https://picsum.photos/id/${699 + idx}/120/120",
              "https://picsum.photos/id/${700 + idx}/120/120",
            ],
            commentCount: idx,
            isLiked: idx % 3 == 0,
            isMine: idx % 5 == 0,
            likeCount: idx + 1));
      }

      return contents;
    });
  }
}
