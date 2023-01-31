import 'dart:math';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_search.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/routes/arguments/args_search_result.dart';
import 'package:dingmo/ui/main/home/widgets/search_result_content.dart';
import 'package:dingmo/ui/widgets/select_area_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as path;

import '../../../constants/type.dart';
import '../../widgets/input_forms.dart';
import '../../widgets/loading.dart';
import 'items/search_result_item.dart';
import 'widgets/search_recents.dart';

class SearchResultPage extends StatefulWidget {
  final SearchResultArgs filter;
  const SearchResultPage({Key? key, required this.filter}) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  late final SearchResultArgs filter;
  late String _areaText;

  late Future<void> getSearchResultFuture;
  SearchResultItem? firstSearchResult;
  late SearchResultItem searchResult;

  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchFormController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filter = widget.filter;
    initAreaText();

    loadSearchResult(filter.keyword);
    searchFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return Stack(
            children: [
              Visibility(
                  visible: !searchFocusNode.hasFocus,
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Visibility(
                        visible: isExistFirstSearchResult(),
                        child: GestureDetector(
                          onTap: () => showAreaInfoSheet(context,
                              ((areaText, area1, area2) {
                            _areaText = areaText;
                            filter.area1Id = area1.areaId;
                            filter.area2Id = area2.areaId;
                            setState(() {
                              loadAreaSearchResult();
                            });
                          })),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 20),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: AppColors.veryLightPink),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _areaText,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.greyishBrown,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SvgPicture.asset(
                                      "assets/home/caret_down_icon.svg"),
                                ]),
                          ),
                        ),
                      ),
                      FutureBuilder(
                          future: getSearchResultFuture,
                          builder: ((context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Container(
                                margin: const EdgeInsets.only(top: 40),
                                alignment: Alignment.topCenter,
                                child: const DingmoProgressIndicator(size: 40),
                              );
                            } else {
                              return isExistSearchResult()
                                  ? Expanded(
                                      child: SearchResultContentsWidget(
                                        keyword: filter.keyword,
                                        area1Id: filter.area1Id ?? 0,
                                        area2Id: filter.area2Id ?? 0,
                                        searchResult: searchResult,
                                        onRoutePlannersDetails: () => filter,
                                      ),
                                    )
                                  : Container(
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(
                                          left: 20, top: 20),
                                      child: Text(
                                        "검색결과가 없습니다.",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: AppColors.veryLightPink),
                                      ),
                                    );
                            }
                          })),
                    ],
                  )),
              searchFormWidget(),
            ],
          );
        },
      )),
    );
  }

  Widget searchFormWidget() {
    return WillPopScope(
      onWillPop: () async {
        if (searchFocusNode.hasFocus) {
          searchFocusNode.unfocus();
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Stack(children: [
          Visibility(
              visible: searchFocusNode.hasFocus,
              child: SearchRecentsWidget(
                onItemPressed: (keyword) {
                  FocusScope.of(context).unfocus();
                  Navigator.pushReplacementNamed(context, Routes.searchResult,
                      arguments: SearchResultArgs(keyword: keyword));
                },
              )),
          Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.maybePop(context);
                          },
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(5),
                            child: const Icon(Icons.arrow_back),
                          )),
                      const SizedBox(width: 10),
                      Flexible(
                        child: InputForms.textInputForm(
                            searchFocusNode,
                            searchFormController,
                            (text) {
                              setState(() {});
                            },
                            hint: "궁금한 웨딩정보를 검색해보세요",
                            suffixIcon: GestureDetector(
                                onTap: searchFormController.text.isNotEmpty
                                    ? () => setState(
                                        () => searchFormController.clear())
                                    : null,
                                child: Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.all(12),
                                  margin: const EdgeInsets.only(right: 10),
                                  child: searchFormController.text.isNotEmpty
                                      ? SvgPicture.asset(
                                          "assets/home/tag_delete_icon.svg",
                                        )
                                      : SvgPicture.asset(
                                          "assets/home/search_icon.svg",
                                        ),
                                )),
                            onSubmitted: (keyword) {
                              FocusScope.of(context).unfocus();
                              Navigator.pushReplacementNamed(
                                  context, Routes.searchResult,
                                  arguments:
                                      SearchResultArgs(keyword: keyword));
                            }),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Visibility(
                      maintainState: true,
                      visible: searchFocusNode.hasFocus,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.white,
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          "최근 검색어",
                          style: TextStyle(
                              fontSize: 13,
                              color: AppColors.greyishBrown,
                              fontWeight: FontWeight.w700),
                        ),
                      ))
                ]),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  void loadSearchResult(String keyword) {
    setState(() {
      searchFocusNode.unfocus();

      filter.keyword = keyword;
      initAreaText();

      firstSearchResult = null;

      searchFormController.text = filter.keyword;

      getSearchResultFuture = getSearchResult();
      getSearchResultFuture.then((_) {
        setState(() {
          firstSearchResult = searchResult;
        });
      });
    });
  }

  void initAreaText() {
    _areaText = "지역 전체";
  }

  void loadAreaSearchResult() {
    getSearchResultFuture = getSearchResult();
  }

  bool isExistSearchResult() {
    return searchResult.planners.isNotEmpty || searchResult.contents.isNotEmpty;
  }

  bool isExistFirstSearchResult() {
    return firstSearchResult?.planners.isNotEmpty == true ||
        firstSearchResult?.contents.isNotEmpty == true;
  }

  Future<void> getSearchResult() async {
    try {
      final result = getIt<MemberInfo>().isGuest()
          ? (await getIt<ApiSearch>().getGuest(GetSearchRequest(
                  keyword: filter.keyword,
                  area1Id: filter.area1Id ?? 0,
                  area2Id: filter.area2Id ?? 0,
                  page: 1,
                  size: 10)))
              .result
          : (await getIt<ApiSearch>().get(GetSearchRequest(
                  keyword: filter.keyword,
                  area1Id: filter.area1Id ?? 0,
                  area2Id: filter.area2Id ?? 0,
                  page: 1,
                  size: 10)))
              .result;

      searchResult = SearchResultItem(
          planners: result.planners
              .map((e) => SearchResultPlannerItem(
                  profileId: e.profileId,
                  profileUrl: path.join(Endpoints.imgUrl, e.profileImgKey),
                  nickname: e.nickname))
              .toList(),
          contents: result.contents
              .map((e) => SearchResultContentItem(
                  contentId: e.contentId,
                  contentType: valueToCtType(e.contentType)!,
                  thumbnailUrl: path.join(Endpoints.imgUrl, e.thumbImgKey),
                  title: e.summary,
                  viewCount: e.viewCnt,
                  bookmarkCount: e.bmkCnt,
                  bmkId: e.bmkId))
              .toList());
      return;
    } catch (e) {
      safePrint("exception: $e");
    }
    searchResult = SearchResultItem(contents: [], planners: []);
  }
}
