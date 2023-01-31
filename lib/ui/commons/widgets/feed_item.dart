import 'package:amplify_core/amplify_core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/api/api_bmk_folder.dart';
import 'package:dingmo/api/api_bmk_item.dart';
import 'package:dingmo/api/api_board.dart';
import 'package:dingmo/api/api_like.dart';
import 'package:dingmo/api/commons/endpoints.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/di/service_locator.dart';
import 'package:dingmo/routes/arguments/arg_feed_update.dart';
import 'package:dingmo/ui/commons/items/feed_item.dart';
import 'package:dingmo/routes/arguments/arg_view_photo.dart';
import 'package:dingmo/routes/arguments/arg_view_feed_item.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:dingmo/routes/arguments/args_search_result.dart';
import 'package:dingmo/ui/widgets/bookmark_button.dart';
import 'package:dingmo/ui/widgets/content_manage_sheet.dart';
import 'package:dingmo/ui/widgets/select_bmk_folder_sheet.dart';
import 'package:dingmo/ui/widgets/suggest_login_dialog.dart';
import 'package:dingmo/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;

import '../../../constants/colors.dart';
import '../../widgets/texts.dart';

enum FeedItemType { inList, inComments }

class FeedItemWidget extends StatefulWidget {
  final FeedItemType type;
  final FeedItem item;
  final void Function() onUpdated;
  const FeedItemWidget(
      {Key? key,
      required this.item,
      required this.type,
      required this.onUpdated})
      : super(key: key);

  @override
  State<FeedItemWidget> createState() => _FeedItemWidgetState();
}

class _FeedItemWidgetState extends State<FeedItemWidget> {
  late final List<CachedNetworkImageProvider> _imageProviders;
  late final Future<void> _preloadImageFuture;

