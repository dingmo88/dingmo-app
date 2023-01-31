import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../items/feed_upload_mention.dart';

class FeedUploadMentionItemWidget extends StatelessWidget {
  final FeedUploadMentionItem item;
  final void Function() onDelete;
  const FeedUploadMentionItemWidget(
      {Key? key, required this.item, required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                  width: 28,
                  height: 28,
                  child: CachedNetworkImage(
                    imageUrl: item.profileUrl,
                    errorWidget: (context, error, stackTrace) => Container(),
                  )),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nickname,
                  style: TextStyle(
                      fontSize: 14,
                      color: AppColors.greyishBrown,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  item.categoryName,
                  style: TextStyle(fontSize: 12, color: AppColors.purpleGrey),
                )
              ],
            )
          ],
        ),
        GestureDetector(
          onTap: onDelete,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            child: SvgPicture.asset(
                "assets/home/make_contents/tag_delete_icon.svg"),
          ),
        )
      ]),
    );
  }
}
