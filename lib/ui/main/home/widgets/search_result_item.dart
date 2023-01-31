import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/routes/arguments/arg_search_profiles.dart';
import 'package:dingmo/routes/arguments/arg_single_reels.dart';
import 'package:dingmo/routes/arguments/arg_view_feed_item.dart';
import 'package:dingmo/routes/arguments/args_search_result.dart';
import 'package:dingmo/ui/main/home/items/search_result_item.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/widgets/bookmark_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/texts.dart';

class SearchResultPlannerItemWidget extends StatelessWidget {
  final SearchResultPlannerItem planner;
  const SearchResultPlannerItemWidget({Key? key, required this.planner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: MediaQuery.of(context).size.width * 0.16,
                height: MediaQuery.of(context).size.width * 0.16,
                decoration: BoxDecoration(
                    color: AppColors.greyWhite,
                    border: Border.all(color: AppColors.greyWhite, width: 1),
                    borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                      imageUrl: planner.profileUrl,
                      fit: BoxFit.cover,
                      errorWidget: (context, exception, stackTrace) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/dingmo.png",
                          ),
                        );
                      }),
                )),
            const SizedBox(height: 10),
            Texts.defaultText(text: planner.nickname, fontSize: 13)
          ]),
    );
  }
}

class SearchResultPlannerMoreInfoButton extends StatelessWidget {
  final SearchResultArgs filter;
  const SearchResultPlannerMoreInfoButton({Key? key, required this.filter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.searchProfiles,
          arguments: SearchProfilesArgs(
              memberType: MemberType.plan, keyword: filter.keyword)),
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width * 0.16,
                  height: MediaQuery.of(context).size.width * 0.16,
                  decoration: BoxDecoration(
                      color: AppColors.greyWhite,
                      border: Border.all(color: AppColors.greyWhite, width: 1),
                      borderRadius: BorderRadius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        "assets/home/right_icon.svg",
                      ),
                    ),
                  )),
              const SizedBox(height: 10),
              Texts.defaultText(text: "더보기", fontSize: 13)
            ]),
      ),
    );
  }
}

class SearchResultContentItemWidget extends StatefulWidget {
  final SearchResultContentItem item;
  const SearchResultContentItemWidget({Key? key, required this.item})
      : super(key: key);

  @override
  State<SearchResultContentItemWidget> createState() =>
      _SearchResultContentItemWidgetState();
}

class _SearchResultContentItemWidgetState
    extends State<SearchResultContentItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.item.contentType == DingmoContentType.feed) {
          Navigator.pushNamed(context, Routes.viewFeedItem,
              arguments: ViewFeedItemArgs(contentId: widget.item.contentId));
        } else {
          Navigator.pushNamed(context, Routes.singleReels,
              arguments: SingleReelsArgs(contentId: widget.item.contentId));
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Stack(fit: StackFit.expand, children: [
                    Container(
                      color: AppColors.greyWhite,
                      child: CachedNetworkImage(
                          imageUrl: widget.item.thumbnailUrl,
                          fit: BoxFit.cover,
                          errorWidget: (context, exception, stackTrace) {
                            return Container(
                              color: AppColors.greyWhite,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/dingmo.png",
                              ),
                            );
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 15),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Visibility(
                                      visible: widget.item.contentType ==
                                          DingmoContentType.reels,
                                      maintainState: true,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/home/icon_awesome_play.svg"),
                                          const SizedBox(width: 4),
                                          Text(
                                            widget.item.viewCount.toString(),
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.white),
                                          ),
                                        ],
                                      )),
                                  BookmarkButton(
                                    bmkId: widget.item.bmkId,
                                    contentId: widget.item.contentId,
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ])),
            ),
            Container(
                padding: const EdgeInsets.only(top: 10, right: 16),
                child: Text(
                  widget.item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, color: AppColors.greyishBrown),
                )),
            const SizedBox(height: 10),
            Text(
              "북마크 ${widget.item.bookmarkCount}",
              style: TextStyle(fontSize: 12, color: AppColors.veryLightPink),
            )
          ],
        ),
      ),
    );
  }
}
