import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_comment.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/widgets/comment_cancel_dialog.dart';
import 'package:dingmo/ui/widgets/suggest_login_dialog.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants/colors.dart';
import 'buttons.dart';
import 'comment_item.dart';

class CommentFormPanel extends StatefulWidget {
  final int contentId;
  final Widget contentWidget;
  final void Function(CommentItem newItem) onCompleteWriteComment;
  final VoidFuncFuture? onLoginSuggestStarted;
  final VoidFuncFuture? onLoginSuggestEnded;
  const CommentFormPanel(
      {Key? key,
      required this.contentId,
      required this.contentWidget,
      required this.onCompleteWriteComment,
      this.onLoginSuggestStarted,
      this.onLoginSuggestEnded})
      : super(key: key);

  @override
  State<CommentFormPanel> createState() => _CommentFormPanelState();
}

class _CommentFormPanelState extends State<CommentFormPanel> {
  final FocusNode writeCommentFocusNode = FocusNode();
  final TextEditingController writeCommentController = TextEditingController();
  bool isSecretComment = false;
  bool isSending = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isSending) {
          return false;
        }
        if (writeCommentController.text.isNotEmpty) {
          showCommentAlertDialog(context, () => setState(onCancelCommentWrite));
          return false;
        }
        return true;
      },
      child: IgnorePointer(
          ignoring: isSending,
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
                        bottom: 10 + MediaQuery.of(context).viewInsets.bottom),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(color: AppColors.white, width: 1))),
                    child: Column(children: [
                      Visibility(
                          // visible: writeCommentController.text.isNotEmpty,
                          visible:
                              false, // 비밀댓글이 꼭 필요한가? 다시 논의 필요. 답글에 대한 비밀 댓글의 모호함(누구한테 비밀인가? 게시글? 댓글?)
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSecretComment = !isSecretComment;
                              });
                            },
                            child: Container(
                                padding:
                                    const EdgeInsets.only(bottom: 15, top: 5),
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    isSecretComment
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
                                          color: isSecretComment
                                              ? AppColors.mediumPink
                                              : AppColors.veryLightPink),
                                    ),
                                  ],
                                )),
                          )),
                      TextFormField(
                          focusNode: writeCommentFocusNode,
                          controller: writeCommentController,
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.greyishBrown,
                              height: 1.5),
                          onChanged: (text) {
                            setState(() {});
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
                                              color: writeCommentController
                                                      .text.isNotEmpty
                                                  ? AppColors.mediumPink
                                                  : AppColors.veryLightPink,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14,
                                              onTap: writeCommentController
                                                      .text.isNotEmpty
                                                  ? () async {
                                                      FocusScope.of(context)
                                                          .unfocus();

                                                      if (getIt<MemberInfo>()
                                                          .isGuest()) {
                                                        showSuggestLoginDialog();
                                                        return;
                                                      }

                                                      setState(() {
                                                        isSending = true;
                                                      });
                                                      final commentItem =
                                                          await writeComment(
                                                              writeCommentController
                                                                  .text);

                                                      setState(() {
                                                        isSending = false;
                                                        isSecretComment = false;
                                                      });

                                                      if (commentItem == null) {
                                                        Fluttertoast.showToast(
                                                            msg: "작성에 실패했습니다");
                                                      } else {
                                                        widget
                                                            .onCompleteWriteComment(
                                                                commentItem);
                                                        writeCommentController
                                                            .clear();
                                                      }
                                                    }
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
          )),
    );
  }

  Future<CommentItem?> writeComment(String content) async {
    try {
      final response = await getIt<ApiComment>().create(PostCommentRequest(
          contentId: widget.contentId,
          content: content,
          isSecret: isSecretComment));

      return CommentItem.fromPost(response.result);
    } catch (e) {
      safePrint("exception: $e");
    }

    return null;
  }

  void onCancelCommentWrite() {
    writeCommentController.clear();
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

  void showCommentAlertDialog(BuildContext context, void Function() onCancel) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CheckCommentCancelDialog(onCancel: onCancel);
        });
  }
}
