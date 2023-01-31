import 'package:amplify_core/amplify_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/api/api_profile_comp.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/api/commons/page_request.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/dimens.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_view_photo.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/commons/items/consulting_items.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:dingmo/utils/time/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path/path.dart' as path;

import 'widgets/profile_info.dart';

class CompProfileMoreInfoPage extends StatefulWidget {
  final GetCompProfileResult profileInfo;
  const CompProfileMoreInfoPage({Key? key, required this.profileInfo})
      : super(key: key);

  @override
  State<CompProfileMoreInfoPage> createState() =>
      _CompProfileMoreInfoPageState();
}

class _CompProfileMoreInfoPageState extends State<CompProfileMoreInfoPage> {
  final ScrollController contentGridController = ScrollController();
  bool isAddedScrollListener = false;
  bool isLoadingNewContents = false;
  bool isNoneNewItemAnymore = false;

  final List<GetCompProfilePictosResult> pictos = [];

  late final Future<void> _getPictosFuture;
  final PageRequest _pageReq = PageRequest(page: 0, size: 12);

  @override
  void initState() {
    super.initState();

    _getPictosFuture =
        _getPictos().then(_getPictoWithCheckAnymore).then(pictos.addAll);
  }

  Future<List<GetCompProfilePictosResult>> _getPictoWithCheckAnymore(
      List<GetCompProfilePictosResult>? pictos) async {
    final pictoList = pictos ?? [];

    if (pictoList.isEmpty || pictoList.length < _pageReq.size) {
      isNoneNewItemAnymore = true;
    }

    return pictoList;
  }

  Future<List<GetCompProfilePictosResult>?> _getPictos() async {
    try {
      return (await getIt<ApiProfileComp>().getPictos(
              GetCompProfilePictosRequest(
                  profileId: widget.profileInfo.profileId,
                  page: ++_pageReq.page,
                  size: _pageReq.size)))
          .result;
    } catch (e) {
      safePrint("exception: $e");
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "더보기"),
      body: SafeArea(child: StatefulBuilder(builder: (context, setState) {
        return FutureBuilder(
            future: _getPictosFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: DingmoProgressIndicator(size: 2),
                );
              } else {
                return ScrollConfiguration(
                    behavior: NoGlowBehavior(),
                    child: CustomScrollView(
                      controller:
                          getController(contentGridController, setState),
                      slivers: [
                        SliverToBoxAdapter(
                            child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Dimens.horizontalPadding),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 30),
                                    ProfileInfoWidget(
                                      icon: SvgPicture.asset(
                                        "assets/profile/ring_icon.svg",
                                        color: AppColors.veryLightPink,
                                      ),
                                      name: "소개",
                                      description: widget.profileInfo.intro,
                                    ),
                                    const SizedBox(height: 20),
                                    ProfileInfoWidget(
                                      icon: SvgPicture.asset(
                                        "assets/profile/ring_icon.svg",
                                        color: AppColors.veryLightPink,
                                      ),
                                      name: "주소",
                                      description: widget.profileInfo.addr !=
                                              null
                                          ? "${widget.profileInfo.addr} ${widget.profileInfo.addrDetails}"
                                          : "-",
                                    ),
                                    // const SizedBox(height: 10),
                                    // Container(
                                    //     margin: EdgeInsets.only(
                                    //         left: MediaQuery.of(context)
                                    //                 .size
                                    //                 .width *
                                    //             0.25),
                                    //     child: Buttons.textButton(
                                    //         text: "지도보기",
                                    //         onTap: () {
                                    //           Fluttertoast.showToast(
                                    //               msg: "coming soon!");
                                    //         },
                                    //         fontSize: 13,
                                    //         color: AppColors.mediumPink,
                                    //         width: 50)),
                                    const SizedBox(height: 20),
                                    ProfileInfoWidget(
                                      icon: SvgPicture.asset(
                                        "assets/profile/ring_icon.svg",
                                        color: AppColors.veryLightPink,
                                      ),
                                      name: "영업시간",
                                      description:
                                          widget.profileInfo.workTime ?? "-",
                                    ),
                                    const SizedBox(height: 20),
                                    ProfileInfoWidget(
                                      icon: SvgPicture.asset(
                                        "assets/profile/ring_icon.svg",
                                        color: AppColors.veryLightPink,
                                      ),
                                      name: "상담시간",
                                      description: consultText(),
                                    ),
                                    const SizedBox(height: 25),
                                  ]),
                            )
                          ],
                        )),
                        SliverGrid(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5),
                            delegate: SliverChildBuilderDelegate(
                                childCount: pictos.length,
                                (context, index) => GestureDetector(
                                      onTap: () => Navigator.pushNamed(
                                          context, Routes.viewPhoto,
                                          arguments: ViewPhotoArgs(
                                              imageProviders: [
                                                NetworkImage(path.join(
                                                    Endpoints.imgUrl,
                                                    pictos[index].imgKey))
                                              ])),
                                      child: Container(
                                        color: AppColors.greyWhite,
                                        child: CachedNetworkImage(
                                            imageUrl: path.join(
                                                Endpoints.imgUrl,
                                                pictos[index].thumbKey),
                                            errorWidget: (context, exception,
                                                stackTrace) {
                                              return Container(
                                                color: AppColors.greyWhite,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                alignment: Alignment.center,
                                              );
                                            },
                                            fit: BoxFit.cover),
                                      ),
                                    ))),
                        SliverToBoxAdapter(
                          child: Visibility(
                              visible: !isNoneNewItemAnymore,
                              child: const DingmoProgressIndicator(
                                  size: 40,
                                  margin: EdgeInsets.symmetric(vertical: 20))),
                        ),
                        SliverToBoxAdapter(
                          child: Visibility(
                              visible: isNoneNewItemAnymore,
                              child: const SizedBox(
                                height: 40,
                              )),
                        ),
                      ],
                    ));
              }
            });
      })),
    );
  }

  String consultText() {
    if (widget.profileInfo.consultAllow != true) {
      return "-";
    }

    if (widget.profileInfo.consultOpenTime == null ||
        widget.profileInfo.consultCloseTime == null) {
      return "-";
    }

    if (widget.profileInfo.consultDays.isEmpty) {
      return "-";
    }

    return "${widget.profileInfo.consultDays.map((e) => dayStrToDisplayStr(e)).join(", ")}\n"
        "${TimeUtils.toDisplayTime(widget.profileInfo.consultOpenTime)} ~ ${TimeUtils.toDisplayTime(widget.profileInfo.consultCloseTime)}";
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
        !isNoneNewItemAnymore) {
      isLoadingNewContents = true;
      _getPictos()
          .then(_getPictoWithCheckAnymore)
          .then(pictos.addAll)
          .then((_) => setState(() {
                isLoadingNewContents = false;
              }));
    }
  }

  TimeOfDay? toTimeOfDay(String? timeStr) {
    if (timeStr == null) {
      return null;
    }
    final timeUnits = timeStr.split(":");

    return TimeOfDay(
        hour: int.parse(timeUnits[0]), minute: int.parse(timeUnits[1]));
  }

  String getTime(TimeOfDay? start, TimeOfDay? end) {
    return start == null || end == null
        ? "-"
        : "${TimeUtils.getTime(start)}"
            " ~ ${TimeUtils.getTime(end)}";
  }
}
