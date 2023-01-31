import 'package:amplify_core/amplify_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/api/api_like.dart';
import 'package:dingmo/api/api_reply.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_comp_profile.dart';
import 'package:dingmo/routes/arguments/arg_plan_profile.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/commons/widgets/reels_action/reels_report_or_ban_sheet.dart';
import 'package:dingmo/utils/time/time_utils.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

import '../../constants/colors.dart';
import 'buttons.dart';
import 'comment_item.dart';
import 'delete_confirm_dialog.dart';
import 'texts.dart';

class CommentReplyItemWidget extends StatefulWidget {
  final CommentReplyItem replyItem;
  final void Function(CommentReplyItem replyItem) onTap;
  final void Function() onDelete;

  const CommentReplyItemWidget(
      {Key? key,
      required this.replyItem,
      required this.onTap,
      required this.onDelete})
      : super(key: key);

  @override
  State<CommentReplyItemWidget> createState() => _CommentReplyItemWidgetState();
}

class _CommentReplyItemWidgetState extends State<CommentReplyItemWidget> {
  final ExpandableController expandableController = ExpandableController();
  final replyTextStyle =
      TextStyle(fontSize: 13, color: AppColors.greyishBrown, height: 1.5);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    GestureDetector(
                      onTap: () => goProfilePage(widget.replyItem.profileId,
                          widget.replyItem.memberType),
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            color: AppColors.greyWhite,
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: widget.replyItem.profileUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: widget.replyItem.profileUrl!,
                                  fit: BoxFit.cover)
                              : Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Image.asset("assets/dingmo.png"),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Texts.defaultText(
                        text: widget.replyItem.nickname,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ]),
                  likeButton(),
                ],
              ),
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  widget.onTap(widget.replyItem);
                },
                child: Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(left: 35, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(children: [
                          widget.replyItem.mention != null
                              ? TextSpan(
                                  text:
                                      "@${widget.replyItem.mention!.atNickname}  ",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => goProfilePage(
                                        widget.replyItem.mention!.atProfileId,
                                        valueToMemberType(widget.replyItem
                                            .mention!.atProfileType)!),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.mediumPink,
                                      fontWeight: FontWeight.bold,
                                      height: 1.5),
                                )
                              : const TextSpan(),
                          TextSpan(
                            text: widget.replyItem.content,
                            style: replyTextStyle,
                          ),
                        ]),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Texts.defaultText(
                              text: widget.replyItem.dateCreated,
                              fontSize: 12,
                              color: AppColors.purpleGrey,
                              fontWeight: FontWeight.normal),
                          const SizedBox(width: 10),
                          Buttons.textButton(
                              text: "답글달기",
                              width: 50,
                              onTap: () {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                widget.onTap(widget.replyItem);
                              },
                              fontSize: 12,
                              color: AppColors.purpleGrey,
                              fontWeight: FontWeight.normal),
                          Visibility(
                              maintainState: true,
                              visible: getIt<MemberInfo>().memberType ==
                                  MemberType.user,
                              child: Buttons.textButton(
                                  text: "신고",
                                  onTap: showReportOrBanSheet,
                                  fontSize: 12,
                                  color: AppColors.purpleGrey,
                                  fontWeight: FontWeight.normal)),
                          Visibility(
                              maintainState: true,
                              visible: widget.replyItem.isMine,
                              child: Buttons.textButton(
                                  text: "삭제",
                                  onTap: showDeleteReplyAlertDialog,
                                  fontSize: 12,
                                  color: AppColors.purpleGrey,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(width: 15),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void goProfilePage(int profileId, MemberType memberType) {
    switch (memberType) {
      case MemberType.comp:
        Navigator.pushNamed(context, Routes.compProfile,
            arguments: CompProfileArgs(profileId: profileId));
        break;
      case MemberType.plan:
        Navigator.pushNamed(context, Routes.planProfile,
            arguments: PlanProfileArgs(profileId: profileId));
        break;
      case MemberType.user:
        Navigator.pushNamed(context, Routes.userProfile);
        break;
    }
  }

  Future<bool> _deleteComment() async {
    try {
      await getIt<ApiReply>()
          .delete(DeleteReplyRequest(replyId: widget.replyItem.replyId));

      return true;
    } catch (e) {
      safePrint("exception: $e");
    }

    return false;
  }

  void showDeleteReplyAlertDialog() {
    FocusScope.of(context).unfocus();
    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return DeleteConfirmDialog(onYes: () async {
            if (await _deleteComment()) {
              widget.onDelete();
            } else {
              Fluttertoast.showToast(msg: "삭제 실패");
            }
          });
        });
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

  void switchLike() {
    setState(() {
      widget.replyItem.isLiked = !widget.replyItem.isLiked;
      widget.replyItem.likeCount += widget.replyItem.isLiked ? 1 : -1;
    });
  }

  Future<bool> like() async {
    try {
      await getIt<ApiLike>().submit(PostLikeRequest(
          likeType: likeTypeToValue(LikeType.comment),
          atId: widget.replyItem.replyId,
          isLike: widget.replyItem.isLiked));

      return true;
    } catch (e) {
      safePrint("exception: $e");
    }

    return false;
  }

  Widget likeButton() {
    return GestureDetector(
        onTap: () async {
          switchLike();
          if (!await like()) {
            switchLike();
            Fluttertoast.showToast(msg: "문제가 발생하였습니다");
          }
        },
        child: Container(
          padding: const EdgeInsets.only(top: 5),
          color: Colors.transparent,
          child: Row(
            children: [
              widget.replyItem.isLiked
                  ? SvgPicture.asset("assets/home/like_on_comment_icon.svg")
                  : SvgPicture.asset("assets/home/like_off_comment_icon.svg"),
              const SizedBox(width: 5),
              likeCountText(),
            ],
          ),
        ));
  }

  Widget likeCountText() {
    return Texts.defaultText(
        text: widget.replyItem.likeCount.toString(),
        fontSize: 12,
        color: widget.replyItem.isLiked
            ? AppColors.mediumPink
            : AppColors.veryLightPink);
  }

  bool hasTextOverflow(String text, TextStyle style,
      {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 2}) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: minWidth, maxWidth: maxWidth);
    return textPainter.didExceedMaxLines;
  }
}

