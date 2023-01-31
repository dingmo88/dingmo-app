import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_content.dart';
import 'package:dingmo/api/api_profile_comp.dart';
import 'package:dingmo/api/commons/page_request.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_comp_profile.dart';
import 'package:dingmo/routes/arguments/arg_single_reels.dart';
import 'package:dingmo/routes/arguments/arg_view_feed_item.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/consulting_button.dart';
import 'package:dingmo/ui/widgets/light_status_bar.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/comp_profile_content_image.dart';
import 'widgets/profile_tab_contents.dart';
import 'widgets/profile_tab_reviews.dart';
import '../../widgets/follow_button.dart';
import '../widgets/profile_image.dart';

class CompProfilePage extends StatefulWidget {
  final int profileId;
  const CompProfilePage({Key? key, required this.profileId}) : super(key: key);

  @override
  State<CompProfilePage> createState() => _CompProfilePagePageState();
}

class _CompProfilePagePageState extends State<CompProfilePage>
    with TickerProviderStateMixin {
  int maxContentLoad = 5;

  int currentContentLoad = 1;
  int currentReviewsLoad = 1;

  bool isNoneNewItemAnymore = false;
  bool isLastReviewsLoaded = false;

  late final Future<void> loadCompProfileFuture;
  GetCompProfileResult? compProfileResult;

  late final TabController tabController;
  final ScrollController scrollController = ScrollController();

  final PageRequest _pageReq = PageRequest(size: 15);

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    loadCompProfileFuture = _loadCompProfile();
    loadCompProfileFuture.then((_) {
      if (compProfileResult == null) {
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
      appBar: AppBars.defaultAppBar(context,
          action: Row(
            children: [
              FutureBuilder(
                  future: loadCompProfileFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Container();
                    } else {
                      return Visibility(
                          visible: compProfileResult?.isMine == true,
                          child: TextButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                        context, Routes.compEditProfile)
                                    .then((isOk) {
                                  if (isOk == true) {
                                    Fluttertoast.showToast(msg: "수정 완료");
                                    Navigator.pushReplacementNamed(
                                        context, Routes.compProfile,
                                        arguments: CompProfileArgs(
                                            profileId: widget.profileId));
                                  }
                                });
                              },
                              child: Text(
                                "프로필 설정",
                                style: TextStyle(
                                    fontSize: 13, color: AppColors.mediumPink),
                              )));
                    }
                  }),
              Visibility(
                  visible: getIt<MemberInfo>().memberType == MemberType.user &&
                      compProfileResult?.isMine == false,
                  child: compProfileResult != null
                      ? FollowButton(
                          initIsFollow: compProfileResult!.isFollow,
                          profileId: compProfileResult!.profileId)
                      : Container()),
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
                    ),
                  )),
                ),
              )
            ],
          )),
      body: FutureBuilder(
          future: loadCompProfileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const SizedBox(
                width: double.infinity,
                height: 100,
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
                      Row(
                        children: [
                          CompProfileContentImageMain(
                              imgKey: compProfileResult
                                          ?.mainPictoImgKeys.isNotEmpty ==
                                      true
                                  ? compProfileResult
                                      ?.mainPictoImgKeys[0].imgKey
                                  : null),
                          const SizedBox(width: 6),
                          Column(children: [
                            CompProfileContentImageSub(
                                imgKey: (compProfileResult
                                                ?.mainPictoImgKeys.length ??
                                            0) >
                                        1
                                    ? compProfileResult
                                        ?.mainPictoImgKeys[1].imgKey
                                    : null),
                            const SizedBox(height: 5),
                            CompProfileContentImageSub(
                                imgKey: (compProfileResult
                                                ?.mainPictoImgKeys.length ??
                                            0) >
                                        2
                                    ? compProfileResult
                                        ?.mainPictoImgKeys[2].imgKey
                                    : null),
                            const SizedBox(height: 5),
                            Stack(children: [
                              CompProfileContentImageSub(
                                  imgKey: (compProfileResult
                                                  ?.mainPictoImgKeys.length ??
                                              0) >
                                          3
                                      ? compProfileResult
                                          ?.mainPictoImgKeys[3].imgKey
                                      : null),
                              compProfileResult != null
                                  ? CompProfileMoreInfoButton(
                                      profileInfo: compProfileResult!)
                                  : Container()
                            ]),
                          ])
                        ],
                      ),
                      const SizedBox(height: 25),
                      profileWidget(compProfileResult?.profileImgKey),
                      const SizedBox(height: 15),
                      Texts.defaultText(
                          text: compProfileResult?.nickname ?? "",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      const SizedBox(height: 5),
                      Texts.defaultText(
                          text: idxTagToString(
                              valueToIdxTag(compProfileResult?.compType)),
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                      const SizedBox(height: 20),
                      compProfileResult?.consultAllow == true
                          ? const ConsultingButton()
                          : const SizedBox(height: 50),
                      const SizedBox(height: 10),
                    ]),
                  ),
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
                      items: compProfileResult?.thumbnails
                              .map((thumb) => ProfileTabContentItem(
                                  thumbImgKey: thumb.thumbKey,
                                  contentId: thumb.contentId,
                                  contentType: thumb.contentType,
                                  viewCnt: thumb.viewCnt,
                                  onTap: () {
                                    if (valueToCtType(thumb.contentType) ==
                                        DingmoContentType.reels) {
                                      Navigator.pushNamed(
                                          context, Routes.singleReels,
                                          arguments: SingleReelsArgs(
                                              contentId: thumb.contentId));
                                    } else if (valueToCtType(
                                            thumb.contentType) ==
                                        DingmoContentType.feed) {
                                      Navigator.pushNamed(
                                          context, Routes.viewFeedItem,
                                          arguments: ViewFeedItemArgs(
                                              contentId: thumb.contentId));
                                    }
                                  }))
                              .toList() ??
                          [],
                      isLastContentsLoaded:
                          (compProfileResult?.thumbnails.length ?? 0) <
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
          }),
    ));
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

    final List<CompProfileContentThumbnail> newItems =
        await getNewContentThumbsData();

    compProfileResult?.thumbnails.addAll(newItems);
    isNoneNewItemAnymore = newItems.length < _pageReq.size;
  }

  Future<List<CompProfileContentThumbnail>> getNewContentThumbsData() async {
    _pageReq.page += 1;

    try {
      final response = await getIt<ApiContent>().getThumbnails(
          GetContentThumbRequest(
              profileId: compProfileResult?.cprofileId ?? 0,
              page: _pageReq.page,
              size: _pageReq.size));
      return response.result
          .map((thumb) => CompProfileContentThumbnail(
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

  Future<void> _loadCompProfile() async {
    try {
      final response = getIt<MemberInfo>().isGuest()
          ? await getIt<ApiProfileComp>()
              .getGuest(GetCompProfileRequest(profileId: widget.profileId))
          : await getIt<ApiProfileComp>()
              .get(GetCompProfileRequest(profileId: widget.profileId));

      compProfileResult = response.result;
    } catch (e) {
      safePrint("exception: $e");
    }
  }
}
