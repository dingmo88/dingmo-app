import 'dart:async';

import 'package:dingmo/api/api_shorts.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/utils/reels_paging_manager.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';

import 'reels_view.dart';

class ReelsViewPage extends ReelsView {
  final int pageIndex;
  final bool Function()? isPlayable;
  const ReelsViewPage(
      {Key? key,
      required Future<GetShortsResult?> reelsItemFuture,
      required VoidFunc onReelsUpdated,
      required this.pageIndex,
      this.isPlayable})
      : super(
            key: key,
            reelsItemFuture: reelsItemFuture,
            onReelsUpdated: onReelsUpdated);

  @override
  State<StatefulWidget> createState() => ReelsViewPageState();
}

class ReelsViewPageState extends ReelsViewState<ReelsViewPage> {
  late final ReelsPagingManager _reelsPagingManager =
      getIt<ReelsPagingManager>();

  late final StreamSubscription<int> playableIdxListener;

  late final bool Function() isPlayable;

  @override
  Future<void> play() async {
    if (isPlayable()) {
      await super.play();
      await unlockPageSwipe();
    }
  }

  Future<void> unlockPageSwipe() async {
    await _reelsPagingManager.setPageSwipeable();
  }

  bool isMeCurrentPage(int pageIdx) {
    return widget.pageIndex == pageIdx;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (isPlayable()) {
      super.didChangeAppLifecycleState(state);
    }
  }

  @override
  void initState() {
    super.initState();

    playableIdxListener = _reelsPagingManager.playablePageIdx.listen(
        (pageIdx) async =>
            isMeCurrentPage(pageIdx) ? await play() : await pause());

    isPlayable = () =>
        isMeCurrentPage(getIt<ReelsPagingManager>().currentPageIdx) &&
        (widget.isPlayable ?? () => true)();

    play();
  }

  @override
  void dispose() async {
    super.dispose();
    await playableIdxListener.cancel();
  }
}
