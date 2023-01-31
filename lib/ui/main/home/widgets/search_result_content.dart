import 'dart:math';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_search.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/main/home/widgets/search_result_item.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

import '../../../widgets/loading.dart';
import '../../../../routes/arguments/args_search_result.dart';
import '../items/search_result_item.dart';

class SearchResultContentsWidget extends StatefulWidget {
  final String keyword;
  final int area1Id;
  final int area2Id;
  final SearchResultItem searchResult;
  final SearchResultArgs Function() onRoutePlannersDetails;
  const SearchResultContentsWidget(
      {Key? key,
      required this.keyword,
      required this.area1Id,
      required this.area2Id,
      required this.searchResult,
      required this.onRoutePlannersDetails})
      : super(key: key);

  @override
  State<SearchResultContentsWidget> createState() =>
      _SearchResultContentsWidgetState();
}

class _SearchResultContentsWidgetState
    extends State<SearchResultContentsWidget> {
  final int pageSize = 10;
  int page = 0;
  int maxContentLoad = 5;
  int currentContentLoad = 1;

  final ScrollController contentGridController = ScrollController();
  bool isAddedScrollListener = false;
  bool isLoadingNewContents = false;
  late bool isLastContentsLoaded;

  @override
  void initState() {
    super.initState();

    isLastContentsLoaded = widget.searchResult.contents.length < pageSize;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        controller: getController(contentGridController, setState),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Visibility(
                visible: widget.searchResult.planners.isNotEmpty,
                child: SizedBox(
                    height: MediaQuery.of(context).size.width * 93 / 360,
                    child: ScrollConfiguration(
                      behavior: NoGlowBehavior(),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.searchResult.planners.length + 1,
                          itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Fluttertoast.showToast(msg: "hello");
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: index == 0 ? 20 : 0),
                                  child: index >=
                                          widget.searchResult.planners.length
                                      ? Visibility(
                                          // visible: widget.searchResult.planners
                                          //         .length >
                                          //     10,
                                          child:
                                              SearchResultPlannerMoreInfoButton(
                                          filter:
                                              widget.onRoutePlannersDetails(),
                                        ))
                                      : SearchResultPlannerItemWidget(
                                          planner: widget
                                              .searchResult.planners[index]),
                                ),
                              )),
                    ))),
            Visibility(
              visible: widget.searchResult.planners.isNotEmpty,
              child: const SizedBox(height: 30),
            ),
            GridView.count(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
              childAspectRatio: 155 / 223,
              children: widget.searchResult.contents
                  .map(
                      (content) => SearchResultContentItemWidget(item: content))
                  .toList(),
            ),
            Visibility(
                visible: !isLastContentsLoaded,
                child: const DingmoProgressIndicator(
                    size: 40, margin: EdgeInsets.symmetric(vertical: 20))),
            Visibility(
                visible: isLastContentsLoaded,
                child: const SizedBox(
                  height: 40,
                ))
          ],
        ));
  }

  ScrollController getController(ScrollController scrollController,
      void Function(void Function()) setState) {
    if (isAddedScrollListener) {
      return scrollController;
    } else {
      isAddedScrollListener = true;
      return scrollController
        ..addListener(() => handleScrollListener(scrollController, setState));
    }
  }

  void handleScrollListener(ScrollController scrollController,
      void Function(void Function()) setState) {
    if (contentGridController.position.pixels >=
            contentGridController.position.maxScrollExtent &&
        !isLoadingNewContents &&
        !isLastContentsLoaded) {
      isLoadingNewContents = true;
      getMoreContents().then((_) => setState(() {
            isLoadingNewContents = false;
          }));
    }
  }

  Future<void> getMoreContents() async {
    if (isLastContentsLoaded) {
      return;
    }

    final List<SearchResultContentItem> newItems = await _searchContents();

    widget.searchResult.contents.addAll(newItems);
    isLastContentsLoaded = newItems.isEmpty;
  }

  Future<List<SearchResultContentItem>> _searchContents() async {
    final request = GetSearchRequest(
        keyword: widget.keyword,
        area1Id: widget.area1Id,
        area2Id: widget.area2Id,
        page: ++page,
        size: pageSize);

    try {
      return (getIt<MemberInfo>().isGuest()
              ? await getIt<ApiSearch>().getContentGuest(request)
              : await getIt<ApiSearch>().getContent(request))
          .result
          .map((e) => SearchResultContentItem(
              contentId: e.contentId,
              contentType: valueToCtType(e.contentType)!,
              thumbnailUrl: path.join(Endpoints.imgUrl, e.thumbImgKey),
              title: e.summary,
              viewCount: e.viewCnt,
              bookmarkCount: e.bmkCnt,
              bmkId: e.bmkId))
          .toList();
    } catch (e) {
      safePrint(e);
    }

    return [];
  }

  String getTitle(int idx) {
    return [
      "코이웨딩홀에서 5월의 신부 웨딩마치 올렸어요~ ${idx + 1}",
      "천고 낮은 웨딩홀 괜찮은듯! ${idx + 1}",
      "천고 낮은 웨딩홀 괜찮은듯! ${idx + 1}",
      "화사한 생화 꽃으로 되어있어 어떻게 찍어도 화보로 나오네요! ${idx + 1}",
      "화사한 생화 꽃으로 되어있어 어떻게 찍어도 화보로 나오네요! ${idx + 1}",
    ][randomNum(0, 4)];
  }

  int randomNum(int min, int max) => min + Random().nextInt(max - min);
}
