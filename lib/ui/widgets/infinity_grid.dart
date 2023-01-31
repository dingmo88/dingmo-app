import 'package:flutter/material.dart';

import 'loading.dart';

class GridConfig {
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;

  GridConfig({
    required this.crossAxisCount,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    this.childAspectRatio = 1.0,
  });
}

class InfinityGridController<T> {
  // ignore: library_private_types_in_public_api
  _InfinityGridWidgetState? state;

  void reset() {
    state!.reset();
  }

  List<T> getList() {
    return state!.itemList as List<T>;
  }

  void notifyItemChanged() {
    state!.notifyItemChanged();
  }
}

class InfinityGridWidget<T> extends StatefulWidget {
  final Widget Function(BuildContext context, T item) itemBuilder;
  final List<T>? initItems;
  final Future<List<T>> Function(int page, int size) onLoad;
  final int pageSize;
  final GridConfig gridConfig;

  final InfinityGridController<T>? controller;
  final Widget? header;
  final Widget Function(BuildContext context)? initLoadingBuilder;
  final Widget Function(BuildContext context)? noResultBuilder;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;

  const InfinityGridWidget({
    Key? key,
    required this.itemBuilder,
    this.initItems,
    required this.onLoad,
    required this.pageSize,
    required this.gridConfig,
    this.controller,
    this.header,
    this.initLoadingBuilder,
    this.noResultBuilder,
    this.scrollController,
    this.physics,
  }) : super(key: key);

  @override
  State<InfinityGridWidget<T>> createState() => _InfinityGridWidgetState<T>();
}

class _InfinityGridWidgetState<T> extends State<InfinityGridWidget<T>> {
  int page = 0;

  bool isLoadingNewItems = false;
  bool isLastPageLoaded = false;

  final GlobalKey<_InfinityGridWidgetState> globalKey = GlobalKey();
  late final ScrollController scrollController;
  late final ScrollPhysics physics;
  late final Widget header;

  late Future<void> getItemsFuture;
  final List<T> itemList = [];

  @override
  void initState() {
    super.initState();

    header = widget.header ?? Container();

    physics = widget.physics ?? const AlwaysScrollableScrollPhysics();

    if (widget.initItems?.isNotEmpty == true) {
      getItemsFuture = Future.value();
      itemList.addAll(widget.initItems!);
    } else {
      getItemsFuture = loadItemList();
    }

    scrollController = widget.scrollController ?? ScrollController();
    scrollController.addListener(handleScrollListener);

    widget.controller?.state = this;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void reset() {
    setState(() {
      itemList.clear();
      isLastPageLoaded = false;
      getItemsFuture = loadItemList();
    });
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

              if (itemList.isEmpty) {
                if (widget.noResultBuilder != null) {
                  return widget.noResultBuilder!(context);
                }
                return Container();
              }

              return Column(
                children: [
                  GridView.count(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: widget.gridConfig.crossAxisCount,
                    crossAxisSpacing: widget.gridConfig.crossAxisSpacing,
                    mainAxisSpacing: widget.gridConfig.mainAxisSpacing,
                    childAspectRatio: widget.gridConfig.childAspectRatio,
                    children: itemList
                        .map((item) => widget.itemBuilder(context, item))
                        .toList(),
                  ),
                  Visibility(
                      visible: !isLastPageLoaded &&
                          itemList.length >= widget.pageSize,
                      child: const DingmoProgressIndicator(
                          size: 40,
                          margin: EdgeInsets.symmetric(vertical: 20))),
                  Visibility(
                      visible: isLastPageLoaded,
                      child: const SizedBox(
                        height: 40,
                      ))
                ],
              );
            }),
        const SizedBox(height: 64)
      ]),
    );
  }

  void handleScrollListener() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent &&
        !isLoadingNewItems &&
        !isLastPageLoaded) {
      isLoadingNewItems = true;
      loadItemList().then((_) => setState(() {
            isLoadingNewItems = false;
          }));
    }
  }

  Future<void> loadItemList() async {
    if (isLastPageLoaded) {
      return;
    }

    final List<T> newItems = await getItemList();
    itemList.addAll(newItems);

    isLastPageLoaded = newItems.isEmpty;
  }

  Future<List<T>> getItemList() async {
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

  void notifyItemChanged() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent + 0.001);
  }
}
