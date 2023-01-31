import 'package:amplify_core/amplify_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/api/api_comment.dart';
import 'package:dingmo/api/api_like.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_comp_profile.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/widgets/buttons.dart';
import 'package:dingmo/ui/widgets/delete_confirm_dialog.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/utils/time/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

import '../../../constants/colors.dart';
import '../../routes/arguments/arg_plan_profile.dart';
import 'reply_item.dart';

class CommentItemWidget extends StatefulWidget {
  final bool inReply;
  final CommentItem commentItem;
  final void Function()? onShowReplies;
  final void Function()? onDelete;
  const CommentItemWidget({
    Key? key,
    this.inReply = false,
    this.onShowReplies,
    this.onDelete,
    required this.commentItem,
  }) : super(key: key);

  @override
  State<CommentItemWidget> createState() => _CommentItemWidgetState();
}

class _CommentItemWidgetState extends State<CommentItemWidget>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.inReply ? AppColors.greyWhite : Colors.transparent,
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
                      onTap: goProfilePage,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            color: AppColors.greyWhite,
                            borderRadius: BorderRadius.circular(10)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: widget.commentItem.profileUrl != null
                              ? CachedNetworkImage(
                                  imageUrl: widget.commentItem.profileUrl!,
                                  fit: BoxFit.cover,
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Image.asset("assets/dingmo.png"),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Texts.defaultText(
                        text: widget.commentItem.nickname,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ]),
                  likeButton(),
                ],
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: !widget.inReply
                    ? () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        onShowReplies();
                      }
                    : null,
                child: Container(
                  color: Colors.transparent,
                  margin: const EdgeInsets.only(left: 35, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Texts.defaultText(
                          text: widget.commentItem.content ?? "비밀 댓글입니다",
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          height: 1.5),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Texts.defaultText(
                              text: widget.commentItem.dateCrated,
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
                                onShowReplies();
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
                              visible:
                                  widget.commentItem.isMine && !widget.inReply,
                              child: Buttons.textButton(
                                  text: "삭제",
                                  onTap: showDeleteCommentAlertDialog,
                                  fontSize: 12,
                                  color: AppColors.purpleGrey,
                                  fontWeight: FontWeight.normal)),
                          const SizedBox(width: 15),
                        ],
                      ),
                      Visibility(
                          visible: !widget.inReply &&
                              widget.commentItem.isExistReplies(),
                          child: GestureDetector(
                            onTap: () {
                              safePrint("답글보기");
                              onShowReplies();
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              padding: const EdgeInsets.all(5),
                              width: double.infinity,
                              color: Colors.transparent,
                              child: Row(children: [
                                Container(
                                    width: 25,
                                    height: 1,
                                    color: AppColors.veryLightPink),
                                const SizedBox(width: 10),
                                Texts.defaultText(
                                    text:
                                        "답글 ${widget.commentItem.getReplyCount()}개 보기",
                                    fontSize: 12,
                                    color: AppColors.purpleGrey)
                              ]),
                            ),
                          )),
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

  void goProfilePage() {
    switch (widget.commentItem.memberType) {
      case MemberType.comp:
        Navigator.pushNamed(context, Routes.compProfile,
            arguments:
                CompProfileArgs(profileId: widget.commentItem.profileId));
        break;
      case MemberType.plan:
        Navigator.pushNamed(context, Routes.planProfile,
            arguments:
                PlanProfileArgs(profileId: widget.commentItem.profileId));
        break;
      case MemberType.user:
        Navigator.pushNamed(context, Routes.userProfile);
        break;
    }
  }

  Future<bool> _deleteComment() async {
    try {
      await getIt<ApiComment>()
          .delete(DeleteCommentRequest(commentId: widget.commentItem.cmtId));

      return true;
    } catch (e) {
      safePrint("exception: $e");
    }

    return false;
  }

  void showDeleteCommentAlertDialog() {
    FocusScope.of(context).unfocus();
    showDialog(
        context: context,
        builder: (BuildContext context2) {
          return DeleteConfirmDialog(onYes: () async {
            if (await _deleteComment()) {
              if (widget.onDelete != null) {
                widget.onDelete!();
              }
            } else {
              Fluttertoast.showToast(msg: "삭제 실패");
            }
          });
        });
  }

  void showReportOrBanSheet() {
    Fluttertoast.showToast(msg: "coming soon!");
    // showModalBottomSheet<void>(
    //   backgroundColor: Colors.white,
    //   context: context,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(
    //       top: Radius.circular(10),
    //     ),
    //   ),
    //   builder: (BuildContext context) => const ReportOrBanSheet(),
    // );
  }

  void onShowReplies() {
    if (widget.onShowReplies != null) {
      widget.onShowReplies!();
    }
  }

  void switchLike() {
    setState(() {
      widget.commentItem.isLiked = !widget.commentItem.isLiked;
      widget.commentItem.likeCount += widget.commentItem.isLiked ? 1 : -1;
    });
  }

  Future<bool> like() async {
    try {
      await getIt<ApiLike>().submit(PostLikeRequest(
          likeType: likeTypeToValue(LikeType.comment),
          atId: widget.commentItem.cmtId,
          isLike: widget.commentItem.isLiked));

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
          padding: const EdgeInsets.only(left: 10),
          color: Colors.transparent,
          child: Row(
            children: [
              widget.commentItem.isLiked
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
        text: widget.commentItem.likeCount.toString(),
        fontSize: 12,
        color: widget.commentItem.isLiked
            ? AppColors.mediumPink
            : AppColors.veryLightPink);
  }
}

class CommentItem {
  GlobalKey key;
  int cmtId;
  int profileId;
  String? profileUrl;
  MemberType memberType;
  String nickname;
  String? content;
  String dateCrated;
  int likeCount;
  int replyCount;
  bool isLiked;
  bool isMine;
  bool isSecret;
  List<CommentReplyItem> loadedReplies = [];

  CommentItem({
    this.cmtId = 0,
    required this.key,
    required this.profileId,
    required this.profileUrl,
    required this.memberType,
    required this.nickname,
    required this.content,
    required this.dateCrated,
    required this.likeCount,
    required this.replyCount,
    required this.isLiked,
    required this.isMine,
    required this.isSecret,
  });

  factory CommentItem.fromGet(GetCommentResult result) {
    return CommentItem(
        key: GlobalKey(),
        cmtId: result.cmtId,
        profileId: result.profileId,
        profileUrl: result.profileImgKey == null
            ? null
            : path.join(Endpoints.imgUrl, result.profileImgKey),
        memberType: valueToMemberType(result.profileType)!,
        nickname: result.nickname,
        content: result.content,
        dateCrated: TimeUtils.dtToDisplayStr(result.createdDt),
        likeCount: result.likeCnt,
        replyCount: result.replyCnt,
        isLiked: result.isLike,
        isMine: result.isMine,
        isSecret: result.isSecret);
  }

  factory CommentItem.fromPost(PostCommentResult result) {
    return CommentItem(
        key: GlobalKey(),
        cmtId: result.cmtId,
        profileId: result.profileId,
        profileUrl: result.profileImgKey == null
            ? null
            : path.join(Endpoints.imgUrl, result.profileImgKey),
        memberType: valueToMemberType(result.profileType)!,
        nickname: result.nickname,
        content: result.content,
        dateCrated: TimeUtils.dtToDisplayStr(result.createdDt),
        likeCount: result.likeCnt,
        replyCount: result.replyCnt,
        isLiked: result.isLike,
        isMine: true,
        isSecret: result.isSecret);
  }

  bool isExistReplies() {
    return replyCount > 0;
  }

  bool isLoadedReplies() {
    return loadedReplies.isNotEmpty;
  }

  bool isAllLoadedReplies() {
    return getLoadedReplyCount() >= getReplyCount();
  }

  int getReplyCount() {
    return replyCount;
  }

  int getLoadedReplyCount() {
    return loadedReplies.length;
  }

  int getRemainedReplyCount() {
    return replyCount - getLoadedReplyCount();
  }

  @override
  String toString() {
    return "profileUrl: $profileUrl, nickname: $nickname, content: $content, "
        "dateWritten: $dateCrated, likeCount: $likeCount, isLiked: $isLiked, "
        "replyCount: $replyCount, replies.length: ${loadedReplies.length}";
  }
}
