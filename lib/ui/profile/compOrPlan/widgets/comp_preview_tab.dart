import 'package:flutter/material.dart';

import '../../../../../../constants/colors.dart';
import 'comp_preview_feeds_tab.dart';
import 'comp_preview_reviews_tab.dart';

class CompEditPreviewTab extends StatefulWidget {
  const CompEditPreviewTab({Key? key}) : super(key: key);

  @override
  State<CompEditPreviewTab> createState() => _CompEditPreviewTabState();
}

class _CompEditPreviewTabState extends State<CompEditPreviewTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          TabBar(
              labelColor: AppColors.greyishBrown,
              unselectedLabelColor: AppColors.greyishBrown.withOpacity(0.6),
              indicatorColor: AppColors.greyishBrown,
              tabs: const [
                Tab(text: "게시물", height: 45),
                Tab(text: "후기(0)", height: 45),
              ]),
          const SizedBox(
            height: 300,
            child: TabBarView(children: [
              CompEditPreviewFeedsTab(),
              CompEditPreviewReviewsTab()
            ]),
          ),
        ],
      ),
    );
  }
}
