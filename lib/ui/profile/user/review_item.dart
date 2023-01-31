import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/routes/arguments/arg_view_photo.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../constants/colors.dart';
import '../../../../routes/arguments/arg_view_review_item.dart';
import '../../widgets/texts.dart';
import '../compOrPlan/items/comp_profile_item.dart';

enum ReviewItemType { inList, inComments }

class ReviewItemWidget extends StatefulWidget {
  final ReviewItemType type;
  final ReviewItem item;
  const ReviewItemWidget({Key? key, required this.item, required this.type})
      : super(key: key);

  @override
  State<ReviewItemWidget> createState() => _ReviewItemWidgetState();
}

class _ReviewItemWidgetState extends State<ReviewItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.type != ReviewItemType.inComments) {
          Navigator.pushNamed(context, Routes.viewReviewItem,
              arguments: ViewReviewItemArgs(item: widget.item));
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColors.greyWhite,
                              border: Border.all(
                                  color: AppColors.greyWhite, width: 1),
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                                imageUrl: widget.item.profileUrl,
                                fit: BoxFit.cover,
                                errorWidget: (context, exception, stackTrace) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      "assets/dingmo.png",
                                    ),
                                  );
                                }),
                          )),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.item.nickname,
                            style: TextStyle(
                                fontSize: 14,
                                color: AppColors.greyishBrown,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            widget.item.dateCreated,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.veryLightPink,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: onPressLearnMore,
                    icon: const Icon(Icons.more_horiz),
                    color: AppColors.purpleGrey,
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
                margin: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    for (int idx = 0; idx < widget.item.stars; idx++)
                      const Icon(
                        Icons.star,
                        color: Color(0xFFf7d326),
                        size: 16,
                      ),
                    for (int idx = 0; idx < 5 - widget.item.stars; idx++)
                      const Icon(
                        Icons.star,
                        color: Color(0xFFe6e6e6),
                        size: 16,
                      ),
                  ],
                )),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.item.comment,
                style: TextStyle(
                    fontSize: 14, color: AppColors.greyishBrown, height: 1.5),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.3222,
              child: ScrollConfiguration(
                  behavior: NoGlowBehavior(),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: widget.item.imgUrls.length,
                      itemBuilder: (context, index) => ReviewItemImageInList(
                          imgUrl: widget.item.imgUrls[index]))),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      FeedItemLikeButton(
                        isLiked: widget.item.isLiked,
                        likeCount: widget.item.likeCount,
                        onPressed: () {
                          setState(() {
                            widget.item.isLiked = !widget.item.isLiked;
                            widget.item.likeCount = widget.item.isLiked
                                ? widget.item.likeCount + 1
                                : widget.item.likeCount - 1;
                          });
                        },
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "도움이 되었어요",
                        style: TextStyle(
                            fontSize: 13, color: AppColors.purpleGrey),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Visibility(
                          visible: widget.type == ReviewItemType.inList,
                          maintainState: true,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.viewReviewItem,
                                  arguments:
                                      ViewReviewItemArgs(item: widget.item));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 6),
                              child: Row(
                                children: [
                                  const SizedBox(height: 25),
                                  SvgPicture.asset(
                                      "assets/home/message_icon.svg",
                                      color: AppColors.purpleGrey),
                                  const SizedBox(width: 5),
                                  Text(
                                    widget.item.commentCount.toString(),
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.purpleGrey),
                                  )
                                ],
                              ),
                            ),
                          )),
                      Visibility(
                          visible: widget.type == ReviewItemType.inComments,
                          maintainState: true,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 6),
                            child: Row(
                              children: [
                                const SizedBox(height: 25),
                                SvgPicture.asset("assets/home/message_icon.svg",
                                    color: AppColors.purpleGrey),
                                const SizedBox(width: 5),
                                Text(
                                  widget.item.commentCount.toString(),
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.purpleGrey),
                                )
                              ],
                            ),
                          )),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 15),
            const ReviewItemDivider()
          ],
        ),
      ),
    );
  }

  void showManageFeedSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Texts.defaultText(
                        text: "게시물 관리",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      iconSize: 20,
                    )
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "수정 완료", backgroundColor: AppColors.mediumPink);
                    },
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Texts.defaultText(
                          text: "수정하기",
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    )),
                GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "삭제 처리되었습니다",
                          backgroundColor: AppColors.mediumPink);
                    },
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Texts.defaultText(
                          text: "삭제하기",
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }

  void onPressLearnMore() {
    widget.item.isMine ? showManageFeedSheet() : showReportOrBanSheet();
  }

  void showReportSheet() {
    showModalBottomSheet<void>(
        backgroundColor: Colors.white,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Wrap(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Texts.defaultText(
                        text: "신고하기",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      iconSize: 20,
                    )
                  ],
                ),
              ),
              ...([
                "주제에 맞지 않는 글",
                "과도한 욕설",
                "음란물",
                "폭력적인 내용",
                "불법광고",
                "기타",
              ].map((areaName) => TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "신고가 접수되었습니다",
                        backgroundColor: AppColors.mediumPink);
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.transparent,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      areaName,
                      style: TextStyle(
                          fontSize: 14, color: AppColors.greyishBrown),
                    ),
                  )))),
            ],
          );
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
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Container(
            padding: const EdgeInsets.only(left: 20, top: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Texts.defaultText(
                        text: "신고/차단",
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                      iconSize: 20,
                    )
                  ],
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      showReportSheet();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Texts.defaultText(
                          text: "신고하기",
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    )),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "차단 완료", backgroundColor: AppColors.mediumPink);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Texts.defaultText(
                          text: "계정 차단하기",
                          fontSize: 14,
                          fontWeight: FontWeight.normal),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}

