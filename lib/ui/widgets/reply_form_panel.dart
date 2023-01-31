import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_reply.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/widgets/comment_item.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/colors.dart';
import '../../utils/rich_text_controller.dart';
import 'buttons.dart';
import 'reply_cancel_dialog.dart';
import 'reply_item.dart';
import 'suggest_login_dialog.dart';

class ReplyFormPanel extends StatefulWidget {
  final int contentId;
  final CommentItem commentItem;
  final Widget contentWidget;
  final ReplyFormPanelController controller;
  final void Function(CommentReplyItem newItem) onCompleteWriteReply;
  final VoidFuncFuture? onLoginSuggestStarted;
  final VoidFuncFuture? onLoginSuggestEnded;
  const ReplyFormPanel(
      {Key? key,
      required this.contentId,
      required this.commentItem,
      required this.contentWidget,
      required this.onCompleteWriteReply,
      required this.controller,
      this.onLoginSuggestStarted,
      this.onLoginSuggestEnded})
      : super(key: key);

  @override
  State<ReplyFormPanel> createState() => ReplyFormPanelState();
}

class ReplyFormPanelController {
  ReplyFormPanelState? state;

  void openForm(CommentReplyItem replyItem) {
    state!.openForm(replyItem);
  }
}

class ReplyFormPanelState extends State<ReplyFormPanel> {
  final FocusNode writeReplyFocusNode = FocusNode();
  late final RichTextController writeReplyController;
  bool isSecretReply = false;
  bool isSending = false;

  static String mentionNickname = "";
  static String refNickname = "";

  CommentReplyItem? _replyTargetItem;

  @override
  void initState() {
    super.initState();

    writeReplyController =
        RichTextController(onMatch: (List<String> match) {}, patternMatchMap: {
      RegExp(r'''@[a-zA-Z0-9ㄱ-ㅎㅏ-ㅣ가-힣\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]+'''):
          TextStyle(
              color: AppColors.greyishBrown,
              fontSize: 14,
              fontWeight: FontWeight.bold)
    });

    writeReplyController.addListener(() {
      if (mentionNickname.isNotEmpty) {
        if (writeReplyController.selection.base.offset <= 0) {
          writeReplyController.selection = TextSelection.fromPosition(
              TextPosition(offset: mentionNickname.length));
        }
      }
    });

    widget.controller.state = this;
  }

