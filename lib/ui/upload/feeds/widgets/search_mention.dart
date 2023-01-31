import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:flutter/material.dart';

import '../items/search_mention.dart';

class SearchMentionItemWidget extends StatelessWidget {
  final SearchMentionItem item;
  final void Function() onPressed;
  const SearchMentionItemWidget(
      {Key? key, required this.item, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                  width: 40,
                  height: 40,
                  color: AppColors.veryLightPink,
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
                  style:
                      TextStyle(fontSize: 12, color: AppColors.veryLightPink),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
