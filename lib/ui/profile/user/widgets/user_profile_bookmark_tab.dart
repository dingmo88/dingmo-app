import 'package:cached_network_image/cached_network_image.dart';
import 'package:dingmo/constants/colors.dart';
import 'package:dingmo/routes/arguments/arg_view_feed_item.dart';
import 'package:dingmo/ui/profile/user/items/user_profile_content_item.dart';
import 'package:flutter/material.dart';

import '../../../../routes/routes.dart';
import '../../../widgets/loading.dart';

class UserProfileBookmarkTab extends StatefulWidget {
  final List<UserProfileContentItem> contents;
  final bool isLastBookmarksLoaded;
  const UserProfileBookmarkTab(
      {Key? key, required this.contents, required this.isLastBookmarksLoaded})
      : super(key: key);

  @override
  State<UserProfileBookmarkTab> createState() => _UserProfileBookmarkTabState();
}

class _UserProfileBookmarkTabState extends State<UserProfileBookmarkTab> {
  final int idx = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Column(
        children: [
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: widget.contents
                .map((content) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Routes.viewFeedItem,
                            arguments: ViewFeedItemArgs(contentId: 0));
                      },
                      child: Container(
                        color: AppColors.greyWhite,
                        child: CachedNetworkImage(
                          imageUrl: content.thumbUrl,
                          errorWidget: ((context, error, stackTrace) =>
                              Container()),
                        ),
                      ),
                    ))
                .toList(),
          ),
          Visibility(
              visible: !widget.isLastBookmarksLoaded,
              child: const DingmoProgressIndicator(
                  size: 40, margin: EdgeInsets.symmetric(vertical: 20))),
          Visibility(
              visible: widget.isLastBookmarksLoaded,
              child: const SizedBox(
                height: 40,
              )),
        ],
      ),
    );
  }
}