  void clearMention() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        refNickname = "";
        mentionNickname = "";
        _replyTargetItem = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isSending) {
          return false;
        }
        if (writeReplyController.text.isNotEmpty) {
          showReplyAlertDialog(context, () => setState(onCancelReplyWrite));
          return false;
        }
        return true;
      },
      child: IgnorePointer(
          ignoring: isSending,
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: Stack(
              children: [
                Stack(children: [
                  widget.contentWidget,
                  Visibility(
                      visible: isSending,
                      child: Container(
                        color: Colors.transparent,
                      ))
                ]),
                Column(
                  children: [
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 10,
                          bottom:
                              10 + MediaQuery.of(context).viewInsets.bottom),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  color: AppColors.white, width: 1))),
                      child: Column(children: [
                        Visibility(
                            // visible: writeReplyController.text.isNotEmpty,
                            visible:
                                false, // 비밀댓글이 꼭 필요한가? 다시 논의 필요. 답글에 대한 비밀댓글의 모호함(누구한테 비밀인가? 게시글? 댓글?)
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSecretReply = !isSecretReply;
                                });
                              },
                              child: Container(
                                  padding:
                                      const EdgeInsets.only(bottom: 15, top: 5),
                                  color: Colors.transparent,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      isSecretReply
                                          ? SvgPicture.asset(
                                              "assets/home/lock_comment_icon.svg",
                                              color: AppColors.mediumPink,
                                            )
                                          : SvgPicture.asset(
                                              "assets/home/unlock_comment_icon.svg",
                                              color: AppColors.veryLightPink,
                                            ),
                                      const SizedBox(width: 5),
                                      Text(
                                        "비밀댓글",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: isSecretReply
                                                ? AppColors.mediumPink
                                                : AppColors.veryLightPink),
                                      ),
                                    ],
                                  )),
                            )),
                        TextFormField(
                            focusNode: writeReplyFocusNode,
                            controller: writeReplyController,
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.greyishBrown,
                                height: 1.5),
                            onChanged: (text) {
                              setState(() {
                                if (mentionNickname.isNotEmpty) {
                                  if (text.length < mentionNickname.length) {
                                    writeReplyController.text = mentionNickname;
                                    writeReplyController.selection =
                                        TextSelection.fromPosition(TextPosition(
                                            offset: mentionNickname.length));
                                  }
                                  if (writeReplyController
                                          .selection.base.offset <
                                      mentionNickname.length) {
                                    int idx =
                                        writeReplyController.text.indexOf(" ");
                                    writeReplyController.text =
                                        mentionNickname +
                                            writeReplyController.text
                                                .substring(idx + 1);
                                  }
                                }
                              });
                            },
                            keyboardType: TextInputType.multiline,
                            autofocus: false,
                            minLines: 1,
                            maxLines: 3,
                            decoration: InputDecoration(
                                enabled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.veryLightPink,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                suffixIcon: Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    color: Colors.transparent,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Visibility(
                                            visible: !isSending,
                                            child: Buttons.textButton(
                                                text: "게시",
                                                color: isReplyNotEmpty()
                                                    ? AppColors.mediumPink
                                                    : AppColors.veryLightPink,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 14,
                                                onTap: isReplyNotEmpty()
                                                    ? onSubmitWriteReply
                                                    : null)),
                                        Visibility(
                                            visible: isSending,
                                            child: CircularProgressIndicator(
                                              color: AppColors.mediumPink,
                                              strokeWidth: 2,
                                            ))
                                      ],
                                    )),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.veryLightPink,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: AppColors.mediumPink,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                hintText: "메시지를 입력하세요",
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.veryLightPink)))
                      ]),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }

  bool isReplyNotEmpty() {
    return writeReplyController.text.isNotEmpty &&
        writeReplyController.text.trim().length > mentionNickname.length;
  }

  Future<void> onSubmitWriteReply() async {
    FocusScope.of(context).unfocus();

    if (getIt<MemberInfo>().isGuest()) {
      showSuggestLoginDialog();
      return;
    }

    final text = writeReplyController.text;

    final comment =
        refNickname.isNotEmpty ? text.split(mentionNickname)[1] : text;

    setState(() {
      isSending = true;
    });
    final result = await writeReply(_replyTargetItem, comment);
    setState(() {
      isSending = false;
    });
    if (result == null) {
      Fluttertoast.showToast(msg: "작성에 실패했습니다");
    } else {
      widget.onCompleteWriteReply(CommentReplyItem.fromPost(result));

      clearMention();
      writeReplyController.clear();
    }
  }

  void openForm(CommentReplyItem replyItem) {
    refNickname = replyItem.nickname;
    mentionNickname = "@$refNickname ";
    _replyTargetItem = replyItem;
    writeReplyController.text = mentionNickname;
    writeReplyFocusNode.unfocus(
        disposition: UnfocusDisposition.previouslyFocusedChild);
    Future.delayed(const Duration(microseconds: 10), () {
      writeReplyFocusNode.requestFocus();
    });
  }

  Future<PostReplyResult?> writeReply(
      CommentReplyItem? replyTargetItem, String content) async {
    try {
      final response = await getIt<ApiReply>().create(PostReplyRequest(
          contentId: widget.contentId,
          commentId: widget.commentItem.cmtId,
          content: content,
          isSecret: isSecretReply,
          mention: replyTargetItem != null
              ? ReplyMention(
                  atNickname: replyTargetItem.nickname,
                  atProfileType: memberTypeToValue(replyTargetItem.memberType),
                  atProfileId: replyTargetItem.profileId)
              : null));

      return response.result;
    } catch (e) {
      safePrint("exception: $e");
    }

    return null;
  }

  void onCancelReplyWrite() {
    clearMention();
    writeReplyController.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void showSuggestLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) => SuggestLoginDialog(
              onYes: () async {
                if (widget.onLoginSuggestStarted != null) {
                  await widget.onLoginSuggestStarted!();
                }
              },
              onFinished: () async {
                if (widget.onLoginSuggestEnded != null) {
                  await widget.onLoginSuggestEnded!();
                }
              },
            ));
  }

  void showReplyAlertDialog(BuildContext context, void Function() onCancel) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CheckReplyCancelDialog(onCancel: onCancel);
        });
  }
}
