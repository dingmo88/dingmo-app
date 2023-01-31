import 'dart:async';

import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_comment.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/ui/commons/items/comment_state.dart';
import 'package:dingmo/ui/widgets/comment_form_panel.dart';
import 'package:dingmo/ui/widgets/comment_item.dart';
import 'package:dingmo/ui/widgets/infinity_list.dart';
import 'package:dingmo/ui/widgets/loading.dart';
import 'package:dingmo/ui/widgets/reply_draggable.dart';
import 'package:dingmo/ui/widgets/texts.dart';
import 'package:dingmo/utils/typedef.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReelsCommentsDraggableSheet extends StatefulWidget {
  final int contentId;
  final VoidFuncFuture? onLoginSuggestStarted;
  final VoidFuncFuture? onLoginSuggestEnded;
  const ReelsCommentsDraggableSheet(
      {Key? key,
      required this.contentId,
      this.onLoginSuggestStarted,
      this.onLoginSuggestEnded})
      : super(key: key);

  @override
  State<ReelsCommentsDraggableSheet> createState() =>
      _ReelsCommentsDraggableSheetState();
}

class _ReelsCommentsDraggableSheetState
    extends State<ReelsCommentsDraggableSheet> {
  late final InfinityListController<CommentItem> commentListController;

  @override
  void initState() {
    super.initState();

    commentListController = InfinityListController(onAddItemFirst: (item) {
      commentListController.animateToTop(
          const Duration(milliseconds: 300), Curves.ease);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize:
          MediaQuery.of(context).viewInsets.bottom > 0 ? 0.9 : 0.6,
      minChildSize: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.9 : 0.6,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Texts.defaultText(
                          text: "댓글",
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
                child: CommentFormPanel(
                    contentId: widget.contentId,
                    onLoginSuggestStarted: widget.onLoginSuggestStarted,
                    onLoginSuggestEnded: widget.onLoginSuggestEnded,
                    contentWidget: InfinityListWidget<CommentItem>(
                        controller: commentListController,
                        scrollController: scrollController,
                        onLoad: getCommentList,
                        pageSize: 20,
                        itemBuilder: (context, item, index) =>
                            CommentItemWidget(
                              commentItem: item,
                              onShowReplies: () async {
                                CommentState.item = item;
                                showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => RepliesDraggableSheet(
                                          contentId: widget.contentId,
                                          commentId: item.cmtId,
                                          onLoginSuggestStarted:
                                              widget.onLoginSuggestStarted,
                                          onLoginSuggestEnded:
                                              widget.onLoginSuggestEnded,
                                        ));
                              },
                              onDelete: () => onCompleteDeleteComment(item),
                            ),
                        initLoadingBuilder: (BuildContext context) {
                          return Container(
                              color: Colors.white,
                              padding: const EdgeInsets.only(top: 40),
                              alignment: Alignment.topCenter,
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: const DingmoProgressIndicator(size: 40));
                        }),
                    onCompleteWriteComment: onCompleteWriteComment),
              )
            ],
          ),
        );
      },
    );
  }

  void onCompleteDeleteComment(CommentItem item) {
    commentListController.remove(item);

    Fluttertoast.showToast(msg: "삭제 완료.");
  }

  void onCompleteWriteComment(CommentItem newItem) {
    commentListController.addItemLast(newItem);

    Fluttertoast.showToast(msg: "작성되었습니다.");
  }

  Future<List<CommentItem>?> getCommentList(int page, int size) async {
    try {
      if (getIt<MemberInfo>().isGuest()) {
        final response = await getIt<ApiComment>().getGuestList(
            GetCommentListRequest(
                contentId: widget.contentId, page: page, size: size));

        return response.result.map(CommentItem.fromGet).toList();
      } else {
        final response = await getIt<ApiComment>().getList(
            GetCommentListRequest(
                contentId: widget.contentId, page: page, size: size));

        return response.result.map(CommentItem.fromGet).toList();
      }
    } catch (e) {
      safePrint("exception: $e");
    }

    return null;
  }
}
