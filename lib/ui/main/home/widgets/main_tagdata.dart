import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/routes/arguments/arg_single_reels.dart';
import 'package:dingmo/routes/arguments/arg_view_feed_item.dart';
import 'package:dingmo/routes/arguments/args_search_idx_tag_result.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/main/home/items/main_tagdata_item.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/colors.dart';
import '../../../commons/items/feed_item.dart';

const _contentRatio = 150 / 360;

class HomeTabMainTagDataWidget extends StatefulWidget {
  final MainTagDataItem mainTagData;
  const HomeTabMainTagDataWidget({Key? key, required this.mainTagData})
      : super(key: key);

  @override
  State<HomeTabMainTagDataWidget> createState() =>
      _HomeTabMainTagDataWidgetState();
}

class _HomeTabMainTagDataWidgetState extends State<HomeTabMainTagDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.searchIdxTagResult,
                      arguments: SearchIdxTagResultArgs(
                          idxTag: widget.mainTagData.idxTag));
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Texts.defaultText(
                            text: "#${widget.mainTagData.title}",
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ]),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.searchIdxTagResult,
                      arguments: SearchIdxTagResultArgs(
                          idxTag: widget.mainTagData.idxTag));
                },
                child: Container(
                    color: Colors.transparent,
                    margin: const EdgeInsets.only(right: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: SvgPicture.asset("assets/home/right_icon.svg")),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
            alignment: Alignment.centerLeft,
            height:
                MediaQuery.of(context).size.width * _contentRatio * (150 / 100),
            child: ScrollConfiguration(
              behavior: NoGlowBehavior(),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: widget.mainTagData.contents.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.searchIdxTagResult,
                            arguments: SearchIdxTagResultArgs(
                                idxTag: widget.mainTagData.idxTag));
                      },
                      child: Container(
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
                            child: MainTagContentWidget(
                              contentItem: widget.mainTagData.contents[index],
                            ),
                          )),
                    );
                  })),
            )),
      ]),
    );
  }
}

class MainTagContentWidget extends StatefulWidget {
  final MainTagContentItem contentItem;
  const MainTagContentWidget({Key? key, required this.contentItem})
      : super(key: key);

  @override
  State<MainTagContentWidget> createState() => _MainTagContentWidgetState();
}

class _MainTagContentWidgetState extends State<MainTagContentWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.contentItem.type == DingmoContentType.reels) {
          Navigator.pushNamed(context, Routes.singleReels,
              arguments:
                  SingleReelsArgs(contentId: widget.contentItem.contentId));
        } else {
          Navigator.pushNamed(context, Routes.viewFeedItem,
              arguments:
                  ViewFeedItemArgs(contentId: widget.contentItem.contentId));
        }
      },
      child: Stack(children: [
        Container(
            margin: const EdgeInsets.only(right: 15),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * _contentRatio,
                    height: MediaQuery.of(context).size.width * _contentRatio,
                    decoration: BoxDecoration(
                        color: AppColors.greyWhite,
                        borderRadius: BorderRadius.circular(5)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: widget.contentItem.thumbnailUrl,
                              width: MediaQuery.of(context).size.width *
                                  _contentRatio,
                              height: MediaQuery.of(context).size.width *
                                  _contentRatio,
                              fit: BoxFit.cover,
                              errorWidget: (context, exception, stackTrace) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/dingmo.png",
                                  ),
                                );
                              },
                            ),
                            Visibility(
                                visible: widget.contentItem.type ==
                                    DingmoContentType.reels,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          _contentRatio,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [
                                            Colors.black.withOpacity(0.15),
                                            Colors.transparent
                                          ],
                                        ),
                                      )),
                                ))
                          ],
                        ))),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * _contentRatio,
                  padding: const EdgeInsets.only(right: 4),
                  child: Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    widget.contentItem.title,
                    style: TextStyle(
                        fontSize: 13,
                        height: 1.2,
                        color: AppColors.greyishBrown,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            )),
        Visibility(
            visible: widget.contentItem.type == DingmoContentType.reels,
            child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                width: MediaQuery.of(context).size.width * _contentRatio,
                height: MediaQuery.of(context).size.width * _contentRatio,
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/home/icon_awesome_play.svg"),
                    const SizedBox(width: 4),
                    Texts.defaultText(
                        text: widget.contentItem.viewCount.toString(),
                        fontSize: 13,
                        color: Colors.white)
                  ],
                )))
      ]),
    );
  }

  Future<List<FeedItem>> getFeeds(
      {required int startIdx, required int itemCount}) {
    return Future.delayed(const Duration(seconds: 1), () {
      final List<FeedItem> newFeeds = [];

      if (itemCount > 50) {
        return newFeeds;
      }

      return newFeeds;
    });
  }
}
