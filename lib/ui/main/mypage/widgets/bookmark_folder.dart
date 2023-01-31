import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/ui/main/mypage/items/bookmark_folder_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constants/colors.dart';
import 'dotted_border.dart';

class BookmarkFolderItemWidget extends StatelessWidget {
  final BookmarkFolderItem item;
  final void Function() onPressed;
  const BookmarkFolderItemWidget(
      {Key? key, required this.item, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Stack(
              children: [
                CachedNetworkImage(
                  width: double.infinity,
                  height: double.infinity,
                  imageUrl: item.lastItemThumbUrl,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Container(),
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.black.withOpacity(0.6),
                    alignment: Alignment.center,
                    child: Text(
                      item.folderName,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    )),
                Visibility(
                    visible: item.isSecret,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                          padding: const EdgeInsets.only(top: 15, right: 15),
                          child: Opacity(
                            opacity: 0.8,
                            child:
                                SvgPicture.asset("assets/mypage/lock_icon.svg"),
                          )),
                    ))
              ],
            ),
          )),
    );
  }
}

class BookmarkAddFolderButton extends StatelessWidget {
  final void Function() onPressed;
  const BookmarkAddFolderButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: DottedBorder(
          color: AppColors.veryLightPink,
          radius: const Radius.circular(5),
          borderType: BorderType.rrect,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "폴더 추가",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColors.greyishBrown,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    SvgPicture.asset("assets/mypage/folder_plus_icon.svg")
                  ]),
            ),
          )),
    );
  }
}
