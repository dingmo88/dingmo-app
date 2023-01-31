import 'package:dingmo/ui/profile/user/review_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/comment_form_panel.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../commons/items/comment_state.dart';
import '../../widgets/comment_item.dart';
import '../../widgets/infinity_list.dart';
import '../../widgets/reply_draggable.dart';
import 'items/comp_profile_item.dart';

class ViewReviewItemPage extends StatefulWidget {
  final ReviewItem item;
  const ViewReviewItemPage({Key? key, required this.item}) : super(key: key);

  @override
  State<ViewReviewItemPage> createState() => _ViewReviewItemPageState();
}

class _ViewReviewItemPageState extends State<ViewReviewItemPage> {
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
    return Scaffold(
      appBar: AppBars.defaultAppBar(context, title: "댓글"),
      body: SafeArea(
          child: CommentFormPanel(
        contentId: 0,
        contentWidget: ScrollConfiguration(
            behavior: NoGlowBehavior(),
            child: InfinityListWidget<CommentItem>(
              controller: commentListController,
              header: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ReviewItemWidget(
                      type: ReviewItemType.inComments, item: widget.item)),
              itemBuilder: (context, item, index) => CommentItemWidget(
                commentItem: item,
                onShowReplies: () async {
                  CommentState.item = item;
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const RepliesDraggableSheet(
                            commentId: 0,
                            contentId: 0,
                          ));
                },
                onDelete: () {},
              ),
              onLoad: getCommentList,
              pageSize: 20,
            )),
        onCompleteWriteComment: (CommentItem newItem) {
          commentListController.addItemLast(newItem);

          Fluttertoast.showToast(msg: "작성되었습니다.");
        },
      )),
    );
  }

  int loadCount = 0;
  Future<List<CommentItem>> getCommentList(int startIdx, int pageSize) async {
    return Future.delayed(const Duration(seconds: 1), () {
      final List<CommentItem> newItems = [];

      if (loadCount > 4) {
        return newItems;
      }

      loadCount++;
      return newItems;
    });
  }
}
