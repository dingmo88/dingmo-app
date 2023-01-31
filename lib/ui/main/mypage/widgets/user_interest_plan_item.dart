import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/routes/arguments/arg_feeds.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/main/mypage/items/user_interest_plan_item.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/type.dart';
import '../../../commons/items/feed_item.dart';
import '../../../widgets/texts.dart';

class UserInterestPlanItemWidget extends StatefulWidget {
  final int index;
  final UserInterestPlanItem item;
  const UserInterestPlanItemWidget(
      {Key? key, required this.index, required this.item})
      : super(key: key);

  @override
  State<UserInterestPlanItemWidget> createState() =>
      _UserInterestPlanItemWidgetState();
}

class _UserInterestPlanItemWidgetState
    extends State<UserInterestPlanItemWidget> {
  late final Future<void> preloadPreviewsFuture;

  Future<void> preloadPreviews() async {
    for (int idx = 0; idx < widget.item.previews.length; idx++) {
      await precacheImage(
          NetworkImage(widget.item.previews[idx].thumbnailUrl), context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    preloadPreviewsFuture = preloadPreviews();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index % 2 == 0 ? Colors.white : AppColors.greyWhite,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(children: [
        Container(
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
                          border:
                              Border.all(color: AppColors.greyWhite, width: 1),
                          borderRadius: BorderRadius.circular(20)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                            imageUrl: widget.item.profileUrl,
                            fit: BoxFit.cover,
                            errorWidget: (context, exception, stackTrace) {
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                        "웨딩플래너",
                        style: TextStyle(
                            fontSize: 12, color: AppColors.veryLightPink),
                      ),
                    ],
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.planProfile);
                },
                child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.only(
                        left: 20, right: 10, top: 10, bottom: 10),
                    child: SvgPicture.asset("assets/home/right_icon.svg")),
              )
            ],
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.2917,
          child: FutureBuilder<void>(
            future: preloadPreviewsFuture,
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const DingmoProgressIndicator(size: 2);
              } else {
                return ScrollConfiguration(
                    behavior: NoGlowBehavior(),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.item.previews.length,
                        itemBuilder: (context, index) => Padding(
                              padding:
                                  EdgeInsets.only(left: index == 0 ? 20 : 0),
                              child: UserInterestPlanPreviewItemWidget(
                                  item: widget.item.previews[index]),
                            )));
              }
            },
          ),
        )
      ]),
    );
  }
}

class UserInterestPlanPreviewItemWidget extends StatelessWidget {
  final UserInterestPlanPreviewItem item;
  const UserInterestPlanPreviewItemWidget({Key? key, required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.type == DingmoContentType.reels) {
          Navigator.pushNamed(context, Routes.reels);
        } else if (item.type == DingmoContentType.feed) {
          Navigator.pushNamed(context, Routes.feeds,
              arguments: FeedsArgs(getFeeds: getFeeds));
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
                            visible: item.type == DingmoContentType.reels,
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
            visible: item.type == DingmoContentType.reels,
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

  Future<List<FeedItem>> getFeeds(int startIdx, int itemCount) {
    return Future.delayed(const Duration(seconds: 1), () {
      final List<FeedItem> newFeeds = [];

      if (itemCount > 50) {
        return newFeeds;
      }
      return newFeeds;
    });
  }
}
