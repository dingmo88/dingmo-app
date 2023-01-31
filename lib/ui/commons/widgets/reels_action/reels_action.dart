import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_shorts.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_comp_profile.dart';
import 'package:dingmo/routes/arguments/arg_plan_profile.dart';
import 'package:dingmo/routes/arguments/arg_reels_update.dart';
import 'package:dingmo/routes/arguments/arg_single_reels.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/commons/widgets/reels_action/reels_button_like.dart';
import 'package:dingmo/ui/commons/widgets/reels_comments_draggable.dart';
import 'package:dingmo/ui/widgets/content_manage_sheet.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/ui/upload/reels/items/reels_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../utils/typedef.dart';
import 'reels_button_bookmark.dart';
import 'reels_uploader_info.dart';
import 'reels_report_or_ban_sheet.dart';

class ReelsActionWidget extends StatefulWidget {
  final ReelsItem reelsInfo;
  final VoidFuncFuture onRoutePopped;
  final VoidFuncFuture onRoutePushed;
  final VoidFunc onReelsUpdated;
  final VoidFunc onTabBackground;
  final SetBoolFunc onChangeSoundVolume;
  final bool isInSingle;

  const ReelsActionWidget({
    Key? key,
    required this.reelsInfo,
    required this.onRoutePushed,
    required this.onRoutePopped,
    required this.onReelsUpdated,
    required this.onTabBackground,
    required this.onChangeSoundVolume,
    this.isInSingle = false,
  }) : super(key: key);

  @override
  State<ReelsActionWidget> createState() => _ReelsActionWidgetState();
}

class _ReelsActionWidgetState extends State<ReelsActionWidget> {
  late final ReelsItem info;

  @override
  void initState() {
    super.initState();

    info = widget.reelsInfo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                )),
            Flexible(
                child: GestureDetector(
              onTap: widget.onTabBackground,
              child: Container(color: Colors.transparent),
            )),
            Container(
                height: 140,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                    ],
                    stops: const [0.0, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                )),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ReelsUploaderInfoWidget(
                  reelsInfo: info, onPressedUploader: onPressedUploader),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ReelsCameraButton(),
                  const Spacer(),
                  Column(
                    children: [
                      iconButton(
                          info.soundOn
                              ? "assets/home/sound_on_icon.svg"
                              : "assets/home/sound_off_icon.svg", () {
                        setState(() {
                          widget.onChangeSoundVolume(!info.soundOn);
                          info.soundOn = !info.soundOn;
                        });
                      }),
                      const SizedBox(height: 15),
                      ReelsLikeButton(
                          data: info.data,
                          onLoginSuggestStarted: widget.onRoutePushed,
                          onLoginSuggestEnded: widget.onRoutePopped),
                      const SizedBox(height: 25),
                      iconButton(
                          "assets/home/message_icon.svg", onShowCommentList),
                      const SizedBox(height: 5),
                      Texts.defaultText(
                          text: info.data.commentCnt.toString(),
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      const SizedBox(height: 25),
                      ReelsButtonBookmark(
                          data: info.data,
                          onLoginSuggestStarted: widget.onRoutePushed,
                          onLoginSuggestEnded: widget.onRoutePopped),
                      const SizedBox(height: 25),
                      iconButton("assets/home/share_icon.svg", () {
                        Fluttertoast.showToast(msg: "coming soon!");
                      }),
                      const SizedBox(height: 5),
                      Texts.defaultText(
                          text: "${info.data.shareCnt}",
                          fontSize: 13,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                      const SizedBox(height: 25),
                      iconButton("assets/home/dots_icon.svg", onPressLearnMore),
                      const SizedBox(height: 30),
                    ],
                  )
                ],
              ),
            ],
          ),
        )
      ]),
    );
  }

  void onShowCommentList() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => ReelsCommentsDraggableSheet(
              contentId: widget.reelsInfo.data.contentId,
              onLoginSuggestStarted: widget.onRoutePushed,
              onLoginSuggestEnded: widget.onRoutePopped,
            ));
  }

  Widget iconButton(String assetDir, VoidFunc onTap, {Color? color}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 50.0,
                  spreadRadius: 20.0,
                )
              ],
            ),
            child: SvgPicture.asset(
              assetDir,
            )));
  }

  Widget iconButton2(IconData iconData, VoidFunc onTap) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 50.0,
                  spreadRadius: 20.0,
                )
              ],
            ),
            child: Icon(
              iconData,
              color: Colors.white,
            )));
  }

  void onPressLearnMore() {
    // info.data.isMine ? showManageReelsSheet() : showReportOrBanSheet();
    info.data.isMine
        ? showManageReelsSheet()
        : Fluttertoast.showToast(msg: "coming soon!");
  }

  void showReportOrBanSheet() {
    showModalBottomSheet<void>(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) => const ReportOrBanSheet(),
    );
  }

  void showManageReelsSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) => widget.isInSingle
          ? ContentManageSheet(
              contentId: widget.reelsInfo.data.contentId,
              onEdit: () {
                widget.onRoutePushed();
                Navigator.pushNamed(context, Routes.reelsUpdate,
                        arguments: ReelsUpdateArgs(
                            contentId: widget.reelsInfo.data.contentId))
                    .then((isOk) {
                  widget.onRoutePopped();
                  if (isOk == true) {
                    widget.onReelsUpdated();
                  }
                });
              },
              onDelete: _deleteReels,
              onAfterDelete: () {
                widget.onReelsUpdated();
                if (widget.isInSingle) {
                  Navigator.pop(context);
                }
              })
          : SizedBox(
              height: 100,
              child: Container(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
                child: Stack(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            widget.onRoutePushed();
                            Navigator.pop(context);
                            Navigator.pushNamed(context, Routes.singleReels,
                                    arguments: SingleReelsArgs(
                                        contentId:
                                            widget.reelsInfo.data.contentId))
                                .then((isEdited) {
                              widget.onRoutePopped();
                              if (isEdited == true) {
                                widget.onReelsUpdated();
                              }
                            });
                          },
                          child: Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Texts.defaultText(
                              text: "게시물 관리",
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          )),
                    ],
                  ),
                ]),
              ),
            ),
    );
  }

  Future<bool> _deleteReels() async {
    try {
      await getIt<ApiShorts>().delete(
          DeleteShortsRequest(contentId: widget.reelsInfo.data.contentId));
      return true;
    } catch (e) {
      safePrint("exception: $e");
    }
    return false;
  }

  Future<void> onPressedUploader() {
    return widget.onRoutePushed().then((_) {
      final memberType = valueToMemberType(widget.reelsInfo.data.profileType);

      if (memberType == MemberType.comp) {
        Navigator.pushNamed(context, Routes.compProfile,
                arguments:
                    CompProfileArgs(profileId: widget.reelsInfo.data.profileId))
            .then((_) => widget.onRoutePopped());
      } else if (memberType == MemberType.plan) {
        Navigator.pushNamed(context, Routes.planProfile,
                arguments:
                    PlanProfileArgs(profileId: widget.reelsInfo.data.profileId))
            .then((_) => widget.onRoutePopped());
      } else if (memberType == MemberType.user) {
        Navigator.pushNamed(context, Routes.userProfile)
            .then((_) => widget.onRoutePopped());
      }
    });
  }
}
