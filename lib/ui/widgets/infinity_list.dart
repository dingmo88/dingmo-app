import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'loading.dart';

class InfinityListWidget<T> extends StatefulWidget {
  final Widget? header;
  final Widget Function(BuildContext context)? initLoadingBuilder;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Future<List<T>?> Function(int page, int size) onLoad;
  final Widget? notFoundWidget;
  final InfinityListController<T>? controller;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;
  final int pageSize;

  const InfinityListWidget({
    Key? key,
    this.header,
    this.initLoadingBuilder,
    required this.itemBuilder,
    required this.onLoad,
    required this.pageSize,
    this.controller,
    this.scrollController,
    this.notFoundWidget,
    this.physics,
  }) : super(key: key);

  @override
  State<InfinityListWidget<T>> createState() => _InfinityListWidgetState<T>();
}

class _InfinityListWidgetState<T> extends State<InfinityListWidget<T>> {
  int page = 0;

  bool isLoadingNewItems = false;
  bool addedScrollListener = false;
  bool isLastPageLoaded = false;

  late final ScrollController scrollController;
  late final ScrollPhysics physics;
  late final Widget header;

  late final Future<void> getItemsFuture;
  final List<T> itemList = [];

  @override
  void initState() {
    super.initState();

    header = widget.header ?? Container();

    physics = widget.physics ?? const AlwaysScrollableScrollPhysics();
    getItemsFuture = loadItemList();

    scrollController = widget.scrollController ?? ScrollController();
    scrollController.addListener(handleScrollListener);

    widget.controller?.state = this;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: widget.physics,
      controller: scrollController,
      child: Column(children: [
        header,
        FutureBuilder(
            future: getItemsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return widget.initLoadingBuilder != null
                    ? widget.initLoadingBuilder!(context)
                    : const SizedBox(
                        height: 80,
                        child: DingmoProgressIndicator(size: 40),
                      );
              }

              return StatefulBuilder(builder: (context, setState) {
                return itemList.isNotEmpty
                    ? ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          ...(itemList
                              .asMap()
                              .map((index, item) => MapEntry(
                                  index,
                                  VisibilityDetector(
                                      key: Key("item-$index"),
                                      onVisibilityChanged:
                                          (VisibilityInfo info) {
                                        handleLastItemShownCompletely(
                                            index, info);
                                      },
                                      child: widget.itemBuilder(
                                          context, item, index))))
                              .values
                              .toList()),
                          !isLastPageLoaded &&
                                  itemList.length >= widget.pageSize
                              ? const DingmoProgressIndicator(
                                  size: 40,
                                  margin: EdgeInsets.only(top: 20, bottom: 20))
                              : const SizedBox(height: 10)
                        ],
                      )
                    : widget.notFoundWidget ?? Container();
              });
            }),
        const SizedBox(height: 64)
      ]),
    );
  }

  void handleScrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      loadItemList();
    }
  }

  bool isLastItemShownCompletely(int index, VisibilityInfo info) {
    bool isLastIndex = index >= itemList.length - 1;
    bool isShownCompletely = info.visibleFraction * 100 == 100.0;

    return isLastIndex && isShownCompletely;
  }

  void handleLastItemShownCompletely(int index, VisibilityInfo info) {
    if (isLastItemShownCompletely(index, info)) {
      if (!isLoadingNewItems && itemList.length >= widget.pageSize) {
        loadItemList();
      }
    }
  }

  Future<void> loadItemList() async {
    if (isLastPageLoaded) {
      return;
    }

    isLoadingNewItems = true;

    final List<T> newItems = await getItemList() ?? [];
    itemList.addAll(newItems);

    isLastPageLoaded = newItems.isEmpty;

    isLoadingNewItems = false;
    setState(() {});
  }

  Future<List<T>?> getItemList() async {
    return widget.onLoad(++page, widget.pageSize);
  }

  void addItemFirst(T item) {
    setState(() {
      itemList.insert(0, item);
    });
  }

  void addItemLast(T item) {
    setState(() {
      itemList.add(item);
    });
  }

  void remove(T item) {
    setState(() {
      itemList.remove(item);
    });
  }

  void animateTo(double offset, Duration duration, Curve curve) {
    scrollController.animateTo(offset, duration: duration, curve: curve);
  }
}

class InfinityListController<T> {
  // ignore: library_private_types_in_public_api
  _InfinityListWidgetState? state;
  final void Function(T item)? onAddItemFirst;
  final void Function(T item)? onAddItemLast;

  InfinityListController({
    this.onAddItemFirst,
    this.onAddItemLast,
  });

  void addItemFirst(T item) {
    state!.addItemFirst(item);
    if (onAddItemFirst != null) {
      onAddItemFirst!(item);
    }
  }

  void addItemLast(T item) {
    state!.addItemLast(item);
    if (onAddItemLast != null) {
      onAddItemLast!(item);
    }
  }

  void remove(T item) {
    state!.remove(item);
  }

  void animateToTop(Duration duration, Curve curve) {
    state!.animateTo(0, duration, curve);
  }

  void animateToBottom(Duration duration, Curve curve) {
    state!.animateTo(
        state!.scrollController.position.maxScrollExtent, duration, curve);
  }
}