  Future<void> preloadImages() async {
    for (var image in widget.item.images) {
      await precacheImage(
          NetworkImage(path.join(Endpoints.imgUrl, image.thumbKey)), context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _preloadImageFuture = preloadImages();
  }

  @override
  void initState() {
    super.initState();
    _imageProviders = widget.item.images
        .map((image) => CachedNetworkImageProvider(path.join(
              Endpoints.imgUrl,
              image.imgKey,
            )))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.type == FeedItemType.inList) {
          Navigator.pushNamed(context, Routes.viewFeedItem,
              arguments: ViewFeedItemArgs(contentId: 0));
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
                              child: widget.item.profileUrl != null
                                  ? CachedNetworkImage(
                                      imageUrl: widget.item.profileUrl!,
                                      fit: BoxFit.cover,
                                      errorWidget:
                                          (context, exception, stackTrace) {
                                        return Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          alignment: Alignment.center,
                                          child: Image.asset(
                                            "assets/dingmo.png",
                                          ),
                                        );
                                      })
                                  : Image.asset("assets/dingmo.png"),
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
                    Row(
                      children: [
                        IconButton(
                          onPressed: onPressLearnMore,
                          icon: const Icon(Icons.more_horiz),
                          color: AppColors.purpleGrey,
                        ),
                        const SizedBox(width: 10),
                        FeedBookmarkButton(
                          bmkId: widget.item.bmkId,
                          contentId: widget.item.contentId,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Visibility(
                  visible: widget.type == FeedItemType.inList,
                  maintainState: true,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width,
                    child: FutureBuilder<void>(
                        future: _preloadImageFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const FeedItemImagePlaceholderInList();
                          } else {
                            return ScrollConfiguration(
                                behavior: NoGlowBehavior(),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const PageScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: widget.item.images.length,
                                    itemBuilder: (context, index) =>
                                        FeedItemImageInList(
                                            thumbKey: widget
                                                .item.images[index].thumbKey)));
                          }
                        }),
                  )),
              Visibility(
                  visible: widget.type == FeedItemType.inComments,
                  maintainState: true,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.width * 0.3222,
                    child: ScrollConfiguration(
                      behavior: NoGlowBehavior(),
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget.item.images.length,
                          itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.only(
                                    right:
                                        index >= widget.item.images.length - 1
                                            ? 0
                                            : 5),
                                child: FeedItemImageInComments(
                                  image: widget.item.images[index],
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.viewPhoto,
                                      arguments: ViewPhotoArgs(
                                          initViewIdx: index,
                                          imageProviders: _imageProviders),
                                    );
                                  },
                                ),
                              )),
                    ),
                  )),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  widget.item.description,
                  style: TextStyle(
                      fontSize: 14, color: AppColors.greyishBrown, height: 1.5),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: widget.item.mentions
                        .map((mention) => FeedItemMention(
                            name: mention.nickname,
                            onPressed: () {
                              // mention.profileId;
                              Fluttertoast.showToast(msg: "coming soon!");
                            }))
                        .toList()),
              ),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: widget.item.tags
                        .map((tag) => tag.isNotEmpty
                            ? FeedItemTagChip(
                                name: "#$tag",
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.searchResult,
                                      arguments:
                                          SearchResultArgs(keyword: tag));
                                },
                              )
                            : Container())
                        .toList(),
                  )),
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
                          onPressed: () async {
                            if (getIt<MemberInfo>().isGuest()) {
                              showSuggestLoginDialog(context);
                              return;
                            }

                            switchLike();
                            if (!(await like(widget.item.isLiked))) {
                              switchLike();
                              Fluttertoast.showToast(msg: "문제가 발생하였습니다");
                            }
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
                            visible: widget.type == FeedItemType.inList,
                            maintainState: true,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.viewFeedItem,
                                    arguments: ViewFeedItemArgs(contentId: 0));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 6),
                                child: Row(
                                  children: [
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
                            visible: widget.type == FeedItemType.inComments,
                            maintainState: true,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 6),
                              child: Row(
                                children: [
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
                            )),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const FeedItemDivider()
            ],
          )),
    );
  }

  void switchLike() {
    setState(() {
      widget.item.isLiked = !widget.item.isLiked;
      widget.item.likeCount = widget.item.isLiked
          ? widget.item.likeCount + 1
          : widget.item.likeCount - 1;
    });
  }

  Future<bool> like(bool isLiked) async {
    try {
      await getIt<ApiLike>().submit(PostLikeRequest(
          likeType: likeTypeToValue(LikeType.content),
          atId: widget.item.contentId,
          isLike: isLiked));

      return true;
    } catch (e) {
      safePrint("exception: $e");
    }

    return false;
  }

  void showManageFeedSheet() {
    showModalBottomSheet<void>(
      enableDrag: false,
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (BuildContext context) {
        return ContentManageSheet(
            contentId: widget.item.contentId,
            onEdit: () {
              Navigator.pushNamed(context, Routes.feedUpdate,
                      arguments:
                          FeedUpdateArgs(contentId: widget.item.contentId))
                  .then((isOk) {
                if (isOk == true) {
                  widget.onUpdated();
                }
              });
            },
            onDelete: _deleteFeed,
            onAfterDelete: () {
              Navigator.pop(context);
            });
      },
    );
  }

  Future<bool> _deleteFeed() async {
    try {
      await getIt<ApiBoard>()
          .delete(DeleteBoardRequest(contentId: widget.item.contentId));
      return true;
    } catch (e) {
      safePrint("exception: $e");
    }
    return false;
  }

  void onPressLearnMore() {
    // widget.item.isMine ? showManageFeedSheet() : showReportOrBanSheet();
    widget.item.isMine
        ? showManageFeedSheet()
        : Fluttertoast.showToast(msg: "coming soon!");
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

class FeedItemImageInList extends StatelessWidget {
  final String thumbKey;
  const FeedItemImageInList({Key? key, required this.thumbKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.greyWhite,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      child: CachedNetworkImage(
        imageUrl: path.join(Endpoints.imgUrl, thumbKey),
        errorWidget: (context, exception, stackTrace) {
          return Container();
        },
        fit: BoxFit.cover,
      ),
    );
  }
}

class FeedItemImagePlaceholderInList extends StatelessWidget {
  const FeedItemImagePlaceholderInList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.greyWhite,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width);
  }
}

class FeedItemImageInComments extends StatelessWidget {
  final BoardImage image;
  final void Function() onTap;
  const FeedItemImageInComments(
      {Key? key, required this.image, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppColors.greyWhite,
        width: MediaQuery.of(context).size.width * 0.3222,
        height: MediaQuery.of(context).size.width * 0.3222,
        child: CachedNetworkImage(
          imageUrl: path.join(Endpoints.imgUrl, image.thumbKey),
          errorWidget: (context, exception, stackTrace) {
            return Container();
          },
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class FeedItemMention extends StatelessWidget {
  final String name;
  final void Function() onPressed;
  const FeedItemMention({Key? key, required this.name, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        "@$name",
        style: TextStyle(fontSize: 12, color: AppColors.mediumPink),
      ),
    );
  }
}

class FeedItemTagChip extends StatelessWidget {
  final String name;
  final void Function() onPressed;
  const FeedItemTagChip({Key? key, required this.name, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Chip(
          backgroundColor: AppColors.greyWhite,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          label: Text(
            name,
            style: TextStyle(fontSize: 12, color: AppColors.purpleGrey),
          )),
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

class FeedItemDivider extends StatelessWidget {
  const FeedItemDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 4,
      color: AppColors.greyWhite,
    );
  }
}
