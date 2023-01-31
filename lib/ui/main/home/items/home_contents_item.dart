import 'package:dingmo/ui/main/home/items/planner_profile_item.dart';

import 'main_tagdata_item.dart';

class HomeTabContentsItem {
  final List<HomeTabPlannerProfileItem> plannerProfileItems;
  final List<MainTagDataItem> mainTagItems;

  HomeTabContentsItem({
    required this.plannerProfileItems,
    required this.mainTagItems,
  });
}
