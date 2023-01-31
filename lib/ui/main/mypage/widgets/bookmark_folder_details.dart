import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/constants/idx_tag.dart';
import 'package:dingmo/constants/member.dart';
import 'package:dingmo/constants/type.dart';
import 'package:dingmo/routes/arguments/arg_single_reels.dart';
import 'package:dingmo/routes/arguments/arg_view_feed_item.dart';
import 'package:dingmo/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../items/bookmark_folder_details_item.dart';

class BookmarkFolderDetailItemWidget extends StatefulWidget {
  final BookmarkFolderDetailsItem item;
  final bool isCheckable;
  const BookmarkFolderDetailItemWidget(
      {Key? key, required this.item, required this.isCheckable})
      : super(key: key);

  @override
  State<BookmarkFolderDetailItemWidget> createState() =>
      _BookmarkFolderDetailItemWidgetState();
}

class _BookmarkFolderDetailItemWidgetState
    extends State<BookmarkFolderDetailItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isCheckable) {
          setState(() {
            widget.item.isSelected = !widget.item.isSelected;
          });
        } else {
          if (widget.item.contentType == DingmoContentType.reels) {
            Navigator.pushNamed(context, Routes.singleReels,
                arguments: SingleReelsArgs(contentId: widget.item.contentId));
          } else if (widget.item.contentType == DingmoContentType.feed) {
            Navigator.pushNamed(context, Routes.viewFeedItem,
                arguments: ViewFeedItemArgs(contentId: widget.item.contentId));
          }
        }
      },
      child: Container(
          color: Colors.transparent,
          child: Stack(children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  color: AppColors.greyWhite,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: widget.item.thumbnailUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, exception, stackTrace) {
                          return Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/dingmo.png",
                            ),
                          );
                        },
                      ),
                      Visibility(
                          visible: widget.item.contentType ==
                              DingmoContentType.reels,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.black.withOpacity(0.15),
                                      Colors.transparent
                                    ],
                                  ),
                                )),
                          ))
                    ],
                  ),
                )),
            Container(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.nickname,
                          style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          widget.item.memberType == MemberType.comp
                              ? idxTagToString(widget.item.compType!)
                              : memberTypeToString(widget.item.memberType),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                        visible:
                            widget.item.contentType == DingmoContentType.reels,
                        child: Container(
                          alignment: Alignment.bottomLeft,
                          child: SvgPicture.asset(
                              "assets/home/icon_awesome_play.svg"),
                        ))
                  ],
                )),
            Align(
              alignment: Alignment.topRight,
              child: Visibility(
                  visible: widget.isCheckable,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.item.isSelected = !widget.item.isSelected;
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 10, right: 10),
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                          color: widget.item.isSelected
                              ? AppColors.mediumPink
                              : Colors.transparent,
                          border: Border.all(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(99)),
                      child: Visibility(
                        visible: widget.item.isSelected,
                        child: SvgPicture.asset(
                          "assets/mypage/check_icon.svg",
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )),
            )
          ])),
    );
  }
}
