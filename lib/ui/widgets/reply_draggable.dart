import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_reply.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/commons/items/comment_state.dart';
import 'package:dingmo/ui/widgets/infinity_list.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:dingmo/ui/widgets/reply_form_panel.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'comment_item.dart';
import 'reply_item.dart';

class RepliesDraggableSheet extends StatefulWidget {
  final int contentId;
  final int commentId;
  final VoidFuncFuture? onLoginSuggestStarted;
  final VoidFuncFuture? onLoginSuggestEnded;
  const RepliesDraggableSheet(
      {Key? key,
      required this.contentId,
      required this.commentId,
      this.onLoginSuggestStarted,
      this.onLoginSuggestEnded})
      : super(key: key);

  @override
  State<RepliesDraggableSheet> createState() => _RepliesDraggableSheetState();
}

class _RepliesDraggableSheetState extends State<RepliesDraggableSheet>
    with SingleTickerProviderStateMixin {
  final CommentItem commentItem = CommentState.item!;
  final InfinityListController<CommentReplyItem> replyListController =
      InfinityListController();
  final ReplyFormPanelController formPanelController =
      ReplyFormPanelController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize:
          MediaQuery.of(context).viewInsets.bottom > 0 ? 0.9 : 0.6,
      minChildSize: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.9 : 0.6,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return ReplyFormPanel(
          contentId: widget.contentId,
          commentItem: commentItem,
          onLoginSuggestStarted: widget.onLoginSuggestStarted,
          onLoginSuggestEnded: widget.onLoginSuggestEnded,
          controller: formPanelController,
          contentWidget: Column(children: [
            Container(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Texts.defaultText(
                        text: "답글",
                        fontSize: 16,
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.close,
                          color: AppColors.greyishBrown,
                          size: 15,
                        ),
                      )
                    ])),
            Expanded(
                child: InfinityListWidget<CommentReplyItem>(
                    controller: replyListController,
                    scrollController: scrollController,
                    header: CommentItemWidget(
                      inReply: true,
                      commentItem: commentItem,
                    ),
                    onLoad: getReplyList,
                    pageSize: 20,
                    itemBuilder: (context, item, index) {
                      return CommentReplyItemWidget(
                        replyItem: item,
                        onTap: (replyItem) =>
                            formPanelController.openForm(replyItem),
                        onDelete: () => onCompleteDeleteReply(item),
                      );
                    },
                    initLoadingBuilder: (BuildContext context) {
                      return Container(
                          padding: const EdgeInsets.only(top: 40),
                          alignment: Alignment.topCenter,
                          height: MediaQuery.of(context).size.height * 0.6,
                          color: Colors.white,
                          child: const DingmoProgressIndicator(size: 40));
                    })),
          ]),
          onCompleteWriteReply: onCompleteWriteReply,
        );
      },
    );
  }

  void onCompleteDeleteReply(CommentReplyItem item) {
    replyListController.remove(item);

    Fluttertoast.showToast(msg: "삭제 완료.");
  }

  void onCompleteWriteReply(CommentReplyItem newItem) {
    replyListController.addItemLast(newItem);

    Fluttertoast.showToast(msg: "작성되었습니다.");
  }

  Future<List<CommentReplyItem>?> getReplyList(int page, int size) async {
    try {
      if (getIt<MemberInfo>().isGuest()) {
        final response = await getIt<ApiReply>().getGuestList(GetReplyRequest(
            commentId: widget.commentId, page: page, size: size));

        return response.result.map(CommentReplyItem.fromGet).toList();
      } else {
        final response = await getIt<ApiReply>().getList(GetReplyRequest(
            commentId: widget.commentId, page: page, size: size));

        return response.result.map(CommentReplyItem.fromGet).toList();
      }
    } catch (e) {
      safePrint("exception: $e");
    }

    return null;
  }
}