class CommentItemList {
  final List<CommentItem> items;
  final int commentCount;

  CommentItemList({required this.items, required this.commentCount});

  int getRemainedComments() {
    return commentCount - items.length;
  }
}

class CommentReplyItem {
  GlobalKey key;
  int replyId;
  int profileId;
  MemberType memberType;
  String? profileUrl;
  ReplyMention? mention;
  String nickname;
  String content;
  String dateCreated;
  int likeCount;
  bool isLiked;
  bool isMine;

  CommentReplyItem({
    required this.key,
    required this.replyId,
    required this.profileId,
    required this.memberType,
    required this.profileUrl,
    required this.mention,
    required this.nickname,
    required this.content,
    required this.dateCreated,
    required this.likeCount,
    required this.isLiked,
    required this.isMine,
  });

  factory CommentReplyItem.fromGet(GetReplyResult result) {
    return CommentReplyItem(
      key: GlobalKey(),
      replyId: result.replyId,
      profileId: result.profileId,
      memberType: valueToMemberType(result.profileType)!,
      profileUrl: result.profileImgKey != null
          ? path.join(Endpoints.imgUrl, result.profileImgKey)
          : null,
      mention: result.mention,
      nickname: result.nickname,
      content: result.content,
      dateCreated: TimeUtils.dtToDisplayStr(result.createdDt),
      likeCount: result.likeCnt,
      isLiked: result.isLike,
      isMine: result.isMine,
    );
  }

  factory CommentReplyItem.fromPost(PostReplyResult result) {
    return CommentReplyItem(
      key: GlobalKey(),
      replyId: result.replyId,
      profileId: result.profileId,
      memberType: valueToMemberType(result.profileType)!,
      profileUrl: result.profileImgKey != null
          ? path.join(Endpoints.imgUrl, result.profileImgKey)
          : null,
      mention: result.mention,
      nickname: result.nickname,
      content: result.content,
      dateCreated: TimeUtils.dtToDisplayStr(result.createdDt),
      likeCount: result.likeCnt,
      isLiked: result.isLike,
      isMine: true,
    );
  }

  @override
  String toString() {
    return "profileUrl: $profileUrl, refNickname: $mention, "
        "nickname: $nickname, content: $content, "
        "dateWritten: $dateCreated, likeCount: $likeCount, isLiked: $isLiked";
  }
}
