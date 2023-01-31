import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/routes/arguments/arg_single_reels.dart';
import 'package:dingmo/routes/arguments/arg_view_feed_item.dart';
import 'package:dingmo/routes/arguments/args_search_result.dart';
import 'package:dingmo/ui/main/home/widgets/search_recents.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/input_forms.dart';
import 'items/search_recommend_item.dart';
import 'widgets/search_recommends.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final FocusNode searchFocusNode = FocusNode();
  final TextEditingController searchFormController = TextEditingController();
  SearchPageType pageType = SearchPageType.recommend;

  @override
  void initState() {
    super.initState();

    searchFocusNode.addListener(() {
      if (hasChangedIntoFocus()) {
        setState(() => pageType = SearchPageType.recents);
      } else if (hasChangedIntoUnfocus()) {
        setState(() => pageType = SearchPageType.recommend);
      }
    });
  }

  bool hasChangedIntoFocus() {
    return isPageTypeRecommend() && isSearchFormFocused();
  }

  bool hasChangedIntoUnfocus() {
    return isPageTypeRecents() && !isSearchFormFocused();
  }

  bool isPageTypeRecommend() {
    return pageType == SearchPageType.recommend;
  }

  bool isPageTypeRecents() {
    return pageType == SearchPageType.recents;
  }

  bool isSearchFormFocused() {
    return searchFocusNode.hasFocus;
  }

  void clearSearchForm() {
    searchFocusNode.unfocus();
    setState(() {
      searchFormController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (isSearchFormFocused()) {
            clearSearchForm();
            return false;
          }
          return true;
        },
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Stack(children: [
                Visibility(
                    visible: isPageTypeRecents(),
                    child: SearchRecentsWidget(
                      onItemPressed: (String keyword) {
                        clearSearchForm();
                        Navigator.pushNamed(context, Routes.searchResult,
                            arguments: SearchResultArgs(keyword: keyword));
                      },
                    )),
                Column(
                  children: [
                    Container(
                      color: Colors.white,
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
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
                                      onTap:
                                          searchFormController.text.isNotEmpty
                                              ? () => setState(() =>
                                                  searchFormController.clear())
                                              : null,
                                      child: Container(
                                        color: Colors.transparent,
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.all(12),
                                        child:
                                            searchFormController.text.isNotEmpty
                                                ? SvgPicture.asset(
                                                    "assets/home/tag_delete_icon.svg",
                                                  )
                                                : SvgPicture.asset(
                                                    "assets/home/search_icon.svg",
                                                  ),
                                      )),
                                  onSubmitted: (keyword) {
                                    Navigator.pushNamed(
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
                            visible: isPageTypeRecents(),
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.only(bottom: 20),
                              alignment: Alignment.centerLeft,
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
                    Visibility(
                        maintainState: true,
                        visible: isPageTypeRecommend(),
                        child: SearchRecommendsWidget(
                          onContentPressed: (SearchRecommendFeedItem item) {
                            if (item.contentType == DingmoContentType.feed) {
                              Navigator.pushNamed(
                                context,
                                Routes.viewFeedItem,
                                arguments:
                                    ViewFeedItemArgs(contentId: item.contentId),
                              );
                            } else {
                              Navigator.pushNamed(
                                context,
                                Routes.singleReels,
                                arguments:
                                    SingleReelsArgs(contentId: item.contentId),
                              );
                            }
                          },
                          onTagPressed: (String tag) {
                            Navigator.pushNamed(context, Routes.searchResult,
                                arguments: SearchResultArgs(keyword: tag));
                          },
                        )),
                  ],
                ),
              ]),
            )));
  }
}

enum SearchPageType { recommend, recents }