class ReviewItemImageInList extends StatelessWidget {
  final String imgUrl;
  const ReviewItemImageInList({Key? key, required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.viewPhoto,
            arguments: ViewPhotoArgs(imageProviders: [NetworkImage(imgUrl)]));
      },
      child: Container(
        color: AppColors.greyWhite,
        width: MediaQuery.of(context).size.width * 0.3222,
        height: MediaQuery.of(context).size.width * 0.3222,
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          errorWidget: (context, exception, stackTrace) {
            return Container();
          },
        ),
      ),
    );
  }
}

class ReviewItemImagePlaceholderInList extends StatelessWidget {
  const ReviewItemImagePlaceholderInList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.greyWhite,
        width: MediaQuery.of(context).size.width * 0.3222,
        height: MediaQuery.of(context).size.width * 0.3222);
  }
}

class ReviewItemImageInComments extends StatelessWidget {
  final String imgUrl;
  const ReviewItemImageInComments({Key? key, required this.imgUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.viewPhoto,
          arguments: ViewPhotoArgs(imageProviders: [NetworkImage(imgUrl)]),
        );
      },
      child: Container(
        color: AppColors.greyWhite,
        width: MediaQuery.of(context).size.width * 0.3222,
        height: MediaQuery.of(context).size.width * 0.3222,
        child: CachedNetworkImage(
          imageUrl: imgUrl,
          errorWidget: (context, exception, stackTrace) {
            return Container();
          },
        ),
      ),
    );
  }
}

class FeedItemLikeButton extends StatefulWidget {
  final bool isLiked;
  final int likeCount;
  final void Function() onPressed;
  const FeedItemLikeButton({
    Key? key,
    required this.isLiked,
    required this.likeCount,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<FeedItemLikeButton> createState() => _FeedItemLikeButtonState();
}

class _FeedItemLikeButtonState extends State<FeedItemLikeButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Row(
        children: [
          Container(
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
              child: widget.isLiked
                  ? SvgPicture.asset(
                      "assets/home/like_off_feed_icon.svg",
                      color: AppColors.mediumPink,
                    )
                  : SvgPicture.asset(
                      "assets/home/like_off_feed_icon.svg",
                      color: AppColors.purpleGrey,
                    )),
          Text(
            widget.likeCount.toString(),
            style: TextStyle(
                fontSize: 13,
                color: widget.isLiked
                    ? AppColors.mediumPink
                    : AppColors.purpleGrey),
          ),
        ],
      ),
    );
  }
}

class ReviewItemDivider extends StatelessWidget {
  const ReviewItemDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 4,
      color: AppColors.greyWhite,
    );
  }
}
