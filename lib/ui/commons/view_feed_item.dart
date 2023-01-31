import 'package:amplify_core/amplify_core.dart';
import 'package:dingmo/api/api_board.dart';
import 'package:dingmo/api/api_comment.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_view_feed_item.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/ui/commons/widgets/feed_item.dart';
import 'package:dingmo/ui/widgets/appbars.dart';
import 'package:dingmo/ui/widgets/comment_form_panel.dart';
import 'package:dingmo/ui/widgets/infinity_list.dart';
import 'package:dingmo/utils/time/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

import '../../constants/colors.dart';
import 'items/comment_state.dart';
import '../widgets/comment_item.dart';
import '../widgets/reply_draggable.dart';
import 'items/feed_item.dart';

class ViewFeedItemPage extends StatefulWidget {
  final int contentId;
  const ViewFeedItemPage({Key? key, required this.contentId}) : super(key: key);

  @override
  State<ViewFeedItemPage> createState() => _ViewFeedItemPageState();
}

class _ViewFeedItemPageState extends State<ViewFeedItemPage>
    with SingleTickerProviderStateMixin {
  late final InfinityListController<CommentItem> commentListController;

  @override
  void initState() {
    super.initState();
    commentListController = InfinityListController(
        onAddItemFirst: (item) => commentListController.animateToTop(
            const Duration(microseconds: 300), Curves.ease));
  }

  Future<FeedItem?> _getFeedItem() {
    return _getBoard().then((result) {
      if (result == null) {
        Fluttertoast.showToast(msg: "잘못된 접근입니다");
        Navigator.pop(context);
      } else {
        return FeedItem(
            contentId: result.contentId,
            profileUrl: result.profiImgKey != null
                ? path.join(Endpoints.imgUrl, result.profiImgKey)
                : null,
            nickname: result.nickname,
            description: result.description,
            dateCreated: TimeUtils.dtToDisplayStr(result.createdDt),
            images: result.images,
            mentions: result.mentions,
            tags: result.tags,
            likeCount: result.likeCnt,
            commentCount: result.commentCnt,
            bmkId: result.bmkId,
            isLiked: result.isLike,
            isMine: result.isMine);
      }

      return null;
    });
  }

  Future<GetBoardResult?> _getBoard() async {
    try {
      final response = getIt<MemberInfo>().isGuest()
          ? await getIt<ApiBoard>()
              .getGuest(GetBoardRequest(contentId: widget.contentId))
          : await getIt<ApiBoard>()
              .get(GetBoardRequest(contentId: widget.contentId));
      return response.result;
    } catch (e) {
      safePrint("exception: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FeedItem?>(
        future: _getFeedItem(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.mediumPink,
                ),
              ),
            );
          } else {
            if (snapshot.data == null) {
              return Container();
            }

            return Scaffold(
              appBar: AppBars.defaultAppBar(context, title: "댓글"),
              body: SafeArea(
                  child: CommentFormPanel(
                contentId: widget.contentId,
                contentWidget: InfinityListWidget<CommentItem>(
                  controller: commentListController,
                  header: FeedItemWidget(
                      onUpdated: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.viewFeedItem,
                            arguments:
                                ViewFeedItemArgs(contentId: widget.contentId));
                      },
                      item: snapshot.data!,
                      type: FeedItemType.inComments),
                  itemBuilder: (context, item, index) => CommentItemWidget(
                    commentItem: item,
                    onDelete: () => onCompleteDeleteComment(item),
                    onShowReplies: () async {
                      CommentState.item = item;
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => RepliesDraggableSheet(
                              contentId: widget.contentId,
                              commentId: item.cmtId));
                    },
                  ),
                  onLoad: getCommentList,
                  pageSize: 20,
                ),
                onCompleteWriteComment: onCompleteWriteComment,
              )),
            );
          }
        });
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
