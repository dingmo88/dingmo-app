import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_search.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/main/home/items/search_recommend_item.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

import '../../../../constants/colors.dart';
import 'search_recommends_item.dart';
import 'search_tag_chip.dart';

class SearchRecommendsWidget extends StatefulWidget {
  final void Function(String tag) onTagPressed;
  final void Function(SearchRecommendFeedItem item) onContentPressed;
  const SearchRecommendsWidget(
      {Key? key, required this.onTagPressed, required this.onContentPressed})
      : super(key: key);

  @override
  State<SearchRecommendsWidget> createState() => _SearchRecommendsWidgetState();
}

class _SearchRecommendsWidgetState extends State<SearchRecommendsWidget> {
  late final Future<SearchRecommendItem?> itemFuture;

  Future<SearchRecommendItem?> getRecommends() async {
    try {
      final result = (await getIt<ApiSearch>().getContentPanel()).result;

      return SearchRecommendItem(
          tags: result.popularKeywords,
          feeds: result.contents
              .map((e) => SearchRecommendFeedItem(
                  contentId: e.contentId,
                  contentType: valueToCtType(e.contentType)!,
                  thumbUrl: path.join(Endpoints.imgUrl, e.thumbImgKey),
                  description: e.summary,
                  nickname: e.nickname))
              .toList());
    } catch (e) {
      safePrint("exception: $e");
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    itemFuture = getRecommends();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SearchRecommendItem?>(
      future: itemFuture,
      builder:
          (BuildContext context, AsyncSnapshot<SearchRecommendItem?> snapshot) {
        if (!snapshot.hasData) {
          return Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.only(top: 60),
            child: CircularProgressIndicator(
              color: AppColors.mediumPink,
              strokeWidth: 2,
            ),
          );
        } else {
          if (snapshot.data == null) {
            Fluttertoast.showToast(msg: "잘못된 접근입니다");
            return Container();
          }

          SearchRecommendItem item = snapshot.data!;

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 20),
                width: double.infinity,
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: "많이 찾는  ",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.greyishBrown,
                          fontWeight: FontWeight.w700)),
                  TextSpan(
                      text: "키워드",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.mediumPink,
                          fontWeight: FontWeight.w700))
                ])),
              ),
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 15,
                runSpacing: 15,
                children: item.tags
                    .map((tag) => SearchTagChip(
                        text: tag, onPressed: () => widget.onTagPressed(tag)))
                    .toList(),
              ),
              const SizedBox(height: 120),
              Container(
                margin: const EdgeInsets.only(left: 20),
                width: double.infinity,
                child: Text(
                  "이번 주 추천 게시물",
                  style: TextStyle(
                      fontSize: 17,
                      color: AppColors.greyishBrown,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 225,
                child: ScrollConfiguration(
                    behavior: NoGlowBehavior(),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: item.feeds.length,
                        itemBuilder: (context, index) => Padding(
                              padding:
                                  EdgeInsets.only(left: index == 0 ? 20 : 0),
                              child: SearchRecommendsItemWidget(
                                  onPressed: () => widget
                                      .onContentPressed(item.feeds[index]),
                                  item: item.feeds[index]),
                            ))),
              )
            ],
          );
        }
      },
    );
  }
}
