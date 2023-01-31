import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/widgets/dark_status_bar.dart';
import 'package:dingmo/ui/widgets/reels_view_pager.dart';
import 'package:dingmo/utils/reels_paging_manager.dart';
import 'package:flutter/material.dart';

import 'widgets/reels_action/reels_action_default.dart';
import 'widgets/reels_view/reels_viewpage.dart';

class ReelsListPage extends StatefulWidget {
  final bool Function()? isPlayable;
  const ReelsListPage({Key? key, this.isPlayable}) : super(key: key);

  @override
  State<ReelsListPage> createState() => _ReelsListPageState();
}

class _ReelsListPageState extends State<ReelsListPage> {
  late final ReelsPagingManager reelsPagingManager =
      getIt<ReelsPagingManager>();

  @override
  Widget build(BuildContext context) {
    return DarkStatusBarWidget(
      isLightIcon: false,
      child: FutureBuilder(
        future: reelsPagingManager.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: ReelsViewPager(
                controller:
                    PageController(initialPage: reelsPagingManager.centerIdx),
                scrollDirection: Axis.vertical,
                extents: 2,
                physics: const PageScrollPhysics(),
                pageSnapping: true,
                onPageChanged: reelsPagingManager.setPage,
                itemBuilder: (context, pageIndex) => ReelsViewPage(
                  isPlayable: widget.isPlayable,
                  pageIndex: pageIndex,
                  reelsItemFuture: reelsPagingManager.getReels(pageIndex),
                  onReelsUpdated: () {
                    Navigator.pushReplacementNamed(context, Routes.start);
                  },
                ),
              ),
            );
          } else {
            return const ReelsActionDefaultWidget();
          }
        },
      ),
    );
  }
}
