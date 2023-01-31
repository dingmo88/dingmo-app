import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_content.dart';
import 'package:dingmo/api/api_profile_plan.dart';
import 'package:dingmo/api/commons/page_request.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_feeds.dart';
import 'package:dingmo/routes/arguments/arg_single_reels.dart';
import 'package:dingmo/routes/arguments/arg_view_feed_item.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/commons/items/consulting_items.dart';
import 'package:dingmo/ui/commons/items/feed_item.dart';
import 'package:dingmo/ui/widgets/consulting_button.dart';
import 'package:dingmo/ui/widgets/follow_button.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/light_status_bar.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/utils/time/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/profile_image.dart';
import 'widgets/profile_info.dart';
import 'widgets/profile_tab_contents.dart';
import 'widgets/profile_tab_reviews.dart';

class PlanProfilePage extends StatefulWidget {
  final int profileId;
  const PlanProfilePage({Key? key, required this.profileId}) : super(key: key);

  @override
  State<PlanProfilePage> createState() => _PlanProfilePageState();
}

class _PlanProfilePageState extends State<PlanProfilePage>
    with TickerProviderStateMixin {
  bool isNoneNewItemAnymore = false;
  bool isLastReviewsLoaded = false;

  late final Future<void> loadPlanProfileFuture;
  GetPlanProfileResult? planProfileResult;

  late final TabController tabController;
  final ScrollController scrollController = ScrollController();

  final PageRequest _pageReq = PageRequest(size: 15);

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    loadPlanProfileFuture = loadPlanProfile();
    loadPlanProfileFuture.then((_) {
      if (planProfileResult == null) {
        Fluttertoast.showToast(msg: "잘못된 접근입니다");
        Navigator.pop(context);
      }
    });

    scrollController.addListener(handleScrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return LightStatusBarWidget(
        child: Scaffold(
            appBar: AppBars.lightDefaultAppBar(context,
                action: Row(
                  children: [
                    FutureBuilder(
                        future: loadPlanProfileFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return Container();
                          } else {
                            return Visibility(
                                visible: planProfileResult?.isMine == true,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Routes.planEditProfile);
                                    },
                                    child: Text(
                                      "프로필 설정",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.mediumPink),
                                    )));
                          }
                        }),
                    Visibility(
                        maintainState: true,
                        visible:
                            getIt<MemberInfo>().memberType == MemberType.user &&
                                planProfileResult?.isMine == false,
                        child: FollowButton(
                            profileId: widget.profileId, initIsFollow: false)),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Fluttertoast.showToast(msg: "coming soon!");
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 20),
                        child: GestureDetector(
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                color: Colors.transparent,
                                child: SvgPicture.asset(
                                  "assets/home/share_icon.svg",
                                  color: AppColors.purpleGrey,
                                  width: 16,
                                ))),
                      ),
                    )
                  ],
                )),
            body: FutureBuilder(
                future: loadPlanProfileFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const SizedBox(
                      width: double.infinity,
                      height: 400,
                      child: DingmoProgressIndicator(size: 2),
                    );
                  } else {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Column(children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: Dimens.verticalPadding,
                              left: Dimens.horizontalPadding,
                              right: Dimens.horizontalPadding),
                          child: Column(children: [
                            profileWidget(planProfileResult?.profileImgKey),
                            const SizedBox(height: 15),
                            Texts.defaultText(
                                text: planProfileResult?.nickname ?? "",
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                            const SizedBox(height: 5),
                            Texts.defaultText(
                                text: "웨딩플래너",
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                            const SizedBox(height: 20),
                            planProfileResult?.consultAllow == true
                                ? const ConsultingButton()
                                : Container(),
                            const SizedBox(height: 10),
                          ]),
                        ),
                        Container(
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.greyWhite, width: 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                ProfileInfoWidget(
                                  icon: SvgPicture.asset(
                                    "assets/profile/ring_icon.svg",
                                    color: AppColors.veryLightPink,
                                  ),
                                  name: "소개",
                                  description: planProfileResult?.intro,
                                  expandable: true,
                                ),
                                const SizedBox(height: 20),
                                ProfileInfoWidget(
                                  icon: SvgPicture.asset(
                                    "assets/profile/place_icon.svg",
                                    color: AppColors.veryLightPink,
                                  ),
                                  name: "활동지역",
                                  description: "서울 강남구",
                                ),
                                const SizedBox(height: 20),
                                ProfileInfoWidget(
                                  icon: SvgPicture.asset(
                                    "assets/profile/alarm_icon.svg",
                                    color: AppColors.veryLightPink,
                                  ),
                                  name: "상담시간",
                                  description: consultText(),
                                ),
                                const SizedBox(height: 25),
                              ],
                            )),
                        TabBar(
                            controller: tabController,
                            labelColor: AppColors.greyishBrown,
                            unselectedLabelColor:
                                AppColors.greyishBrown.withOpacity(0.6),
                            indicatorColor: AppColors.greyishBrown,
                            tabs: const [
                              Tab(text: "게시물", height: 45),
                              Tab(text: "후기(0)", height: 45),
                            ],
                            onTap: (index) {
                              setState(() {});
                            }),
                        [
                          ProfileTabContents(
                            items: planProfileResult?.thumbnails
                                    .map((thumb) => ProfileTabContentItem(
                                        thumbImgKey: thumb.thumbKey,
                                        contentId: thumb.contentId,
                                        contentType: thumb.contentType,
                                        viewCnt: thumb.viewCnt,
                                        onTap: () {
                                          if (valueToCtType(
                                                  thumb.contentType) ==
                                              DingmoContentType.reels) {
                                            Navigator.pushNamed(
                                                context, Routes.singleReels,
                                                arguments: SingleReelsArgs(
                                                    contentId:
                                                        thumb.contentId));
                                          } else if (valueToCtType(
                                                  thumb.contentType) ==
                                              DingmoContentType.feed) {
                                            Navigator.pushNamed(
                                                context, Routes.viewFeedItem,
                                                arguments: ViewFeedItemArgs(
                                                    contentId:
                                                        thumb.contentId));
                                            // Navigator.pushNamed(
                                            //     context, Routes.feeds,
                                            //     arguments: FeedsArgs(getFeeds:
                                            //         (int itemCount,
                                            //             int startIdx) async {
                                            //   final List<FeedItem> items = [];

                                            //   for (var idx = 0;
                                            //       idx < 10;
                                            //       idx++) {
                                            //     items.add(FeedItem(
                                            //         contentId: 0,
                                            //         profileUrl: null,
                                            //         nickname: "hello $idx",
                                            //         description: "descr $idx",
                                            //         dateCreated: DateTime.now()
                                            //             .toIso8601String(),
                                            //         images: [],
                                            //         mentions: [],
                                            //         tags: [],
                                            //         likeCount: idx,
                                            //         commentCount: idx,
                                            //         bmkId: null,
                                            //         isLiked: idx % 2 == 0,
                                            //         isMine: false));
                                            //   }
                                            //   return items;
                                            // }));
                                          }
                                        }))
                                    .toList() ??
                                [],
                            isLastContentsLoaded:
                                (planProfileResult?.thumbnails.length ?? 0) <
                                        _pageReq.size ||
                                    isNoneNewItemAnymore,
                          ),
                          ProfileTabReviews(
                            reviews: const [],
                            isLastReviewsLoaded: isLastReviewsLoaded,
                          )
                        ][tabController.index]
                      ]),
                    );
                  }
                })));
  }

  String consultText() {
    if (planProfileResult?.consultAllow != true) {
      return "-";
    }

    if (planProfileResult!.consultOpenTime == null ||
        planProfileResult!.consultCloseTime == null) {
      return "-";
    }

    if (planProfileResult!.consultDays.isEmpty) {
      return "-";
    }

    return "${planProfileResult!.consultDays.map((e) => dayStrToDisplayStr(e)).join(", ")}\n"
        "${TimeUtils.toDisplayTime(planProfileResult?.consultOpenTime)} ~ ${TimeUtils.toDisplayTime(planProfileResult?.consultCloseTime)}";
  }

  Widget profileWidget(String? profileUrl) {
    return profileUrl != null
        ? ProfileImageWidget(profileImgKey: profileUrl)
        : const DefaultProfileWidget();
  }

  void handleScrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent) {
      if (tabController.index == 0 && !isNoneNewItemAnymore) {
        loadNewContentThumbs().then((_) => setState(() {}));
      } else if (tabController.index == 1 && !isLastReviewsLoaded) {
        // getNewReviews().then((_) => setState(() {}));
      }
    }
  }

  Future<void> loadNewContentThumbs() async {
    if (isNoneNewItemAnymore) {
      return;
    }

    final List<PlanProfileContentThumbnail> newItems =
        await getNewContentThumbsData();

    planProfileResult?.thumbnails.addAll(newItems);
    isNoneNewItemAnymore = newItems.length < _pageReq.size;
  }

  Future<List<PlanProfileContentThumbnail>> getNewContentThumbsData() async {
    _pageReq.page += 1;

    try {
      final response = await getIt<ApiContent>().getThumbnails(
          GetContentThumbRequest(
              profileId: planProfileResult?.profileId ?? 0,
              page: _pageReq.page,
              size: _pageReq.size));
      return response.result
          .map((thumb) => PlanProfileContentThumbnail(
              contentId: thumb.contentId,
              contentType: thumb.contentType,
              thumbKey: thumb.thumbKey,
              viewCnt: thumb.viewCnt))
          .toList();
    } catch (e) {
      Fluttertoast.showToast(msg: "문제가 발생하였습니다");
      safePrint("exception: $e");
    }

    return [];
  }

  Future<void> loadPlanProfile() async {
    try {
      final response = getIt<MemberInfo>().isGuest()
          ? await getIt<ApiProfilePlan>()
              .getGuest(GetPlanProfileRequest(profileId: widget.profileId))
          : await getIt<ApiProfilePlan>()
              .get(GetPlanProfileRequest(profileId: widget.profileId));

      planProfileResult = response.result;
    } catch (e) {
      safePrint("exception: $e");
    }
  }
}
