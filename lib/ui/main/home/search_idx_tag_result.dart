import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_search.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/main/home/items/search_result_item.dart';
import 'package:dingmo/ui/main/home/widgets/search_result_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class SearchIdxTagResultPage extends StatefulWidget {
  final int idxTag;
  const SearchIdxTagResultPage({Key? key, required this.idxTag})
      : super(key: key);

  @override
  State<SearchIdxTagResultPage> createState() => _SearchIdxTagResultPageState();
}

class _SearchIdxTagResultPageState extends State<SearchIdxTagResultPage> {
  final int pageSize = 10;
  int page = 0;

  final ScrollController contentGridController = ScrollController();
  bool isAddedScrollListener = false;
  bool isLoadingNewContents = false;
  late bool isLastContentsLoaded;

  final List<SearchResultContentItem> contents = [];
  late final Future<void> _loadIdxSearchContentsFuture;

  @override
  void initState() {
    super.initState();

    _loadIdxSearchContentsFuture = _loadIdxSearchContents()
        .then((_) => isLastContentsLoaded = contents.length < pageSize);
  }

  Future<void> _loadIdxSearchContents() async {
    contents.addAll(await _getIdxSearchContents());
  }

  Future<List<SearchResultContentItem>> _getIdxSearchContents() async {
    try {
      return (getIt<MemberInfo>().isGuest()
              ? await getIt<ApiSearch>().getContentIdxTagGuest(
                  GetSearchIdxTagRequest(
                      idxTag: widget.idxTag, page: ++page, size: pageSize))
              : await getIt<ApiSearch>().getContentIdxTag(
                  GetSearchIdxTagRequest(
                      idxTag: widget.idxTag, page: ++page, size: pageSize)))
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
      safePrint("exception: $e");
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context,
          title: "#${idxTagToString(valueToIdxTag(widget.idxTag))}"),
      body: SafeArea(
          child: FutureBuilder(
              future: _loadIdxSearchContentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return Container();
                }

                return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: getController(contentGridController, setState),
                    child: Column(
                      children: [
                        GridView.count(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 20,
                          childAspectRatio: 155 / 223,
                          children: contents
                              .map((content) =>
                                  SearchResultContentItemWidget(item: content))
                              .toList(),
                        ),
                        Visibility(
                            visible: !isLastContentsLoaded,
                            child: const DingmoProgressIndicator(
                                size: 40,
                                margin: EdgeInsets.symmetric(vertical: 20))),
                        Visibility(
                            visible: isLastContentsLoaded,
                            child: const SizedBox(
                              height: 40,
                            ))
                      ],
                    ));
              })),
    );
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

    final List<SearchResultContentItem> newItems =
        await _getIdxSearchContents();

    contents.addAll(newItems);
    isLastContentsLoaded = newItems.isEmpty;
  }
}
