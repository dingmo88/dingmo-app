import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/routes/arguments/arg_comp_profile.dart';
import 'package:dingmo/routes/arguments/arg_plan_profile.dart';
import 'package:dingmo/routes/arguments/arg_single_reels.dart';
import 'package:dingmo/routes/arguments/arg_view_feed_item.dart';
import 'package:dingmo/ui/widgets/follow_button.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/type.dart';
import '../../../commons/items/feed_item.dart';
import '../../../widgets/texts.dart';
import '../items/planner_details_item.dart';

class SearchProfileItemWidget extends StatefulWidget {
  final SearchProfileItem item;
  const SearchProfileItemWidget({Key? key, required this.item})
      : super(key: key);

  @override
  State<SearchProfileItemWidget> createState() =>
      _SearchProfileItemWidgetState();
}

class _SearchProfileItemWidgetState extends State<SearchProfileItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(children: [
        GestureDetector(
          onTap: () {
            switch (widget.item.memberType) {
              case MemberType.comp:
                Navigator.pushNamed(context, Routes.compProfile,
                    arguments:
                        CompProfileArgs(profileId: widget.item.profileId));
                break;
              case MemberType.plan:
                Navigator.pushNamed(context, Routes.planProfile,
                    arguments:
                        PlanProfileArgs(profileId: widget.item.profileId));
                break;
              case MemberType.user:
                Navigator.pushNamed(context, Routes.userProfile);
                break;
            }
          },
          child: Container(
            color: Colors.transparent,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            color: AppColors.greyWhite,
                            border: Border.all(
                                color: AppColors.greyWhite, width: 1),
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                              imageUrl: widget.item.profileUrl,
                              fit: BoxFit.cover,
                              errorWidget: (context, exception, stackTrace) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    "assets/dingmo.png",
                                  ),
                                );
                              }),
                        )),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.nickname,
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyishBrown,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.item.memberType != MemberType.comp
                              ? memberTypeToString(widget.item.memberType)
                              : idxTagToString(widget.item.idxTag),
                          style: TextStyle(
                              fontSize: 12, color: AppColors.veryLightPink),
                        ),
                      ],
                    )
                  ],
                ),
                Visibility(
                    maintainState: true,
                    visible: !widget.item.isMine,
                    child: FollowButton(
                      profileId: widget.item.profileId,
                      initIsFollow: widget.item.isFollow,
                      backgroundColor:
                          widget.item.isFollow ? Colors.white : null,
                    ))
              ],
            ),
          ),
        ),
        Visibility(
          visible: widget.item.previews.isNotEmpty,
          child: const SizedBox(height: 15),
        ),
        Visibility(
            visible: widget.item.previews.isNotEmpty,
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.width * 0.2917,
              child: ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.item.previews.length,
                      itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
                            child: PlannerDetailsPreviewItemWidget(
                                item: widget.item.previews[index]),
                          ))),
            ))
      ]),
    );
  }
}

class PlannerDetailsPreviewItemWidget extends StatelessWidget {
  final ProfileDetailsPreviewItem item;
  const PlannerDetailsPreviewItemWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.contentType == DingmoContentType.reels) {
          Navigator.pushNamed(context, Routes.singleReels,
              arguments: SingleReelsArgs(contentId: item.contentId));
        } else if (item.contentType == DingmoContentType.feed) {
          Navigator.pushNamed(context, Routes.viewFeedItem,
              arguments: ViewFeedItemArgs(contentId: item.contentId));
        } else {
          Fluttertoast.showToast(msg: "잘못된 유형입니다");
        }
      },
      child: Stack(children: [
        Container(
            margin: const EdgeInsets.only(right: 15),
            alignment: Alignment.center,
            child: Container(
                width: MediaQuery.of(context).size.width * 0.2917,
                height: MediaQuery.of(context).size.width * 0.2917,
                decoration: BoxDecoration(
                    color: AppColors.purpleGrey,
                    borderRadius: BorderRadius.circular(5)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: item.thumbnailUrl,
                          width: MediaQuery.of(context).size.width * 0.2917,
                          height: MediaQuery.of(context).size.width * 0.2917,
                          fit: BoxFit.cover,
                          errorWidget: (context, exception, stackTrace) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/dingmo.png",
                              ),
                            );
                          },
                        ),
                        Visibility(
                            visible:
                                item.contentType == DingmoContentType.reels,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.2917,
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
                    )))),
        Visibility(
            visible: item.contentType == DingmoContentType.reels,
            child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10),
                width: MediaQuery.of(context).size.width * 0.2917,
                height: MediaQuery.of(context).size.width * 0.2917,
                alignment: Alignment.bottomLeft,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/home/icon_awesome_play.svg"),
                    const SizedBox(width: 4),
                    Texts.defaultText(
                        text: item.viewCount.toString(),
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
