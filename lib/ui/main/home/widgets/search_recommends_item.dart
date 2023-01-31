import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/ui/main/home/items/search_recommend_item.dart';
import 'package:flutter/material.dart';

class SearchRecommendsItemWidget extends StatelessWidget {
  final SearchRecommendFeedItem item;
  final void Function() onPressed;
  const SearchRecommendsItemWidget(
      {Key? key, required this.item, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * (186 / 360),
        height: 225,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: AppColors.white, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2917,
              height: MediaQuery.of(context).size.width * 0.2917,
              color: AppColors.greyWhite,
              child: CachedNetworkImage(
                  imageUrl: item.thumbUrl,
                  fit: BoxFit.cover,
                  errorWidget: (context, exception, stackTrace) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/dingmo.png",
                      ),
                    );
                  }),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.nickname,
            style: TextStyle(
                fontSize: 14,
                color: AppColors.greyishBrown,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          Text(
            item.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.greyishBrown,
            ),
          )
        ]),
      ),
    );
  }
}
