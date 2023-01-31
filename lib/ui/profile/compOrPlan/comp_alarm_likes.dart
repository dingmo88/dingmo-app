import 'package:dingmo/ui/profile/compOrPlan/items/alarm_like_user_item.dart';
import 'package:dingmo/ui/profile/compOrPlan/widgets/comp_alarm_like_user_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/infinity_list.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';

class CompAlarmLikesPage extends StatelessWidget {
  const CompAlarmLikesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBars.defaultAppBar(context, title: "좋아요"),
        body: ScrollConfiguration(
          behavior: NoGlowBehavior(),
          child: InfinityListWidget<AlarmLikeUserItem>(
              itemBuilder: (context, item, index) =>
                  CompAlarmLikeUserItemWidget(item: item),
              onLoad: getAlarmLikedUserList,
              pageSize: 10),
        ));
  }

  Future<List<AlarmLikeUserItem>> getAlarmLikedUserList(
      int startIdx, int pageSize) {
    return Future.delayed(const Duration(seconds: 1), () {
      final List<AlarmLikeUserItem> likedusers = [];

      for (int idx = startIdx; idx < startIdx + pageSize; idx++) {
        likedusers.add(AlarmLikeUserItem(
            profileUrl: "https://picsum.photos/id/${567 + idx}/105/105",
            nickname: "woori_wedding_${idx + 1}",
            categoryName: idx % 2 == 0 ? "예비 딩랑님" : "딩모웨딩"));
      }
      return likedusers;
    });
  }
}
